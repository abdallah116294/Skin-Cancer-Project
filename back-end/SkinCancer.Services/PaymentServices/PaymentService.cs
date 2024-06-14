using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.PaymentDtos;
using SkinCancer.Repositories.Interface;
using SkinCancer.Repositories.Repository;
using SkinCancer.Services.ClinicServices;
using Stripe;
using Stripe.Checkout;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SkinCancer.Services.PaymentServices
{
    public class PaymentService : IPaymentService
    {
        private readonly IConfiguration _configuration;
        private readonly ILogger<PaymentService> _logger;
        private readonly IUnitOfWork _unitOfWork;
        private static string s_wasmClientURL = string.Empty;

        public PaymentService(IConfiguration configuration,
                              ILogger<PaymentService> logger,
                              IUnitOfWork unitOfWork)
        {
            _configuration = configuration;
            _logger = logger;
            s_wasmClientURL = _configuration["ClientURLs:Production"]; // Ensure this is correctly configured
            _unitOfWork = unitOfWork;
        }


        public async Task<PaymentOrderResponse> PaymentOrderService(PaymentDto paymentDto, string referer, string thisApiUrl)
        {
            try
            {
                var s_wasmClientURL = string.IsNullOrEmpty(referer)
                    ? _configuration["ClientURLs:Default"]
                    : referer;

                _logger.LogInformation($"Referer: {referer}");
                _logger.LogInformation($"Client URL: {s_wasmClientURL}");

                if (string.IsNullOrEmpty(thisApiUrl))
                {
                    throw new InvalidOperationException("API URL is not available.");
                }

                var session = await CreatePaymentSession(paymentDto, thisApiUrl);
                var publishKey = _configuration["Stripe:PublishKey"];
                var returnUrl = session.Url;

                var paymentOrderResponse = new PaymentOrderResponse
                {
                    SessionId = session.Id,
                    PublishKey = publishKey,
                    Url = returnUrl
                };

                return paymentOrderResponse;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while processing the payment order.");
                throw;
            }
        }

        public async Task<Session> CreatePaymentSession(PaymentDto paymentDto, string thisApiUrl)
        {
            try
            {
                var clinic = await _unitOfWork.Reposirory<Clinic>().GetByIdAsync(paymentDto.ClinicId);
                if (clinic == null)
                {
                    _logger.LogWarning($"No Clinic found with ID {paymentDto.ClinicId}");
                    throw new Exception("The clinic with the provided ID does not exist.");
                }

                var options = new SessionCreateOptions
                {
                    SuccessUrl = $"{thisApiUrl}/api/payment/success?sessionId={{CHECKOUT_SESSION_ID}}",
                    CancelUrl = $"{s_wasmClientURL}/failed",
                    PaymentMethodTypes = new List<string> { "card" },
                    LineItems = new List<SessionLineItemOptions>
                    {
                        new SessionLineItemOptions
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

                _logger.LogInformation($"Creating Stripe session with options: {JsonConvert.SerializeObject(options)}");

                var service = new SessionService();
                var session = await service.CreateAsync(options);

                return session;
            }
            catch (StripeException ex)
            {
                _logger.LogError(ex, "Stripe error occurred while creating the payment session.");
                throw new Exception("A Stripe error occurred while creating the payment session. Please check your Stripe configuration and try again.");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while creating the payment session.");
                throw new Exception("An unexpected error occurred while creating the payment session. Please try again later.");
            }
        }
    }
}
