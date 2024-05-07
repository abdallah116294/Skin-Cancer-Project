using SkinCancer.Entities.Models;
using SkinCancer.Entities.UserDtos;
using AutoMapper;

namespace SkinCancer.Entities.MappingProfiles
{
    public class UserMappingProfile : Profile
    {
        public UserMappingProfile()
        {
            CreateMap<RegisterModel, ApplicationUser>().ReverseMap();

            CreateMap<LoginModel, ApplicationUser>().ReverseMap();
        }
    }
}
