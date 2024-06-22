using SkinCancer.Entities.Models;
using AutoMapper;

namespace SkinCancer.Entities.ModelsDtos.AuthenticationUserDtos
{
    public class UserMappingProfile : Profile
    {
        public UserMappingProfile()
        {
            CreateMap<RegisterModel, ApplicationUser>().ReverseMap();

            CreateMap<LoginModel, ApplicationUser>().ReverseMap();

            CreateMap<PatientDetailsDto, ApplicationUser>().ReverseMap();

            CreateMap<DoctorDetailsDto, ApplicationUser>().ReverseMap();

        }
    }
}
