using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.Models
{
    public class Schedule : BaseEntity
    {
        
        public DateTime Date { get; set; }

        public bool IsBooked { get; set; } = false;



        [ForeignKey("Patient")]
        public string? PatientId { get; set; }
        public ApplicationUser Patient { get;set; }

/*        public ICollection<Appointment> Appointments { get; set; } 
*/
 
        public int ClinicId { get; set; }
        public Clinic Clinic { get; set; }  
    }
}
