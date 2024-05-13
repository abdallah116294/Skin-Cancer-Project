using Microsoft.AspNetCore.Mvc;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.DoctorDtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Services.ClinicServices
{
    public interface IClinicService
    {

        Task<IEnumerable<DoctorClinicDto>> GetAllClinicsAsync();

        Task<ProcessResult> CreateClinicAsync(DoctorClinicDto clinicDto);

        Task<ProcessResult> DeleteClinicAsync(int id);

        Task<ActionResult<DoctorClinicDto>> GetClinicByName(string name);

        Task<ActionResult<DoctorClinicDto>> GetClinicById(int id);

        Task<ProcessResult> UpdateClinicAsync(DoctorClinicDto clinicDto);



    }
}
