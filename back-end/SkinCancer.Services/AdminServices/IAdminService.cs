// Ignore Spelling: Admin

using Microsoft.AspNetCore.Identity;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.AdminDtos;
using SkinCancer.Entities.ModelsDtos.AuthenticationUserDtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Services.AdminServices
{
    public interface IAdminService
    {
        Task<IEnumerable<ApplicationUser>> GetAllUsersService();

        Task<IEnumerable<ApplicationUser>> GetAllDoctorsService();

        Task<IEnumerable<ApplicationUser>> GetAllPatientsService();

        Task<IEnumerable<ApplicationUser>> GetAllAdminsService();

        Task<ApplicationUser> GetUserByIdService(string id);

        Task<IEnumerable<string>> GetUserRolesService(string id);

        Task<ApplicationUser> UpdateUserService(string id , RegisterModel user);

        Task<ProcessResult> DeleteUserService(string id);

        Task<IEnumerable<Clinic>> GetAllClinicService();

        Task<Clinic> GetClinicByIdService(int id);

        Task<Clinic> CreateClinicService(AdminClinicDto clinic);

        Task<Clinic> UpdateClinicService(int id , AdminClinicDto updatedClinic);

        Task<Clinic> DeleteClinicService(int id);

    }
}
