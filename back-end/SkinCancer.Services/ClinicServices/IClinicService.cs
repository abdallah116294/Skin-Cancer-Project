using Microsoft.AspNetCore.Mvc;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.DoctorClinicDtos;
using SkinCancer.Entities.ModelsDtos.DoctorDtos;
using SkinCancer.Entities.ModelsDtos.PatientDtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Services.ClinicServices
{
    public interface IClinicService
    {

        Task<IEnumerable<DoctorClinicDetailsDto>> GetAllClinicsAsync();

        Task<ProcessResult> CreateClinicAsync(DoctorClinicDto clinicDto);

        Task<ProcessResult> DeleteClinicAsync(int id);

        Task<ActionResult<DoctorClinicDetailsDto>> GetClinicByName(string name);

        Task<ActionResult<DoctorClinicDetailsDto>> GetClinicById(int id);

        Task<ProcessResult> UpdateClinicAsync(DoctorClinicUpdateDto clinicDto);

        Task<ProcessResult> PatientRateClinicAsync(PatientRateDto dto);



    }
}
