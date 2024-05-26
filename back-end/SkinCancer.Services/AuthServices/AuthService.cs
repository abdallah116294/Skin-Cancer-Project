using AutoMapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using SkinCancer.Entities.Models;
using System.Text;
using Microsoft.AspNetCore.Identity.UI.Services;
using SkinCancer.Services.AuthServices.Interfaces;
using SkinCancer.Entities.AuthModels;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.IdentityModel.Tokens;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using SkinCancer.Entities.ModelsDtos.AuthenticationUserDtos;
namespace SkinCancer.Services.AuthServices
{
    public class AuthService : IAuthService
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly IConfiguration _configuration;
        private readonly IMapper _mapper;
        private readonly IEmailSender emailSender;
        private readonly IDataProtector _protector;
        public AuthService(UserManager<ApplicationUser> _userManager,
                           RoleManager<IdentityRole> _roleManager,
                           IConfiguration _configuration,
                           IMapper _mapper , IEmailSender emailSender,
                           IDataProtectionProvider dataProtection)
        { 
            this._userManager = _userManager;
            this._roleManager = _roleManager;
            this._configuration = _configuration;
            this._mapper = _mapper;
            this.emailSender = emailSender;
            _protector = dataProtection.CreateProtector("75DD1BB4-17AF-4504-B4FF-96BD6DF6E935");
        }

        // Done
        // Register New Patient without Authentication
        public async Task<ProcessResult> RegisterAsync(RegisterModel model)
        {
            if (await _userManager.FindByEmailAsync(model.Email) != null)
            {
                return new ProcessResult { Message = "This Email is Already Exists" };
            }

            if (await _userManager.FindByNameAsync(model.UserName) != null)
            {
                return new ProcessResult { Message = "This UserName Already Exitss" };
            }
            // Instead of assign each attribute in model to user attributes
            ApplicationUser user = _mapper.Map<ApplicationUser>(model);
            
            // Adding user (AppUser) + model.Password to call HashedPassword
            var result = new IdentityResult();
            try {

               result = await _userManager.CreateAsync(user, model.Password);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }

            if (!result.Succeeded)
            {
                string errorMessage = "";

                foreach (var itemError in result.Errors)
                {
                    errorMessage += $"{itemError.Description} , ";
                }

                return new ProcessResult { IsSucceeded = false, Message = errorMessage };
            }

            await _userManager.AddToRoleAsync(user, "PATIENT");

            return new ProcessResult { IsSucceeded = true, Message = "Added Successfully" };
        }
       
        public async Task<PatientDetailsDto> GetPatientDetails(string patientId)
        {
            try
            {
                var patient = await _userManager.FindByIdAsync(patientId) ?? throw new ArgumentException($"No Patient Found with this Id: {patientId}");

                var patientRoles = await _userManager.GetRolesAsync(patient);

                var patientRolesToLower = patientRoles.Select(role => role.ToLower())
                                                      .ToList();

                if (!patientRolesToLower.Contains("patient"))
                {
                    throw new InvalidOperationException("This User is not a patient.");
                }

                var dto = _mapper.Map<PatientDetailsDto>(patient);

                return dto;

            }
            catch (ArgumentException ex)
            {
                // Log the exception here if you have a logger
                // _logger.LogError(ex, "Invalid patient ID: {PatientId}", patientId);
                throw;
            }
            catch (InvalidOperationException ex)
            {
                // Log the exception here if you have a logger
                // _logger.LogError(ex, "Invalid operation for patient ID: {PatientId}", patientId);
                throw;
            }
            catch (Exception ex)
            {
                // Log the exception here if you have a logger
                // _logger.LogError(ex, "An error occurred while fetching patient details for patient ID: {PatientId}", patientId);
                throw new Exception("An error occurred while fetching patient details.", ex);
            }
        }
        

        // Done
        public async Task<ProcessResult> EmailConfirmationAsync(string UserId, string code)
        {
            if (UserId == null || code == null)
            {
                return new ProcessResult { Message = "Invalid Email" };
            }
               
            var user = await _userManager.FindByIdAsync(UserId);
            if (user == null)
            {
                return new ProcessResult { Message = "No user With this ID" };
            }

            code =/* Encoding.UTF8.GetString(WebEncoders.Base64UrlDecode(code));*/
                    _protector.Unprotect(code);
            var result = await _userManager.ConfirmEmailAsync(user, code);

            var processResult = new ProcessResult();
            processResult.Message = result.Succeeded ? "Thank You For Confirming Email" :
                                                        "Error Confirming Your Email";
            processResult.IsSucceeded = result.Succeeded;

            return processResult;
        }

        public async Task<ProcessResult> ForgetPassword(string email, string code)
        {
            if (string.IsNullOrEmpty(email))
            {
                return new ProcessResult { Message = "Email is not found" };
            }

            var user = await _userManager.FindByEmailAsync(email);

            user.Code = _protector.Protect(code);
            
            await _userManager.UpdateAsync(user);

            if (user == null)
            {
                return new ProcessResult { Message = "No User With this Email" };
            }

            if (!user.EmailConfirmed)
            {
                return new ProcessResult { Message = "Please Confrim Your Email" };
            }

            return new ProcessResult
            {
                IsSucceeded = true,
                // Look The Message here carry the Id of the user
                Message = user.Id
            };
        }

        public async Task<ProcessResult> ResetPasswordAsync(string UserId, string code, string newPassword)
        {

            var user = await _userManager.FindByIdAsync(UserId);
//773265‏
// 282816‏
            var unProtected = _protector.Unprotect(user.Code);
            //998427‏ 
            // there is a character added into the code so we have to check if there is something was 
            // added or not

            code = code.Length > 6 ? code.Substring(0, 6) : code;

           
            if (unProtected != code)
                return new ProcessResult { Message = "Code InCorrect!" };

            if (string.IsNullOrEmpty(newPassword))
                return new ProcessResult { Message = "Write Valid Password" };

            var removeResult = await _userManager.RemovePasswordAsync(user);

            if (!removeResult.Succeeded)
                return new ProcessResult { Message = string.Join(", ", removeResult.Errors.Select(er => er.Description)) };

            var changePassword = await _userManager.AddPasswordAsync(user, newPassword);

            if (!changePassword.Succeeded)
                return new ProcessResult { Message = string.Join(", ", changePassword.Errors.Select(er => er.Description)) };

            var updateUser = await _userManager.UpdateAsync(user);

            if (!updateUser.Succeeded)
                return new ProcessResult { Message = string.Join(", ", updateUser.Errors.Select(er => er.Description)) };


            return new ProcessResult { IsSucceeded = true,
                Message = $"Password Updated Successfully" };
        } 

        // Done
        // Login for User and get token 
        public async Task<AuthResult> LogInAsync(LoginModel model)

        {
            var authModel = new AuthResult();

            var user = await _userManager.FindByEmailAsync(model.Email);

            if (user is null || !await _userManager.CheckPasswordAsync(user,model.Password))
            {
                return new AuthResult { Message = "Email Or Password is not correct" };
            }

            if (!user.EmailConfirmed)
            {
                authModel.Message = "Email needed to be Confirmed";

                return authModel;
            }

            var jwtSecurityToken = await CreateJwtToken(user);
            var rolesList = await _userManager.GetRolesAsync(user);


            authModel.IsAuthenticated = true;
            authModel.Token = new JwtSecurityTokenHandler().WriteToken(jwtSecurityToken);
            authModel.Email = model.Email;
            // Notice we Now deal with user
            authModel.UserName = user.UserName;
            authModel.ExpireOn = jwtSecurityToken.ValidTo;
            authModel.Roles = rolesList.ToList();
            return authModel;
        }


        // Done
        // Assign a certain role for a user 
        public async Task<string> AddRoleAsync(RoleModel model)
        {
            // Input validation
            if (string.IsNullOrEmpty(model.UserName) || string.IsNullOrEmpty(model.RoleName))
            {
                return "Invalid input parameters";
            }

            var user = await _userManager.FindByNameAsync(model.UserName);

            // Check if user or role doesn't exist
            if (user is null || !await _roleManager.RoleExistsAsync(model.RoleName))
            {
                return "Invalid User Name or Role";
            }

            // Check if user is already assigned to the specified role
            if (await _userManager.IsInRoleAsync(user, model.RoleName))
            {
                return "User Already Assigned to this role";
            }

            var result = await _userManager.AddToRoleAsync(user, model.RoleName);

            if (!result.Succeeded)
            {
                // Log or provide more details about the failure
                return "Failed to assign role to user";
            }

            // Remove conflicting roles (Patient and Doctor)
            if (model.RoleName == "Doctor" || model.RoleName == "Patient")
            {
                var roles = await _userManager.GetRolesAsync(user);
                if (roles.Contains("Patient") && roles.Contains("Doctor"))
                {
                    var roleToRemove = model.RoleName == "Doctor" ? "Patient" : "Doctor";
                    await _userManager.RemoveFromRoleAsync(user, roleToRemove);
                }
            }

            return string.Empty; // Success
        }



        // Done
        // Generate New Token 
        public async Task<JwtSecurityToken> CreateJwtToken(ApplicationUser user)

        {
            var userClaims = await _userManager.GetClaimsAsync(user);
            var roles = await _userManager.GetRolesAsync(user);
            var roleClaim = new List<Claim>();
            
            foreach (var role in roles)
            {
                    roleClaim.Add(new Claim("roles", role));
            }

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub , user.UserName),
                new Claim(JwtRegisteredClaimNames.Jti , Guid.NewGuid().ToString()),
                new Claim(JwtRegisteredClaimNames.Email , user.Email),
                new Claim(ClaimTypes.PrimarySid , user.Id),
            }
            .Union(userClaims).Union(roleClaim);


            var symmetricSecurityKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(_configuration["JWT:Key"]));

            var signingCredentials = new SigningCredentials(symmetricSecurityKey,
                                         SecurityAlgorithms.HmacSha256);


            var jwtSecurityToken = new JwtSecurityToken(
                issuer: _configuration["JWT:Issuer"],
                audience: _configuration["JWT:Audience"],
                claims: claims,
                expires: DateTime.Now.AddDays(30),
                signingCredentials: signingCredentials
                );

            return jwtSecurityToken;
        }
        
    }
}
