using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.UserDtos
{
    public class RegisterModel
    {
        [Required , MinLength(3) , MaxLength(30)]
        public string FirstName { get; set;}

        [Required, MinLength(3), MaxLength(30)]
        public string LastName { get; set;}


        [Required, MinLength(8), MaxLength(20)]
        public string? PhoneNumber { get; set;}


        [Required, MinLength(10), MaxLength(150)]
        public string Email { get; set;}

        [Required , MinLength(3) , MaxLength(50)]
        public string UserName { get; set;}

        [Required , MinLength(8) , MaxLength(80)]
        public string Password { get; set; }
    }
}
