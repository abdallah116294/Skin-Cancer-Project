using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.ScheduleDtos
{
    public class PatientScheduleDetailsDto
    {
      
        public string PatientId { get; set; }

        public string PatientName { get; set; } 
        public DateTime Date { get; set; }

        public string ClinicName { get; set; }

        public int ScheduleId { get; set; }
    }
}
