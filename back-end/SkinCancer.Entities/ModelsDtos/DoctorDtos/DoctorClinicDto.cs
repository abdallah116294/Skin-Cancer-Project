using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.DoctorDtos
{
    public class DoctorClinicDto
    {
        public int Id { get; set; }

        public string Name { get;set; }

        public decimal Price { get;set; }

        public string Phone { get; set; }

        public string Address { get; set; }

        public string Image { get; set; }

        public string Description { get; set; }

        public DateTime Date1 { get; set; }

        public DateTime Date2 { get; set; }

        public DateTime Date3 { get; set; }


        // From Application User 
        public string DoctorName { get; set; }

    }
}
