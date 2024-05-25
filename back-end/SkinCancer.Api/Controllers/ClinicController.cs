using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.Web.CodeGenerators.Mvc.Templates.BlazorIdentity.Pages.Manage;
using SkinCancer.Api.Helper;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.DoctorClinicDtos;
using SkinCancer.Entities.ModelsDtos.DoctorDtos;
using SkinCancer.Entities.ModelsDtos.PatientDtos;
using SkinCancer.Services.ClinicServices;
using SkinCancer.Services.DoctorServices;
using System.Security.Claims;

namespace SkinCancer.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ClinicController : ControllerBase
    {
        public readonly IDoctorService _doctorService;
        public readonly UserManager<ApplicationUser> _userManager;
        public readonly IClinicService _clinicService;
        public readonly RoleManager<IdentityRole> _roleManager;

        public ClinicController(IDoctorService doctorService, UserManager<ApplicationUser> userManager, IClinicService clinicService, RoleManager<IdentityRole> roleManager)
        {
            _doctorService = doctorService;
            _userManager = userManager;
            _clinicService = clinicService;
            _roleManager = roleManager;
        }

        [HttpGet("GetAllClinics")]
        public async Task<ActionResult<IEnumerable<DoctorClinicDto>>> GetClinicsAsync()
        {
            var clinics = await _clinicService.GetAllClinicsAsync();

            return Ok(clinics);
        }
        [HttpGet("GetClinicByName")]
        public async Task<ActionResult<IEnumerable<DoctorClinicDetailsDto>>> GetClinicByNameAsync(string subName)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var clinicDto = await _clinicService.GetClinicByName(subName);

            if (clinicDto == null)
            {
                return NotFound("No Clinic Found with this name :" + subName);
            }

            return Ok(clinicDto);
        }
        [HttpGet("GetClinicById{id:int}")]
        public async Task<ActionResult<DoctorClinicDetailsDto>> GetClinicByIdAsync(int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var clinicDto = await _clinicService.GetClinicById(id);
            
            if (clinicDto == null)
            {
                return NotFound("No Clinic Found with this  Id: " + id);
            }

            return Ok(clinicDto);
        }

        [HttpPut("UpdateClinic")]
        [Authorize(Roles = Roles.Doctor + "," + Roles.Admin)]
        public async Task<ActionResult<DoctorClinicUpdateDto>> UpdateClinicAsync(
            [FromBody] DoctorClinicUpdateDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

           /* var userEmail = User.FindFirst(ClaimTypes.Name)?.Value;


            if (user == null)
            {
                ModelState.AddModelError(nameof(dto.DoctorName), "Doctor with this name does not exist.");
                return BadRequest(ModelState);
            }

            var isInDoctorRole = await _userManager.IsInRoleAsync(user, Roles.Doctor);
            var isInAdminRole = await _userManager.IsInRoleAsync(user, Roles.Admin);

            if (!isInDoctorRole && !isInAdminRole)
            {
                ModelState.AddModelError(nameof(dto.DoctorName), "User is not a doctor.");
                return BadRequest(ModelState);
            }*/
            var clinic = await _clinicService.UpdateClinicAsync(dto);

            if (clinic == null)
            {
                return NotFound("No Clinic Found with this Id: " + dto.Id);
            }

            return Ok(clinic);
        }

        [HttpPost("CreateClinic")]
        [Authorize(Roles = Roles.Doctor + "," + Roles.Admin)]
        public async Task<ActionResult<ProcessResult>> CreateClinicAsync(CreateClinicDto dto)
        {
            // ApplicationUser Role ===> 
            // Relationship between Doctor and clinic 

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var user = await _userManager.FindByNameAsync(dto.DoctorName);

            if (user == null)
            {
                ModelState.AddModelError(nameof(dto.DoctorName), "Doctor with this name does not exist.");
                return BadRequest(ModelState);
            }

            var isInDoctorRole = await _userManager.IsInRoleAsync(user, Roles.Doctor);
            var isInAdminRole = await _userManager.IsInRoleAsync(user, Roles.Admin);

            if (!isInDoctorRole && !isInAdminRole)
            {
                ModelState.AddModelError(nameof(dto.DoctorName), "User is not a doctor.");
                return BadRequest(ModelState);
            }

            
            var result = await _clinicService.CreateClinicAsync(dto);

            if (!result.IsSucceeded)
            {
                return BadRequest(new ProcessResult { Message = "Can't Create Clinic" });
            }

            user.DoctorHasClinic = true;
            var updatedResult = await _userManager.UpdateAsync(user);

            if (!updatedResult.Succeeded)
            {
                return BadRequest(
                    new ProcessResult
                    {
                        Message = "Clinic Created but failed to update user."
                    }
                    );
            }
            
            return Ok(new ProcessResult
            {
                
                IsSucceeded = true,
                Message = "Clinic Created Successfully"
            });
        }


        [HttpDelete("DeleteClinic")]
        [Authorize(Roles = $"{Roles.Doctor},{Roles.Admin}")]
        public async Task<ActionResult<ProcessResult>> DeleteClinicAsync(int id)
        {

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var clinic = await _clinicService.GetClinicById(id);

            var result = await _clinicService.DeleteClinicAsync(id);

            if (!result.IsSucceeded)
            {
                return BadRequest(new ProcessResult { Message = "Failed to delete clinic" });
            }

            var user = await _userManager.FindByIdAsync(clinic.DoctorId);
            if (user == null)
            {
                return BadRequest(
                        new ProcessResult
                        {
                            Message = "No Doctor assigned to this clinic"
                        }
                    );
            }

            user.DoctorHasClinic = false;
            var updatedResult = await _userManager.UpdateAsync(user);

            if (!updatedResult.Succeeded)
            {
                return BadRequest(
                        new ProcessResult
                        {
                            Message = "Clinic Deleted Successfully, but failed to update doctor status"
                        }
                    );
            }

            return Ok(result);
        }


        [HttpPost("PatientRateClinic")]
        public async Task<ActionResult> PatientRatesClinicAsync(PatientRateDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var result = await _clinicService.PatientRateClinicAsync(dto);
            if (!result.IsSucceeded)
            {
                return BadRequest(ModelState);
            }

            return Ok(result);
        }

    }
}
