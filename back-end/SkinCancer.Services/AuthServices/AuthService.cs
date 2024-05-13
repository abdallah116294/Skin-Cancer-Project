using AutoMapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using SkinCancer.Entities.Models;
using System.Text;
using Microsoft.AspNetCore.Identity.UI.Services;
using SkinCancer.Services.AuthServices.Interfaces;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.UserDtos;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.IdentityModel.Tokens;
namespace SkinCancer.Services.AuthServices
{
    public class AuthService : IAuthService
    {
        private readonly UserManager<ApplicationUser> userManager;
        private readonly RoleManager<IdentityRole> roleManager;
        private readonly IConfiguration configuration;
        private readonly IMapper mapper;
        private readonly IEmailSender emailSender;
        private readonly IDataProtector protector;
        public AuthService(UserManager<ApplicationUser> userManager,
                           RoleManager<IdentityRole> roleManager,
                           IConfiguration configuration,
                           IMapper mapper , IEmailSender emailSender,
                           IDataProtectionProvider dataProtection)
        { 
            this.userManager = userManager;
            this.roleManager = roleManager;
            this.configuration = configuration;
            this.mapper = mapper;
            this.emailSender = emailSender;
            protector = dataProtection.CreateProtector("75DD1BB4-17AF-4504-B4FF-96BD6DF6E935");
        }

        // Done
        // Register New Patient without Authentication
        public async Task<ProcessResult> RegisterAsync(RegisterModel model)
        {
            if (await userManager.FindByEmailAsync(model.Email) != null)
            {
                return new ProcessResult { Message = "This Email is Already Exists" };
            }

            if (await userManager.FindByNameAsync(model.UserName) != null)
            {
                return new ProcessResult { Message = "This UserName Already Exitss" };
            }
            // Instead of assign each attribute in model to user attributes
            ApplicationUser user = mapper.Map<ApplicationUser>(model);

            // Adding user (AppUser) + model.Password to call HashedPassword
            var result = await userManager.CreateAsync(user, model.Password);

            if (!result.Succeeded)
            {
                string errorMessage = "";

                foreach (var itemError in result.Errors)
                {
                    errorMessage += $"{itemError.Description} , ";
                }

                return new ProcessResult { IsSucceeded = false, Message = errorMessage };
            }

            await userManager.AddToRoleAsync(user, "PATIENT");

            return new ProcessResult { IsSucceeded = true, Message = "Added Successfully" };
        }

        // Done
        public async Task<ProcessResult> EmailConfirmationAsync(string UserId, string code)
        {
            if (UserId == null || code == null)
            {
                return new ProcessResult { Message = "Invalid Email" };
            }
               
            var user = await userManager.FindByIdAsync(UserId);
            if (user == null)
            {
                return new ProcessResult { Message = "No user With this ID" };
            }

            code =/* Encoding.UTF8.GetString(WebEncoders.Base64UrlDecode(code));*/
                    protector.Unprotect(code);
            var result = await userManager.ConfirmEmailAsync(user, code);

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

            var user = await userManager.FindByEmailAsync(email);

            user.Code = protector.Protect(code);
            
            await userManager.UpdateAsync(user);

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

            var user = await userManager.FindByIdAsync(UserId);
//773265‏
// 282816‏
            var unProtected = protector.Unprotect(user.Code);
            //998427‏ 
            // there is a character added into the code so we have to check if there is something was 
            // added or not

            code = code.Length > 6 ? code.Substring(0, 6) : code;

           
            if (unProtected != code)
                return new ProcessResult { Message = "Code InCorrect!" };

            if (string.IsNullOrEmpty(newPassword))
                return new ProcessResult { Message = "Write Valid Password" };

            var removeResult = await userManager.RemovePasswordAsync(user);

            if (!removeResult.Succeeded)
                return new ProcessResult { Message = string.Join(", ", removeResult.Errors.Select(er => er.Description)) };

            var changePassword = await userManager.AddPasswordAsync(user, newPassword);

            if (!changePassword.Succeeded)
                return new ProcessResult { Message = string.Join(", ", changePassword.Errors.Select(er => er.Description)) };

            var updateUser = await userManager.UpdateAsync(user);

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

            var user = await userManager.FindByEmailAsync(model.Email);

            if (user is null || !await userManager.CheckPasswordAsync(user,model.Password))
            {
                return new AuthResult { Message = "Email Or Password is not correct" };
            }

            if (!user.EmailConfirmed)
            {
                authModel.Message = "Email needed to be Confirmed";

                return authModel;
            }

            var jwtSecurityToken = await CreateJwtToken(user);
            var rolesList = await userManager.GetRolesAsync(user);


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
        public async Task<string> AddRoleAsync(RoleModel model) {

            var user = await userManager.FindByNameAsync(model.UserName);

            // check if user exist or the role required is existed
            if (user is null || !await roleManager.RoleExistsAsync(model.RoleName))
            {
                return "Invalid User Name or Role";
            }


            // check if he has a role before 
            if (await userManager.IsInRoleAsync(user, model.RoleName))
            {
                return "User Already Assigned to this role";
            }

            var result = await userManager.AddToRoleAsync(user, model.RoleName);

            return result.Succeeded ? string.Empty : "SomeThing Went Wrong";
        }


        // Done
        // Generate New Token 
        public async Task<JwtSecurityToken> CreateJwtToken(ApplicationUser user)

        {
            var userClaims = await userManager.GetClaimsAsync(user);
            var roles = await userManager.GetRolesAsync(user);
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
                Encoding.UTF8.GetBytes(configuration["JWT:Key"]));

            var signingCredentials = new SigningCredentials(symmetricSecurityKey,
                                         SecurityAlgorithms.HmacSha256);


            var jwtSecurityToken = new JwtSecurityToken(
                issuer: configuration["JWT:Issuer"],
                audience: configuration["JWT:Audience"],
                claims: claims,
                expires: DateTime.Now.AddDays(30),
                signingCredentials: signingCredentials
                );

            return jwtSecurityToken;
        }
        
    }
}
