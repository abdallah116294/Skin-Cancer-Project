using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using SkinCancer.Api.Helper;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.DoctorDtos;
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
        public async Task<IEnumerable<DoctorClinicDto>> GetClinicsAsync()
        {
            var clinics = await _clinicService.GetAllClinicsAsync();

            return clinics;
        }
        [HttpGet("GetClinicByName")]
        public async Task<ActionResult<DoctorClinicDto>> GetClinicByNameAsync(string name)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var clinicDto = await _clinicService.GetClinicByName(name);

            if (clinicDto == null)
            {
                return NotFound("No Clinic Found with this name :" + name);
            }

            return clinicDto;
        }
        [HttpGet("GetClinicByName{id:int}")]
        public async Task<ActionResult<DoctorClinicDto>> GetClinicByIdAsync(int id)
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

            return clinicDto;
        }

        [HttpPut("UpdateClinic")]
        [Authorize(Roles = Roles.Doctor + "," + Roles.Admin)]
        public async Task<ActionResult<DoctorClinicDto>> UpdateClinicAsync(
            [FromBody] DoctorClinicDto dto)
        {
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
            var clinic = await _clinicService.UpdateClinicAsync(dto);

            if (clinic == null)
            {
                return NotFound("No Clinic Found with this Id: " + dto.Id);
            }

            return Ok(clinic);
        }

        [HttpPost("CreateClinic")]
        [Authorize(Roles = Roles.Doctor + "," + Roles.Admin)]
        public async Task<ActionResult<ProcessResult>> CreateClinicAsync(DoctorClinicDto dto)
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

            //var doctorName = User.FindFirstValue(ClaimTypes.)

            var result = await _clinicService.CreateClinicAsync(dto);

            if (!result.IsSucceeded)
            {
                return BadRequest(new ProcessResult { Message = "Can't Create Clinic" });
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

            var clinic = await _clinicService.DeleteClinicAsync(id);

            if (!clinic.IsSucceeded)
            {
                return NotFound(clinic);
            }
            return Ok(clinic);
        }
    }
}
