using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.PaymentDtos
{
    public class PaymentDto
    {
        public string PatientId { get; set; }

        public int ClinicId { get;set; }

        public int ScheduleId { get; set; }

    }
}
