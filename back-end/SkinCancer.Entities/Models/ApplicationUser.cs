using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.Models
{
    public class ApplicationUser : IdentityUser
    {
        [Required, MinLength(3), MaxLength(30)]
        public string FirstName { get; set; } = string.Empty;


        [Required, MinLength(3), MaxLength(30)]
        public string LastName { get; set; } = string.Empty;

        public string? Code { get; set; }

    }
}
