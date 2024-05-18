﻿using Microsoft.AspNetCore.Mvc;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.ModelsDtos.DoctorDtos;
using SkinCancer.Entities.ModelsDtos.PatientDtos;
using SkinCancer.Services.ClinicServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Services.PatientClinicServices
{
    public class PatientClinicService : IPatientClinicService
    {
        public readonly IClinicService _clinicalService;

        public PatientClinicService(IClinicService clinicalService)
        {
            _clinicalService = clinicalService;
        }

        public async Task<ActionResult<IEnumerable<DoctorClinicDto>>> GetAllClinics()
        {
            var clinics = await _clinicalService.GetAllClinicsAsync();

            return new OkObjectResult(clinics);

        }

        public Task<ActionResult<ProcessResult>> PatientBookClinic(PatientBooksClinicDto dto)
        {
            throw new NotImplementedException();
        }

        public Task<ActionResult<ProcessResult>> PatientRatesClinic(short rate)
        {
            throw new NotImplementedException();
        }
    }
}
