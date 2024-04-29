using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using SkinCancer.Entities.Models;
using SkinCancer.Services.AuthServices.Interfaces;
using Microsoft.AspNetCore.Identity.UI.Services;
using SkinCancer.Entities.UserDtos;
using Microsoft.AspNetCore.WebUtilities;
using System.Text;
using System.Text.Encodings.Web;
using Microsoft.AspNetCore.Authentication;
using System.ComponentModel.DataAnnotations;
using SkinCancer.Services.AuthServices;
using Microsoft.VisualStudio.Web.CodeGenerators.Mvc.Templates.BlazorIdentity.Pages.Manage;
using Microsoft.AspNetCore.DataProtection;

namespace SkinCancer.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly IAuthService authService;
        private readonly UserManager<ApplicationUser> userManager;
        private readonly IEmailSender emailSender;
        private readonly IHttpContextAccessor httpContext;
        private readonly IDataProtector protector;
        public AccountController(IAuthService authService,
                                 UserManager<ApplicationUser> userManager,
                                 IEmailSender emailSender ,
                                 IHttpContextAccessor httpContext,
                                 IDataProtectionProvider dataProtection)
        {
            this.authService = authService;
            this.userManager = userManager;
            this.emailSender = emailSender;
            this.httpContext = httpContext;
            protector = dataProtection.CreateProtector("12345");
        }



        [HttpGet("ConfirmEmail")]
        public async Task<IActionResult> ConfirmEmail([FromQuery]ConfirmDto dto)
        {

            var result = await authService.EmailConfirmationAsync(dto.userId, dto.code);
            if (!result.IsSucceeded)
            {
                return BadRequest(result.Message);
            }

            return Ok(result.Message);
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
                var result = await authService.RegisterAsync(model);
                if (!result.IsSucceeded)
                {
                    return BadRequest(result.Message);
                }
                var callBackUrl = await GenerateConfirmEmailUrl(model.Email);
                var encodedUrl = HtmlEncoder.Default.Encode(callBackUrl);

                await emailSender.SendEmailAsync(model.Email, "Confirm your email",
                    $"Please confirm your account by <a href='{encodedUrl}'>clicking here</a>.");


                return Ok("Please Confirm Your Account");

            }
            catch
            {
                var user = await userManager.FindByEmailAsync(model.Email);
                var deleteResult = await userManager.DeleteAsync(user);

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

            var result = await authService.LogInAsync(model);
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
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var callBackUrl = await GenerateConfirmEmailUrl(email);
            var encodedUrl = HtmlEncoder.Default.Encode(callBackUrl);

            await emailSender.SendEmailAsync(email, "Confirm Your Email",
                $"Please confirm your account by <a href='{encodedUrl}'>clicking here</a>.");

            return Ok();
        }

        [HttpPost("ForgetPassword")]
        public async Task<IActionResult> ForgetPassword([EmailAddress, Required] string email)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var result = await authService.ForgetPassword(email);
            if (!result.IsSucceeded)
            {
                return BadRequest(result.Message);
            }

            string userId = result.Message;
            var callBackUrl = await GenerateResetPasswordUrl(userId);
            var encodedUrl = HtmlEncoder.Default.Encode(callBackUrl);

            await emailSender.SendEmailAsync(email, "Reset Password",
                $"To Reset Password <a href='{encodedUrl}'>clicking here</a>.");

            return Ok("Check Your Email To Reset Password");

        }

        [HttpPost("ResetPassword/{userId}/{code}")]
        public async Task<IActionResult> ResetPassword(
            string userId, string code, string newPassword)
        {
            var result = await authService.ResetPasswordAsync(userId, code, newPassword);
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

            var result = await authService.AddRoleAsync(model);
            if (!string.IsNullOrEmpty(result))
            {
                return BadRequest(result);
            }

            return Ok(model);
        }

        [HttpGet("GetAll")]
        public async Task<IActionResult> GetAll()
        {
            return Ok("Hello");
        }

        private async Task<string> GenerateConfirmEmailUrl(string email)
        {
            var user = await userManager.FindByEmailAsync(email);
            var code = await userManager.GenerateEmailConfirmationTokenAsync(user);
            code = /*WebEncoders.Base64UrlEncode(Encoding.UTF8.GetBytes(code));*/
                    protector.Protect(code);

            var request = httpContext.HttpContext.Request;
            var callbackUrl = request.Scheme + "://" + request.Host +
                                    Url.Action("ConfirmEmail", "Account",
                                    new { userId = user.Id, code = code});
            return callbackUrl;
        }

        private async Task<string> GenerateResetPasswordUrl(string userId)
        {
            var user = await userManager.FindByIdAsync(userId);
            var code = await userManager.GeneratePasswordResetTokenAsync(user);

            code = /*WebEncoders.Base64UrlEncode(Encoding.UTF8.GetBytes(code));*/
                    protector.Protect(code);

            var request = httpContext.HttpContext.Request;
            var callbackUrl = request.Scheme + "://" + request.Host +
                                    Url.Action("ResetPassword", "Account",
                                    new { userId = userId, code = code });

            return callbackUrl;
        }
    }
}