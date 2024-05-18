using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SkinCancer.Entities.ModelsDtos.DoctorDtos;
using SkinCancer.Services.PatientClinicServices;

namespace SkinCancer.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PatientClinicController : ControllerBase
    {
        public readonly IPatientClinicService _patientClinicService;

        public PatientClinicController(IPatientClinicService patientClinicService)
        {
            _patientClinicService = patientClinicService;
        }

        [HttpGet]
       // [Authorize(Roles = Roles.)]
        public async Task<IEnumerable<DoctorClinicDto>> PatientGetAllClinicAsync()
        {
            var clinicsDto = await _patientClinicService.GetAllClinics();

            return clinicsDto;
        }
    }
}
