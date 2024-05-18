using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.PatientDtos
{
    public class PatientBooksClinicDto
    {
        public int clinicId {  get; set; }

        public short SelectedDateChoice { get; set; }

        public IFormFile? DetectionImage { get; set; }

    }
}
