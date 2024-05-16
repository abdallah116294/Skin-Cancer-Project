using AutoMapper;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.DoctorClinicDtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.DoctorDtos
{
    public class DoctorClinicProfile : Profile
    {
        public DoctorClinicProfile()
        {
            CreateMap<DoctorClinicDto, Clinic>()
                             .ReverseMap();

            CreateMap<Clinic,DoctorClinicDetailsDto>()
               .ForMember(dest => dest.AvailableDates, opt => opt.MapFrom<DoctorClinicScheduleResolver>())
               .ReverseMap();

            CreateMap<DoctorClinicUpdateDto, Clinic>()
                .ReverseMap();

        }
       /* private List<Schedule> MapDatesToSchedules(List<DateTime>? availableDates)
        {
            if (availableDates == null || availableDates.Count == 0)
            {
                return new List<Schedule>();
            }

            return availableDates.Select(date => new Schedule { Date = date }).ToList();
        }*/
    }
}
