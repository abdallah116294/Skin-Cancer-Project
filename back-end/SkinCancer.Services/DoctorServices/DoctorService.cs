using AutoMapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.Abstractions;
using SkinCancer.Entities.Models;
using SkinCancer.Repositories.Interface;
using SkinCancer.Entities.ModelsDtos.DoctorDtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SkinCancer.Entities.AuthModels;

namespace SkinCancer.Services.DoctorServices
{
    public class DoctorService : IDoctorService
    {
        public readonly IUnitOfWork _unitOfWork;
        public readonly IMapper _mapper;
        public readonly RoleManager<IdentityRole> _roleManager;
        public readonly UserManager<ApplicationUser> _userManager;

        public DoctorService(IUnitOfWork unitOfWork, IMapper mapper,
                             RoleManager<IdentityRole> roleManager, UserManager<ApplicationUser> userManager)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _roleManager = roleManager;
            _userManager = userManager;
        }



	}
}