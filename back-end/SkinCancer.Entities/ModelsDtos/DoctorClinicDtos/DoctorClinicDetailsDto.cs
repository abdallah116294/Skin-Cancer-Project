using SkinCancer.Entities.ModelsDtos.DoctorDtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.DoctorClinicDtos
{
    public class DoctorClinicDetailsDto : DoctorClinicDto
    {
        public int Id { get;set; }

        public List<DateTime>? AvailableDates { get; set; }
    }
}
