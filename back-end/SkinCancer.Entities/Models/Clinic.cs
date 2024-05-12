using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.Models
{
    public class Clinic : BaseEntity
    {
        public string Name { get; set; }

        public decimal Price { get; set; }

        public string Phone { get; set; }

        public string Address { get; set; }

        public string Image { get; set; }

        public string Description { get; set; }

        public string DoctorName { get; set; }


        public string? UserId { get; set; }
        public ApplicationUser? User { get; set; }
        

        public Appointment? Appointment { get; set; }
       
    }
}
