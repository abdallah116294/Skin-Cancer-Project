using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.Models
{
    public class Clinic : BaseEntity
    {
        [Required, MaxLength(100)]
        public string Name { get; set; }

        [Range(0, double.MaxValue)]
        public decimal Price { get; set; }

        [Phone, MaxLength(25)]
        public string Phone { get; set; }

        [Required, MaxLength(200)]
        public string Address { get; set; }

        public string Image { get; set; }

        [MaxLength(500)]
        public string Description { get; set; }

        [Required, MaxLength(100)]
        public string DoctorName { get; set; }

        [Range(0.0, 10.0, ErrorMessage = "Rate must be between 0.0 and 10.0")]
        public double? Rate { get; set; }

        [ForeignKey("Doctor")]
        public string DoctorId { get; set; } = string.Empty;

        public ApplicationUser Doctor { get; set; }


        public List<PatientRateClinic> PatientRates { get; set; } = new List<PatientRateClinic>();


        public ICollection<Schedule>? Schedules { get; set; } = new List<Schedule>();       
    }
}
