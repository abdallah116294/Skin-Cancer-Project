using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using SkinCancer.Entities.Models;
using SkinCancer.Services.AuthServices.Interfaces;
using Microsoft.AspNetCore.Identity.UI.Services;
using System.Text.Encodings.Web;
using Microsoft.AspNetCore.Authentication;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.DataProtection;
using SkinCancer.Entities.ModelsDtos.AuthenticationUserDtos;
using SkinCancer.Entities.AuthModels;
using Microsoft.AspNetCore.Http;
using SkinCancer.Api.ActionResponse;
using SkinCancer.Entities.ModelsDtos.PaymentDtos;
using SkinCancer.Services.AuthServices;

namespace SkinCancer.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly IAuthService _authService;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly IEmailSender _emailSender;
        private readonly IHttpContextAccessor _httpContextAccessor;
        private readonly IDataProtector _dataProtector;
        private readonly ILogger<AccountController> _logger;

        public AccountController(
            IAuthService authService,
            UserManager<ApplicationUser> userManager,
            IEmailSender emailSender,
            IHttpContextAccessor httpContextAccessor,
            IDataProtectionProvider dataProtectionProvider,
            ILogger<AccountController> logger)
        {
            _authService = authService;
            _userManager = userManager;
            _emailSender = emailSender;
            _httpContextAccessor = httpContextAccessor;
            _dataProtector = dataProtectionProvider.CreateProtector("75DD1BB4-17AF-4504-B4FF-96BD6DF6E935");
            _logger = logger;
        }

        /// <summary>
        /// Confirms the user's email based on the provided user ID and code.
        /// </summary>
        /// <param name="dto">The confirmation details containing user ID and code.</param>
        /// <returns>Returns a confirmation message.</returns>
        [HttpGet("ConfirmEmail")]
        public async Task<IActionResult> ConfirmEmail([FromQuery] ConfirmDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new ApiResponse<object>
                {
                    Success = false,
                    Message = "Invalid input."
                });
            }

            var result = await _authService.EmailConfirmationAsync(dto.userId, dto.code);

            if (!result.IsSucceeded)
            {
                return BadRequest(new ApiResponse<object>
                {
                    Success = false,
                    Message = result.Message
                });
            }

            return Ok(new ApiResponse<object>
            {
                Success = true,
                Message = result.Message,
                Data = result
            });
        }

        /// <summary>
        /// Retrieves the details of a patient by their ID.
        /// </summary>
        /// <param name="patientId">The ID of the patient to retrieve details for.</param>
        /// <returns>Returns the patient details.</returns>
        [HttpGet("GetPatientDetails")]
        public async Task<ActionResult<ApiResponse<PatientDetailsDto>>> GetPatientDetailsAsync(string patientId)
        {
            if (string.IsNullOrWhiteSpace(patientId))
            {
                return BadRequest(new ApiResponse<PatientDetailsDto>
                {
                    Success = false,
                    Message = "Patient ID cannot be null or empty."
                });
            }

            try
            {
                var patientDto = await _authService.GetPatientDetails(patientId);

                if (patientDto == null)
                {
                    return NotFound(new ApiResponse<PatientDetailsDto>
                    {
                        Success = false,
                        Message = "No patient found with the specified ID."
                    });
                }

                return Ok(new ApiResponse<PatientDetailsDto>
                {
                    Success = true,
                    Data = patientDto,
                    Message = "Successfully Gets Patient Details"
                });
            }
            catch (ArgumentException ex)
            {
                _logger.LogError(ex, "Argument exception while fetching patient details.");
                return BadRequest(new ApiResponse<PatientDetailsDto>
                {
                    Success = false,
                    Message = ex.Message
                });
            }
            catch (InvalidOperationException ex)
            {
                _logger.LogError(ex, "Invalid operation exception while fetching patient details.");
                return BadRequest(new ApiResponse<PatientDetailsDto>
                {
                    Success = false,
                    Message = ex.Message
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while fetching patient details.");
                return StatusCode(500, new ApiResponse<PatientDetailsDto>
                {
                    Success = false,
                    Message = "An error occurred while fetching patient details."
                });
            }
        }

        /// <summary>
        /// Retrieves the details of a doctor by their ID.
        /// </summary>
        /// <param name="doctorId">The ID of the doctor to retrieve details for.</param>
        /// <returns>Returns the doctor details.</returns>
        [HttpGet("GetDoctorDetails")]
        public async Task<ActionResult<ApiResponse<DoctorDetailsDto>>> GetDoctorDetailsAsync(string doctorId)
        {
            if (string.IsNullOrWhiteSpace(doctorId))
            {
                return BadRequest(new ApiResponse<DoctorDetailsDto>
                {
                    Success = false,
                    Message = "Doctor ID cannot be null or empty."
                });
            }

            try
            {
                var doctorDto = await _authService.GetDoctorDetails(doctorId);

                if (doctorDto == null)
                {
                    return NotFound(new ApiResponse<DoctorDetailsDto>
                    {
                        Success = false,
                        Message = "No doctor found with the specified ID."
                    });
                }

                return Ok(new ApiResponse<DoctorDetailsDto>
                {
                    Success = true,
                    Data = doctorDto
                });
            }
            catch (ArgumentException ex)
            {
                _logger.LogError(ex, "Argument exception while fetching doctor details.");
                return BadRequest(new ApiResponse<DoctorDetailsDto>
                {
                    Success = false,
                    Message = ex.Message
                });
            }
            catch (InvalidOperationException ex)
            {
                _logger.LogError(ex, "Invalid operation exception while fetching doctor details.");
                return BadRequest(new ApiResponse<DoctorDetailsDto>
                {
                    Success = false,
                    Message = ex.Message
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while fetching doctor details.");
                return StatusCode(500, new ApiResponse<DoctorDetailsDto>
                {
                    Success = false,
                    Message = "An error occurred while fetching doctor details."
                });
            }
        }

        /// <summary>
        /// Registers a new user with the provided registration details.
        /// </summary>
        /// <param name="model">The registration details.</param>
        /// <returns>Returns a confirmation message.</returns>
        [HttpPost("Register")]
        public async Task<IActionResult> Register(RegisterModel model)
        {
            try
            {
                var result = await _authService.RegisterAsync(model);

                if (!result.IsSucceeded)
                {
                    return BadRequest(new ApiResponse<object>
                    {
                        Success = false,
                        Message = result.Message
                    });
                }

                var callBackUrl = await _authService.GenerateConfirmEmailUrl(model.Email);
                var encodedUrl = HtmlEncoder.Default.Encode(callBackUrl);

                await _emailSender.SendEmailAsync(model.Email, "Confirm your email",
                    $"Please confirm your account by <a href='{encodedUrl}'>clicking here</a>.");

                return Ok(new ApiResponse<object>
                {
                    Success = true,
                    Message = "Please Confirm Your Account"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred during registration.");
                var user = await _userManager.FindByEmailAsync(model.Email);
                if (user != null)
                {
                    var deleteResult = await _userManager.DeleteAsync(user);
                    if (!deleteResult.Succeeded)
                    {
                        return BadRequest(new ApiResponse<object>
                        {
                            Success = false,
                            Message = "User registration failed and cleanup failed."
                        });
                    }
                }
                return BadRequest(new ApiResponse<object>
                {
                    Success = false,
                    Message = "Register Failed, Please Register Again"
                });
            }
        }

        /// <summary>
        /// Logs in a user with the provided login details.
        /// </summary>
        /// <param name="model">The login details.</param>
        /// <returns>Returns authentication result.</returns>
        [HttpPost("Login")]
        public async Task<IActionResult> Login(LoginModel model)
        {
            var result = await _authService.LogInAsync(model);

            if (!result.IsAuthenticated)
            {
                return BadRequest(new ApiResponse<object>
                {
                    Success = false,
                    Message = result.Message
                });
            }

            return Ok(new ApiResponse<object>
            {
                Success = true,
                Data = result
            });
        }


        /// <summary>
        /// Logs out the current user.
        /// </summary>
        /// <returns>Returns a logout confirmation message.</returns>
        [HttpPost("Logout")]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync();
            return Ok(new ApiResponse<object>
            {
                Success = true,
                Message = "You Are Logged Out"
            });
        }
        /// <summary>
        /// Resends email confirmation to the specified email address.
        /// </summary>
        /// <param name="email">The email address to resend confirmation to.</param>
        /// <returns>Returns a confirmation message.</returns>
        [HttpPost("ResendEmailConfirmation")]
        public async Task<IActionResult> ResendEmailConfirmation([EmailAddress, Required] string email)
        {
            var callBackUrl = await _authService.GenerateConfirmEmailUrl(email);
            var encodedUrl = HtmlEncoder.Default.Encode(callBackUrl);

            await _emailSender.SendEmailAsync(email, "Confirm Your Email",
                $"Please confirm your account by <a href='{encodedUrl}'>clicking here</a>.");

            return Ok(new ApiResponse<object>
            {
                Success = true,
                Message = "Confirmation email sent."
            });
        }

        /// <summary>
        /// Handles forgot password scenario by generating a reset password URL and sending it via email.
        /// </summary>
        /// <param name="email">The email address associated with the account.</param>
        /// <returns>Returns a confirmation message.</returns>
        [HttpPost("ForgetPassword")]
        public async Task<IActionResult> ForgetPassword(
            [FromBody] [EmailAddress, Required]
            string email , string code)
        {
            var result = await _authService.ForgetPassword(email , code);

            if (!result.IsSucceeded)
            {
                return BadRequest(new ApiResponse<object>
                {
                    Success = false,
                    Message = result.Message
                });
            }

            var callBackUrl = await _authService.GenerateResetPasswordUrl(email);
            var encodedUrl = HtmlEncoder.Default.Encode(callBackUrl);

            await _emailSender.SendEmailAsync(email, "Reset Your Password",
                $"Please reset your password by <a href='{encodedUrl}'>clicking here</a>.");

            return Ok(new ApiResponse<object>
            {
                Success = true,
                Message = "Password reset email sent."
            });
        }

        /// <summary>
        /// Resets the user's password based on the provided details.
        /// </summary>
        /// <param name="dto">The password reset details.</param>
        /// <returns>Returns a confirmation message.</returns>
        [HttpPost("ResetPassword")]
        public async Task<IActionResult> ResetPassword([FromBody] ResetPasswordDto dto)
        {
            var result = await _authService.ResetPasswordAsync
                (dto.Email , dto.Code , dto.newPassword);

            if (!result.IsSucceeded)
            {
                return BadRequest(new ApiResponse<object>
                {
                    Success = false,
                    Message = result.Message
                });
            }

            return Ok(new ApiResponse<object>
            {
                Success = true,
                Message = "Password has been reset."
            });
        }

        /// <summary>
        /// Adds a role to a user based on the provided details.
        /// </summary>
        /// <param name="model">The role assignment details.</param>
        /// <returns>Returns a confirmation message.</returns>
        [HttpPost("AddRole")]
        public async Task<IActionResult> AddRoleAsync(RoleModel model)
        {

            try
            {
                var result = await _authService.AddRoleAsync(model);

                if (string.IsNullOrWhiteSpace(result))
                {
                    return BadRequest(new ApiResponse<object>
                    {
                        Success = false,
                        Message = "Failed to assign role."
                    });
                }

                return Ok(new ApiResponse<object>
                {
                    Success = true,
                    Message = result
                });
            }
            catch (ArgumentException ex)
            {
                _logger.LogError(ex, "Argument exception while adding role.");
                return BadRequest(new ApiResponse<object>
                {
                    Success = false,
                    Message = ex.Message
                });
            }
            catch (InvalidOperationException ex)
            {
                _logger.LogError(ex, "Invalid operation exception while adding role.");
                return BadRequest(new ApiResponse<object>
                {
                    Success = false,
                    Message = ex.Message
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while adding role.");
                return StatusCode(500, new ApiResponse<object>
                {
                    Success = false,
                    Message = "An error occurred while adding role."
                });
            }
        }
    }
}
