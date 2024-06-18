// Ignore Spelling: Admin Dtos

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.AdminDtos
{
    public class AdminClinicDto
    {

        public string Name { get; set; }

        public decimal Price { get; set; }

        public string Description { get; set; }

        public string Address { get; set; }

        public string Image { get; set; }

        public string Phone { get; set; }

        public string DoctorId { get; set; }

        public string DoctorName { get; set; }  
    }
}
