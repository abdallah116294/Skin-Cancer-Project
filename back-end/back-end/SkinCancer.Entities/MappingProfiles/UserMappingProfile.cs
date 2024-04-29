using SkinCancer.Entities.Models;
using SkinCancer.Entities.UserDtos;
using SkinCancer.Entities.AuthModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
