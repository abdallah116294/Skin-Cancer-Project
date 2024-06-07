using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.DoctorDtos
{
    public class DoctorClinicDto
    {

        public string Name { get;set; }

        public decimal Price { get;set; }

        public string Phone { get; set; }

        public string Address { get; set; }

        public string Image { get; set; }
        
        public string Description { get; set; }

        public double? Rate { get; set; }

        public string DoctorId { get; set; }

       // public List<DateTime>? AvailableDates { get; set; }
        // From Application User 
        public string DoctorName { get; set; }

    }
}
