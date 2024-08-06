using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using System.IdentityModel.Tokens.Jwt;
using SkinCancer.Entities.ModelsDtos.AuthenticationUserDtos;

namespace SkinCancer.Services.AuthServices.Interfaces
{
    public interface IAuthService
    {

        public Task<ProcessResult> RegisterAsync(RegisterModel model);

        public Task<string> GenerateConfirmEmailUrl(string  email);

        public Task<string> GenerateResetPasswordUrl(string userId);

        public Task<PatientDetailsDto> GetPatientDetails(string patientId);

        public Task<DoctorDetailsDto> GetDoctorDetails(string doctorId);

        public Task<ProcessResult> EmailConfirmationAsync(string UserId, string code);

        public Task<ProcessResult> ForgetPassword(string email , string code);

        public Task<ProcessResult> ResetPasswordAsync(string UserId, string code , string newPassword);

        public Task<AuthResult> LogInAsync(LoginModel model);

        //public Task<JwtSecurityToken> CreateJwtToken(ApplicationUser user);
        public Task<JwtSecurityToken> CreateJwtToken(ApplicationUser user);

        public Task<string> AddRoleAsync(RoleModel model); 
    }
}
