using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.Models
{
    public class ApplicationUser : IdentityUser
    {
        [Required, MinLength(3), MaxLength(30)]
        public string FirstName { get; set; } = string.Empty;

        [Required, MinLength(3), MaxLength(30)]
        public string LastName { get; set; } = string.Empty;

        // [ValidateNever]
        public string Code { get; set; } = string.Empty;
        
        public short? YearsOfExperiences { get; set; }

        public string DetectoinImage { get; set; } = string.Empty;

        public bool? DoctorHasClinic { get; set; } = false;

        //       [ValidateNever]
        public Clinic? Clinic { get; set; }


        public List<PatientRateClinic> PatientRates { get; set; } = new List<PatientRateClinic>();
        
            
        //public ICollection<Schedule> Schedules { get; set; }    
        public Schedule Schedule { get; set; }
    }
}
