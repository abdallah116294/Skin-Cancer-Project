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

        public async Task<DoctorClinicDto> GetAllClinics()
        {
            var clinics = await _clinicalService.GetAllClinicsAsync();


        }

        public Task<ProcessResult> PatientBookClinic(PatientBooksClinicDto dto)
        {
            throw new NotImplementedException();
        }

        public Task<ProcessResult> PatientRatesClinic(short rate)
        {
            throw new NotImplementedException();
        }
    }
}
