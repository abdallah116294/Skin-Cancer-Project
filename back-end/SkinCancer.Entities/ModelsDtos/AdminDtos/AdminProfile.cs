// Ignore Spelling: Admin

using AutoMapper;
using SkinCancer.Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.AdminDtos
{
    public class AdminProfile : Profile
    {
        public AdminProfile()
        {
            CreateMap<AdminClinicDto, Clinic>().ReverseMap();
        }
    }
}
