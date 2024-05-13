using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.Models
{
    public class Appointment : BaseEntity
    {
        public DateTime Date1 { get; set; }

        public DateTime Date2 { get; set; }

        public DateTime Date3 { get; set; }

        public int ClinicId { get; set; }
        public Clinic Clinic { get; set;}
    }
}
