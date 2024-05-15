using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.AuthenticationUserDtos
{
    public class RoleModel
    {
        [Required]
        public string RoleName { get; set; }


        [Required]
        public string UserName { get; set; }
    }
}
