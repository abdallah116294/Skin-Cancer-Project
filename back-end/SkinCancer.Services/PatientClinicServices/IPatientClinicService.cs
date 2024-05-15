using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.ModelsDtos.DoctorDtos;
using SkinCancer.Entities.ModelsDtos.PatientDtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Services.PatientClinicServices
{
    public interface IPatientClinicService
    {

        public Task<DoctorClinicDto> GetAllClinics();

        public Task<ProcessResult> PatientBookClinic(PatientBooksClinicDto dto);

        public Task<ProcessResult> PatientRatesClinic(short rate);
    }
}
