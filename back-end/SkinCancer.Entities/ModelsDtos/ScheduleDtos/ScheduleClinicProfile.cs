using AutoMapper;
using SkinCancer.Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.ScheduleDtos
{
    public class ScheduleClinicProfile : Profile
    {
        public ScheduleClinicProfile()
        {
            CreateMap<Schedule , ScheduleDto>().ReverseMap();

            CreateMap<Schedule , UpdateScheduleDto>().ReverseMap(); 

            CreateMap<Schedule, ScheduleDetailsDto>().ReverseMap();

            CreateMap<Schedule, PatientScheduleDetailsDto>()
                 .ForMember(dest => dest.ScheduleId, opt => opt.MapFrom(src => src.Id))
                 .ForMember(dest => dest.PatientName,
                    opt => opt.MapFrom(src => $"{src.Patient.FirstName} {src.Patient.LastName}"))
                 .ReverseMap();
        }

    }
}
