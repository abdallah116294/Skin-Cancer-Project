using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.AdminDtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Services.AdminServices
{
    public interface IAdminService
    {
        Task<IEnumerable<Clinic>> GetAllClinicService();

        Task<Clinic> GetClinicByIdService(int id);

        Task<Clinic> CreateClinicService(AdminClinicDto clinic);

        Task<Clinic> UpdateClinicService(int id , AdminClinicDto updatedClinic);

        Task<Clinic> DeleteClinicService(int id);

    }
}
