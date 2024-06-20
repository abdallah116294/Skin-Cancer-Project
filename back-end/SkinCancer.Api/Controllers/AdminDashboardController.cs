// Ignore Spelling: Admin

using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.AdminDtos;
using SkinCancer.Entities.ModelsDtos.AuthenticationUserDtos;
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


        [HttpGet("GetAllUsers")]
        public async Task<IActionResult> GetAllUsersAsync()
        {
            try
            {
                var users = await _adminService.GetAllUsersService();
                return Ok(users);
            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogWarning(ex, "No users found.");
                return NotFound(new { Message = "No users found." });
            }
            catch (ApplicationException ex)
            {
                _logger.LogError(ex, "An error occurred while retrieving users.");
                return StatusCode(500, new { Message = "An error occurred while retrieving users. Please try again later.", Details = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An unexpected error occurred.");
                return StatusCode(500, new { Message = "An unexpected error occurred. Please try again later.", Details = ex.Message });
            }
        }


        [HttpGet("GetAllDoctors")]
        public async Task<IActionResult> GetAllDoctorsAsync()
        {
            try
            {
                var doctors = await _adminService.GetAllDoctorsService();
                return Ok(doctors);
            }
            catch (Exception ex)
            {
                // Log the exception using a logger (not shown here for brevity)
                _logger.LogError(ex, "An Error occurred while fetching all doctors");
                return StatusCode(500, "An error occurred while retrieving doctors. Please try again later.");
            }
        }

        [HttpGet("GetAllPatients")]
        public async Task<IActionResult> GetAllPatientsAsync()
        {
            try
            {
                var patients = await _adminService.GetAllPatientsService();

                return Ok(patients);
            }
            catch (Exception ex)
            {
                // Log the exception using a logger (not shown here for brevity)
                _logger.LogError(ex, "An Error occurred while fetching all patients");
                return StatusCode(500, "An error occurred while retrieving patients. Please try again later.");
            }
        }

        [HttpGet("GetAllAdmins")]
        public async Task<IActionResult> GetAllAdminsAsync()
        {
            try
            {
                var admins = await _adminService.GetAllAdminsService();
                return Ok(admins);
            }
            catch (Exception ex)
            {
                // Log the exception using a logger (not shown here for brevity)
                _logger.LogError(ex, "An Error occurred while fetching all admins");
                return StatusCode(500, "An error occurred while retrieving admins. Please try again later.");
            }
        }

        [HttpPut("UpdateUser{id}")]
        public async Task<IActionResult> UpdateUserAsync([FromRoute]string id,
            [FromBody]RegisterModel user)
        {
            try
            {
                // Check if user exists before attempting to update
                var existingUser = await _adminService.GetUserByIdService(id);
                if (existingUser == null)
                {
                    _logger.LogWarning("No user found with ID {Id} for update.", id);
                    return NotFound($"No user found with ID {id}");
                }

                // Proceed with updating the user
                var updatedUser = await _adminService.UpdateUserService(id, user);
                return Ok(updatedUser);
            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogWarning(ex, "No user found with ID {Id}", id);
                return NotFound(ex.Message); // Return 404 with the exception message
            }
            catch (ValidationException ex)
            {
                _logger.LogWarning(ex, "Validation error occurred while updating user with ID {Id}", id);
                return BadRequest(ex.Message); // Return 400 with the validation exception message
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while updating user with ID {Id}", id);
                return StatusCode(500, "An error occurred while updating the user. Please try again later."); // Return 500 for unexpected errors
            }
        }
        /// <summary>
        /// Retrieves a user by ID.
        /// </summary>
        /// <param name="id">The ID of the user to retrieve.</param>
        /// <returns>An IActionResult containing the user with the specified ID or an error message.</returns>
        [HttpGet("GetUserById")]
        public async Task<IActionResult> GetUserByIdAsync(string id)
        {
            try
            {
                // Attempt to retrieve the user by ID
                var user = await _adminService.GetUserByIdService(id);
                return Ok(user);
            }
            catch (KeyNotFoundException ex)
            {
                // Log a warning and return a NotFound result if the user was not found
                _logger.LogWarning(ex, "No user found with ID {Id}", id);
                return NotFound(new { Message = $"No user found with ID {id}" });
            }
            catch (ApplicationException ex)
            {
                // Log an error and return a BadRequest result if there was an application error
                _logger.LogError(ex, "Application error occurred while retrieving user with ID {Id}", id);
                return BadRequest(new { Message = ex.Message });
            }
            catch (Exception ex)
            {
                // Log a critical error and return a generic error result for unexpected exceptions
                _logger.LogCritical(ex, "An unexpected error occurred while retrieving user with ID {Id}", id);
                return StatusCode(500, new { Message = "An unexpected error occurred. Please try again later." });
            }
        }

        /// <summary>
        /// Retrieves the roles assigned to a user by ID.
        /// </summary>
        /// <param name="id">The ID of the user whose roles are to be retrieved.</param>
        /// <returns>An IActionResult containing the roles assigned to the user.</returns>
        [HttpGet("GetUserRolesById")]
        public async Task<IActionResult> GetUserRolesByIdAsync(string id)
        {
            try
            {
                // Retrieve the user roles by ID
                var userRoles = await _adminService.GetUserRolesService(id)
                                ?? throw new KeyNotFoundException($"No roles found for user with ID: {id}");

                // Return the user roles
                return Ok(userRoles);
            }
            catch (KeyNotFoundException ex)
            {
                // Log a warning and return a NotFound result if no roles were found
                _logger.LogWarning(ex, "No roles found for user with ID {Id}", id);
                return NotFound(ex.Message);
            }
            catch (ArgumentException ex)
            {
                // Log a warning and return a BadRequest result if no roles were assigned
                _logger.LogWarning(ex, "No roles assigned for the user with ID {Id}", id);
                return BadRequest(ex.Message);
            }
            catch (Exception ex)
            {
                // Log an error and return a generic error message for unexpected errors
                _logger.LogError(ex, "An error occurred while retrieving roles for the user with ID {Id}", id);
                return StatusCode(500, "An error occurred while retrieving roles for the user. Please try again later.");
            }
        }

        /// <summary>
        /// Deletes a user by ID.
        /// </summary>
        /// <param name="id">The ID of the user to delete.</param>
        /// <returns>An IActionResult representing the result of the deletion operation.</returns>
        [HttpDelete("DeleteUserById")]
        public async Task<IActionResult> DeleteUserByIdAsync(string id)
        {
            try
            {
                // Call DeleteUserService to delete the user
                var result = await _adminService.DeleteUserService(id);

                // Return 200 OK with the result if successful
                return Ok(result);
            }
            catch (KeyNotFoundException ex)
            {
                // Log a warning for KeyNotFoundException
                _logger.LogWarning(ex, "User deletion failed: User not found with ID {Id}", id);

                // Return 404 Not Found with a custom error message
                return NotFound(new { message = $"User not found with ID {id}" });
            }
            catch (Exception ex)
            {
                // Log an error for any other exceptions
                _logger.LogError(ex, "An error occurred while deleting user with ID {Id}", id);

                // Return 500 Internal Server Error with a generic error message
                return StatusCode(500, new { message = "An error occurred while processing the request." });
            }
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
