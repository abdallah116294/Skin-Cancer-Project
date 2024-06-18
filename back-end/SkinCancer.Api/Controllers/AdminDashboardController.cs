// Ignore Spelling: Admin

using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.AdminDtos;
using SkinCancer.Services.AdminServices;
using System;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;

namespace SkinCancer.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdminDashboardController : ControllerBase
    {
        private readonly IAdminService _adminService;
        private readonly ILogger<AdminDashboardController> _logger;

        public AdminDashboardController(IAdminService adminService, ILogger<AdminDashboardController> logger)
        {
            _adminService = adminService ?? throw new ArgumentNullException(nameof(adminService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        [HttpGet("GetAllClinics")]
        public async Task<IActionResult> GetAllClinicsAsync()
        {
            try
            {
                var clinics = await _adminService.GetAllClinicService();
                return Ok(clinics);
            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogWarning(ex, "No clinics found.");
                return NotFound(ex.Message);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while retrieving clinics.");
                return StatusCode(500, "An error occurred while retrieving clinics. Please try again later.");
            }
        }

        [HttpGet("GetClinicById{id}")]
        public async Task<IActionResult> GetClinicByIdAsync(int id)
        {
            try
            {
                var clinic = await _adminService.GetClinicByIdService(id);
                return Ok(clinic);
            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogWarning(ex, $"No clinic found with ID {id}");
                return NotFound($"No clinic found with ID {id}");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"An error occurred while retrieving clinic with ID {id}");
                return StatusCode(500, $"An error occurred while retrieving clinic with ID {id}. Please try again later.");
            }
        }

        [HttpPost("CreateClinic")]
        public async Task<IActionResult> CreateClinicAsync(AdminClinicDto dto)
        {

            try
            {

                var result = await _adminService.CreateClinicService(dto);

                return result == null 
                    ?
                    throw new ArgumentException("SomeThing went wrong")
                    : (IActionResult)Ok(result);
            }
            catch (ValidationException ex)
            {
                _logger.LogWarning(ex, "Validation error occurred while creating clinic.");
                return BadRequest(ex.Message);
            }
            catch (ApplicationException ex)
            {
                _logger.LogError(ex, "An error occurred while creating clinic.");
                return StatusCode(500, "An error occurred while creating clinic. Please try again later.");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An unexpected error occurred while creating clinic.");
                return StatusCode(500, "An unexpected error occurred while creating clinic. Please try again later.");
            }
        }

        [HttpPut("UpdateClinic/{id}")]
        public async Task<IActionResult> UpdateClinicAsync([FromRoute] int id,
            [FromBody] AdminClinicDto updatedClinic)
        {
            try
            {
                var clinic = await _adminService.UpdateClinicService(id, updatedClinic);

                return Ok(clinic);
            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogWarning(ex, "No clinic found with ID {Id}", id);
                return NotFound(ex.Message); // Return 404 with the exception message
            }
            catch (ValidationException ex)
            {
                _logger.LogWarning(ex, "Validation error occurred while updating clinic with ID {Id}", id);
                return BadRequest(ex.Message); // Return 400 with the validation exception message
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while updating clinic with ID {Id}", id);
                return StatusCode(500, "An error occurred while updating the clinic. Please try again later."); // Return 500 for unexpected errors
            }
        }

        [HttpDelete("DeleteClinic/{id}")]
        public async Task<IActionResult> DeleteClinicAsync(int id)
        {
            try
            {
                var clinic = await _adminService.DeleteClinicService(id);
                return Ok(clinic);
            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogWarning(ex, "No clinic found with ID {Id}", id);
                return NotFound(ex.Message); // Return 404 with the exception message
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while deleting clinic with ID {Id}", id);
                return StatusCode(500, "An error occurred while deleting the clinic. Please try again later."); // Return 500 for unexpected errors
            }
        }
    }
}
