using AutoMapper;
using SkinCancer.Entities.Models;
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
               .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
               .ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.Name))
               .ForMember(dest => dest.Price, opt => opt.MapFrom(src => src.Price))
               .ForMember(dest => dest.Phone, opt => opt.MapFrom(src => src.Phone))
               .ForMember(dest => dest.Address, opt => opt.MapFrom(src => src.Address))
               .ForMember(dest => dest.Image, opt => opt.MapFrom(src => src.Image))
               .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
               .ForMember(dest => dest.DoctorName, opt => opt.MapFrom(src => src.DoctorName))
               .ReverseMap();

            CreateMap<DoctorClinicDto, Appointment>()
               .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
               .ForMember(dest => dest.Date1, opt => opt.MapFrom(src => src.Date1))
               .ForMember(dest => dest.Date2, opt => opt.MapFrom(src => src.Date2))
               .ForMember(dest => dest.Date3, opt => opt.MapFrom(src => src.Date3))
               .ReverseMap();

            CreateMap<Clinic, DoctorClinicDto>()
               .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
               .ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.Name))
               .ForMember(dest => dest.Price, opt => opt.MapFrom(src => src.Price))
               .ForMember(dest => dest.Phone, opt => opt.MapFrom(src => src.Phone))
               .ForMember(dest => dest.Address, opt => opt.MapFrom(src => src.Address))
               .ForMember(dest => dest.Image, opt => opt.MapFrom(src => src.Image))
               .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
               .ForMember(dest => dest.DoctorName, opt => opt.MapFrom(src => src.DoctorName))
               .ForMember(dest => dest.Date1, opt => opt.MapFrom(src => src.Appointment.Date1))
               .ForMember(dest => dest.Date2, opt => opt.MapFrom(src => src.Appointment.Date2))
               .ForMember(dest => dest.Date3, opt => opt.MapFrom(src => src.Appointment.Date3))
               .ReverseMap();
        }
    }
}
