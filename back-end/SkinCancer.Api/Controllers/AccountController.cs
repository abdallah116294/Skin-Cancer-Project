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

namespace SkinCancer.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly IAuthService _authService;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly IEmailSender _emailSender;
        private readonly IHttpContextAccessor _httpContext;
        private readonly IDataProtector _protector;
        public AccountController(IAuthService authService,
                                 UserManager<ApplicationUser> _userManager,
                                 IEmailSender _emailSender,
                                 IHttpContextAccessor _httpContext,
                                 IDataProtectionProvider dataProtection
                                )
        {
            this._authService = authService;
            this._userManager = _userManager;
            this._emailSender = _emailSender;
            this._httpContext = _httpContext;
            _protector = dataProtection.CreateProtector("75DD1BB4-17AF-4504-B4FF-96BD6DF6E935");
        }


        [HttpGet("ConfirmEmail")]
        public async Task<IActionResult> ConfirmEmail([FromQuery]ConfirmDto dto)
        {

            var result = await _authService.EmailConfirmationAsync(dto.userId, dto.code);
            if (!result.IsSucceeded)
            {
                return BadRequest(result.Message);
            }

            return Ok(result.Message);
        }

        [HttpGet("GetPatientDetails")]
        public async Task<ActionResult> GetPatientDetailsAsync(string patientId)
        {
            if (string.IsNullOrWhiteSpace(patientId))
            {
                return BadRequest(new ProcessResult
                {
                    Message = "Patient ID cannot be null or empty."
                });
            }

            try
            {
                var patientDto = await _authService.GetPatientDetails(patientId);

                if (patientDto == null)
                {
                    return NotFound(new { Message = "No patient found with the specified ID." });
                }

                return Ok(patientDto);
            }
            catch(ArgumentException ex)
            {
                return BadRequest(new { Message = ex.Message });
            }
            catch(InvalidOperationException ex)
            {
                return BadRequest(new { Message = ex.Message });
            }

            catch(Exception ex) 
            {
                return StatusCode(500, new { Message = "An error occurred while fetching patient details." });
            }
        }

        [HttpGet("GetDoctorDetails")]
        public async Task<ActionResult> GetDoctorDetailsAsync(string doctorId)
        {
            if (string.IsNullOrWhiteSpace(doctorId)) 
            {
                return BadRequest(new ProcessResult
                {
                    Message = "doctorId can't be null or empty"
                });
            }

            try
            {
                var doctorDto = await _authService.GetDoctorDetails(doctorId);

                if (doctorDto == null)
                {
                    return NotFound(new { Message = "No patient found with the specified ID." });
                }

                return Ok(doctorDto);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { Message = ex.Message });
            }
            catch (InvalidOperationException ex)
            {
                return BadRequest(new { Message = ex.Message });
            }

            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "An error occurred while fetching doctor details." });
            }
        }

        [HttpPost("Register")]
        public async Task<IActionResult> Register(RegisterModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var result = await _authService.RegisterAsync(model);
                if (!result.IsSucceeded)
                {
                    return BadRequest(result.Message);
                }
                var callBackUrl = await GenerateConfirmEmailUrl(model.Email);
                var encodedUrl = HtmlEncoder.Default.Encode(callBackUrl);

                await _emailSender.SendEmailAsync(model.Email, "Confirm your email",
                    $"Please confirm your account by <a href='{encodedUrl}'>clicking here</a>.");

                return Ok("Please Confirm Your Account");

            }
            catch
            {
                var user = await _userManager.FindByEmailAsync(model.Email);

                var deleteResult = await _userManager.DeleteAsync(user);

                if (!deleteResult.Succeeded)
                {
                    return BadRequest("Not Deleted");
                }
                return BadRequest("Register Failed, Please Register Again");
            }
        }

        [HttpPost("Login")]
        public async Task<IActionResult> Login(LoginModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var result = await _authService.LogInAsync(model);
            if (!result.IsAuthenticated)
            {
                return BadRequest(result.Message);
            }

            return Ok(result);
        }

        [HttpPost("Logout")]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync();

            return Ok();
        }

        [HttpPost("ResendEmailConfirmation")]
        public async Task<IActionResult> ResendEmailConfirmation(
            [EmailAddress, Required] string email)
        {      //sdfsdf
            if (!ModelState.IsValid)
            {      
                return BadRequest(ModelState);
            }

            var callBackUrl = await GenerateConfirmEmailUrl(email);
            var encodedUrl = HtmlEncoder.Default.Encode(callBackUrl);

            await _emailSender.SendEmailAsync(email, "Confirm Your Email",
                $"Please confirm your account by <a href='{encodedUrl}'>clicking here</a>.");

            return Ok();
        }

        [HttpPost("ForgetPassword")]
        public async Task<IActionResult> ForgetPassword(string email)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var user = await _userManager.FindByEmailAsync(email);
            var callBackUrl = await GenerateResetPasswordUrl(user.Id);

            var result = await _authService.ForgetPassword(email , callBackUrl);

            if (!result.IsSucceeded)
            {
                return BadRequest(result.Message);
            }
            
            //_httpContext.HttpContext.Response.Cookies.Append("UserId",user.Id);
            Response.Cookies.Append("UserId",user.Id);

            string userId = result.Message;

            //var encodedUrl = HtmlEncoder.Default.Encode(callBackUrl);

            await _emailSender.SendEmailAsync(email, callBackUrl, "Confirm Code Please");

            return Ok("Check Your Email To Reset Password");

        }

        [HttpPost("ResetPassword")]
        public async Task<IActionResult> ResetPassword([FromBody] ResetPasswordDto dto)
        {
           
           var user=await _userManager.FindByEmailAsync (dto.Email);


			if (user==null)
                return BadRequest("User Not Found");

            var result = await _authService.ResetPasswordAsync(user.Id, dto.Code, dto.newPassword);

            if (!result.IsSucceeded)
            {
                return BadRequest(result.Message);
            }

            return Ok(result.Message);
        }

        [HttpPost("AddRole")]
        public async Task<IActionResult> AddRoleAsync(RoleModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var result = await _authService.AddRoleAsync(model);
            if (!string.IsNullOrEmpty(result))
            {
                return BadRequest(result);
            }

            return Ok(model);
        }

        private async Task<string> GenerateConfirmEmailUrl(string email)
        {
            var user = await _userManager.FindByEmailAsync(email);
            var code = await _userManager.GenerateEmailConfirmationTokenAsync(user);
            code = _protector.Protect(code);

            var request = _httpContext.HttpContext.Request;

            var callbackUrl = request.Scheme + "://" + request.Host +
                                    Url.Action("ConfirmEmail", "Account",
                                    new { userId = user.Id, code = code});
            return callbackUrl;
        }

        private async Task<string> GenerateResetPasswordUrl(string userId)
        {
            var user = await _userManager.FindByIdAsync(userId);

            var random = new Random();
            
            var code = random.Next(0, 1000000).ToString("D6");
            
            return code.ToString();
        }

    }
}