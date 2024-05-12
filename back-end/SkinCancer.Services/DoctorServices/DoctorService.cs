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

       /* public async Task<DoctorClinicDto> CreateClinicAsync(DoctorClinicDto dto)
        {
            // You can check for null and so on heree...............
            var mappedClinic = _mapper.Map<Clinic>(dto);
            await  _unitOfWork.Reposirory<Clinic>().AddAsync(mappedClinic);
            await _unitOfWork.CompleteAsync();

            return dto;
        }

        public async Task<ProcessResult> DeleteClinicAsync(int id)
        {
            var clinic = await _unitOfWork.Reposirory<Clinic>().GetByIdAsync(id);
            
            if (clinic == null)
            {
                return new ProcessResult { Message = "No Clinic found" };
            }

             _unitOfWork.Reposirory<Clinic>().Delete(clinic);
            await _unitOfWork.CompleteAsync();

            return new ProcessResult { IsSucceeded = true, Message = "success" };
            
            }

        public Task<ProcessResult> GetClinicById(int id)
        {
            throw new NotImplementedException();
        }

        public Task<ProcessResult> GetClinicByName(string name)
        {
            throw new NotImplementedException();
        }*/
    }
}