using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.UserDtos
{
    public class LoginModel
    {
        [EmailAddress]
        [Required , MinLength(10) , MaxLength(255)]
        public string Email { get; set; } = string.Empty;

        [DataType(DataType.Password)]
        [Required , MaxLength(70)]
        public string Password { get; set; } = string.Empty;

    }
}
