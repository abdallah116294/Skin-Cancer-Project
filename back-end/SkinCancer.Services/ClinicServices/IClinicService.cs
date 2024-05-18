﻿using Microsoft.AspNetCore.Mvc;
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

        Task<ActionResult<IEnumerable<DoctorClinicDetailsDto>>> GetAllClinicsAsync();

        Task<ActionResult<ProcessResult>> CreateClinicAsync(DoctorClinicDto clinicDto);
    
        Task<ActionResult<ProcessResult>> DeleteClinicAsync(int id);

        Task<ActionResult<IEnumerable<DoctorClinicDetailsDto>>> GetClinicByName(string name);

        Task<ActionResult<DoctorClinicDetailsDto>> GetClinicById(int id);

        Task<ActionResult<ProcessResult>> UpdateClinicAsync(DoctorClinicUpdateDto clinicDto);

        Task<ActionResult<ProcessResult>> PatientRateClinicAsync(PatientRateDto dto);



    }
}
