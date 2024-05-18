using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.ScheduleDtos
{
    public class ScheduleDto
    {
                
        public DateTime Date { get; set; }

        public bool IsBooked { get; set; }

        public int ClinicId { get; set; }


    }
}
