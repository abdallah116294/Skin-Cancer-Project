using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.PaymentDtos;
using Stripe.Checkout;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Services.PaymentServices
{
    public interface IPaymentService
    {
        Task<Session> CreatePaymentSession(PaymentDto paymentDto, string thisApiUrl);
        Task<PaymentOrderResponse> PaymentOrderService(PaymentDto paymentDto, string referer, string thisApiUrl);

    }
}
