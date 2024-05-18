using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.ScheduleDtos
{
    public class ScheduleDetailsDto
    {
        public DateTime Date { get; set; }

        public bool IsBooked { get; set; } = false;

        public string? PatientId { get; set; }
    }
}
