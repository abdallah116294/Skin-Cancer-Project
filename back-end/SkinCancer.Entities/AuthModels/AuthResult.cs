using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IdentityModel.Tokens.Jwt;

namespace SkinCancer.Entities.AuthModels
{
    public class AuthResult
    {
        public AuthResult()
        {
            // To avoid Null Exception

            Roles = new List<string>();
        }

        public string Message { get; set; } = string.Empty;

        public bool IsAuthenticated { get; set; }
       
        public string UserName { get; set; }

        public string Email { get; set; } = string.Empty;

        public List<string> Roles { get; set; }

        public string Token { get; set;} = string.Empty;

        public DateTime ExpireOn { get; set; }
    
    }
}
