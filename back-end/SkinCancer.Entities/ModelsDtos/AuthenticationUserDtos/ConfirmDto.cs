using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.AuthenticationUserDtos
{
    public class ConfirmDto
    {
        [Required]
        public string userId { get; set; }

        [Required]
        public string code { get; set; }
    }
}
