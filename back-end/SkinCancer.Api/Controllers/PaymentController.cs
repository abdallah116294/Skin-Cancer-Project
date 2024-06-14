using Microsoft.AspNetCore.Hosting.Server;
using Microsoft.AspNetCore.Hosting.Server.Features;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.PaymentDtos;
using SkinCancer.Services.PaymentServices;
using Stripe.Checkout;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace SkinCancer.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PaymentController : ControllerBase
    {
        private readonly IPaymentService _paymentService;
        private readonly IConfiguration _configuration;
        private readonly ILogger<PaymentController> _logger;

        public PaymentController(IConfiguration configuration,
                                 ILogger<PaymentController> logger,
                                 IPaymentService paymentService)
        {
            _configuration = configuration;
            _logger = logger;
            _paymentService = paymentService;
        }

        [HttpPost("PaymentOrder")]
        public async Task<ActionResult> PaymentOrder([FromBody] PaymentDto paymentDto,
                                                     [FromServices] IServiceProvider sp)
        {
            try
            {
                var referer = Request.Headers["Referer"].ToString();

                var server = sp.GetRequiredService<IServer>();
                var serverAddressesFeature = server.Features.Get<IServerAddressesFeature>();
                string? thisApiUrl = serverAddressesFeature?.Addresses.FirstOrDefault();
                _logger.LogInformation($"API URL: {thisApiUrl}");

                var paymentOrderResponse = await _paymentService.PaymentOrderService(
                                                                 paymentDto,
                                                                 referer,
                                                                 thisApiUrl);

                return Ok(paymentOrderResponse);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while processing the payment order.");
                return StatusCode(500, "An error occurred while processing the payment order.");
            }
        }

        [HttpGet("Success")]
        public ActionResult Success(string sessionId, string publishKey)
        {
            try
            {
                // Assuming you use a service to retrieve session details, adjust accordingly
                var sessionService = new SessionService();
                var session = sessionService.Get(sessionId);

                if (session == null)
                {
                    _logger.LogWarning($"Invalid session ID: {sessionId}");
                    return BadRequest("Invalid session ID.");
                }

                // Redirect to client success page
                var s_wasmClientURL = _configuration["ClientURLs:Production"];
                return Redirect($"{s_wasmClientURL}/Success");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while processing the payment success.");
                return StatusCode(500, "An error occurred while processing the payment success.");
            }
        }
    }
}
