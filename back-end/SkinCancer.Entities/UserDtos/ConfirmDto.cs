using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.UserDtos
{
    public class ConfirmDto
    {
        [Required]
        public string userId { get; set; }

        [Required]
        public string code { get; set; }
    }
}
