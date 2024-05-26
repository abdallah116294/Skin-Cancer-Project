using SkinCancer.Entities.Models;
using AutoMapper;
using SkinCancer.Entities.ModelsDtos.AuthenticationUserDtos;

namespace SkinCancer.Entities.MappingProfiles
{
    public class UserMappingProfile : Profile
    {
        public UserMappingProfile()
        {
            CreateMap<RegisterModel, ApplicationUser>().ReverseMap();

            CreateMap<LoginModel, ApplicationUser>().ReverseMap();

            CreateMap<PatientDetailsDto , ApplicationUser>().ReverseMap();

        }
    }
}
