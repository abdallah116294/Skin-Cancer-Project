using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.AuthenticationUserDtos
{
    public class ResetPasswordDto
    {
        //  [FromQuery]string userId, [FromQuery]string code, [FromQuery] string newPassword

        public string Code { get;set; }
        public string Email { get;set; }

        public string newPassword { get;set;}


    }
}
