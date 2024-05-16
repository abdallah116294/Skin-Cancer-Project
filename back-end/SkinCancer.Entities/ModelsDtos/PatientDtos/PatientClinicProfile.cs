using AutoMapper;
using SkinCancer.Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.PatientDtos
{
    public class PatientClinicProfile : Profile
    {
        public PatientClinicProfile()
        {
            CreateMap<PatientRateDto , PatientRateClinic>().ReverseMap();
        }
    }
}
