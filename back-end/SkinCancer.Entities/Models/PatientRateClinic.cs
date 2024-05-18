using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.Models
{
    public class PatientRateClinic : BaseEntity
    {
        
        public byte Rate { get; set; }

        [ForeignKey("Clinic")]
        public int ClinicId { get; set;}
        public Clinic Clinic { get; set; }
  


        [ForeignKey("Patient")]
        public string PatientId { get; set; }
        public ApplicationUser Patient { get; set; }
    }
}
