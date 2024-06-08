using Microsoft.AspNetCore.Hosting.Server;
using Microsoft.AspNetCore.Hosting.Server.Features;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.PaymentDtos;
using SkinCancer.Repositories.Interface;
using SkinCancer.Services.ClinicServices;
using Stripe;
using Stripe.Checkout;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SkinCancer.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PaymentController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly IClinicService _clinicService;
        private readonly IUnitOfWork _unitOfWork;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly ILogger<PaymentController> _logger;
        private static string s_wasmClientURL = string.Empty;

        public PaymentController(IConfiguration configuration,
                                 IClinicService clinicService,
                                 IUnitOfWork unitOfWork,
                                 UserManager<ApplicationUser> userManager,
                                 ILogger<PaymentController> logger)
        {
            _configuration = configuration;
            _clinicService = clinicService;
            _unitOfWork = unitOfWork;
            _userManager = userManager;
            _logger = logger;
        }

        [HttpPost("PaymentOrder")]
        public async Task<ActionResult> PaymentOrder([FromBody] PaymentDto paymentDto,
                                                     [FromServices] IServiceProvider sp)
        {
            try
            {
                var referer = Request.Headers.Referer;
                s_wasmClientURL = referer[0];

                var server = sp.GetRequiredService<IServer>();
                var serverAddressesFeature = server.Features.Get<IServerAddressesFeature>();
                string? thisApiUrl = serverAddressesFeature?.Addresses.FirstOrDefault();

                if (thisApiUrl is not null)
                {
                    var session = await CreatePaymentSession(paymentDto, thisApiUrl);
                    var publishKey = _configuration["Stripe:PublishKey"];

                    var returnUrl = session.Url;

                    var paymentOrderResponse = new PaymentOrderResponse
                    {
                        SessionId = session.Id,
                        PublishKey = publishKey,
                        Url = returnUrl
                    };

                    return Ok(paymentOrderResponse);
                }
                else
                {
                    return StatusCode(500);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while processing the payment order.");
                return StatusCode(500, "An error occurred while processing the payment order.");
            }
        }

        [NonAction]
        private async Task<Session> CreatePaymentSession(PaymentDto paymentDto, string thisApiUrl)
        {
            try
            {
                var clinic = await _unitOfWork.Reposirory<Clinic>().GetByIdAsync(paymentDto.ClinicId);
                if (clinic == null)
                {
                    _logger.LogWarning($"No Clinic found with ID {paymentDto.ClinicId}");
                    throw new Exception("No Clinic Found With this Id");
                }

                var patient = await _userManager.FindByIdAsync(paymentDto.PatientId);
                if (patient == null)
                {
                    _logger.LogWarning($"No Patient found with ID {paymentDto.PatientId}");
                    throw new Exception("No Patient Found With this Id");
                }

                var schedule = await _unitOfWork.Reposirory<Schedule>().GetByIdAsync(paymentDto.ScheduleId);
                if (schedule == null)
                {
                    _logger.LogWarning($"No Schedule found with ID {paymentDto.ScheduleId}");
                    throw new Exception("No Schedule Found With this Id");
                }

                if (schedule.ClinicId != paymentDto.ClinicId)
                {
                    _logger.LogWarning("Clinic ID mismatch in schedule.");
                    throw new Exception("This Clinic doesn't contain this schedule");
                }

                if (schedule.PatientId != paymentDto.PatientId)
                {
                    _logger.LogWarning("Patient ID mismatch in schedule.");
                    throw new Exception("This patient hasn't booked an appointment within this clinic's schedule.");
                }

                var options = new SessionCreateOptions
                {
                    SuccessUrl = $"{thisApiUrl}/checkout/success?sessionId={{CHECKOUT_SESSION_ID}}",
                    CancelUrl = $"{s_wasmClientURL}failed",
                    PaymentMethodTypes = new List<string> { "card" },
                    LineItems = new List<SessionLineItemOptions>
                    {
                        new()
                        {
                            PriceData = new SessionLineItemPriceDataOptions
                            {
                                UnitAmount = (long)clinic.Price * 100,
                                Currency = "USD",
                                ProductData = new SessionLineItemPriceDataProductDataOptions
                                {
                                    Name = clinic.Name,
                                    Description = clinic.Description,
                                    Images = new List<string> { clinic.Image }
                                },
                            },
                            Quantity = 1,
                        },
                    },
                    Mode = "payment"
                };

                var service = new SessionService();
                var session = await service.CreateAsync(options);

                return session;
            }
            catch (StripeException ex)
            {
                _logger.LogError(ex, "Stripe error occurred while creating the payment session.");
                throw new Exception("An error occurred while creating the payment session with Stripe. Please try again.");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while creating the payment session.");
                throw new Exception("An error occurred while creating the payment session. Please try again.");
            }
        }

        [HttpGet("Success")]
        public ActionResult Success(string sessionId, string publishKey)
        {
            try
            {
                var sessionService = new SessionService();
                var session = sessionService.Get(sessionId);

                if (session == null)
                {
                    _logger.LogWarning($"Invalid session ID: {sessionId}");
                    return BadRequest("Invalid session ID.");
                }

                var total = session.AmountTotal ?? 0;
                var customerEmail = session.CustomerDetails?.Email;

                return Redirect($"{s_wasmClientURL}Success");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while processing the payment success.");
                return StatusCode(500, "An error occurred while processing the payment success.");
            }
        }
    }
}
