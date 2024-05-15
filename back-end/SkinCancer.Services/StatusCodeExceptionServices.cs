using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Services
{
    public class StatusCodeException : Exception
    {
        public int StatusCode { get; }

        public StatusCodeException(int statusCode)
        {
            StatusCode = statusCode;
        }

        public StatusCodeException(int statusCode, string message) : base(message)
        {
            StatusCode = statusCode;
        }

        public StatusCodeException(int statusCode, string message, Exception innerException) : base(message, innerException)
        {
            StatusCode = statusCode;
        }
    }
}
