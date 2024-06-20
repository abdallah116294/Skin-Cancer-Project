// Ignore Spelling: Admin

using AutoMapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Logging;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.AdminDtos;
using SkinCancer.Entities.ModelsDtos.AuthenticationUserDtos;
using SkinCancer.Repositories.Interface;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Reflection.Emit;
using System.Threading.Tasks;

namespace SkinCancer.Services.AdminServices
{
    public class AdminService : IAdminService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly ILogger<AdminService> _logger;
        private readonly IMapper _mapper;
        private readonly UserManager<ApplicationUser> _userManager;

        public AdminService(IUnitOfWork unitOfWork, 
                            ILogger<AdminService> logger,
                            IMapper mapper,
                            UserManager<ApplicationUser> userManager
                           )
        {
            _unitOfWork = unitOfWork ?? throw new ArgumentNullException(nameof(unitOfWork));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
            _userManager = userManager ?? throw new ArgumentNullException(nameof(userManager));
        }

        /// <summary>
        /// Creates a new clinic.
        /// </summary>
        /// <param name="clinic">The clinic to create.</param>
        /// <returns>The created clinic.</returns>
        /// <exception cref="ApplicationException">Thrown when an error occurs while creating the clinic.</exception>
        public async Task<Clinic> CreateClinicService(AdminClinicDto dto)
        {
            try
            {
                await ValidateClinic(dto);

                var clinic = _mapper.Map<Clinic>(dto);
                await _unitOfWork.Reposirory<Clinic>().AddAsync(clinic);
                await _unitOfWork.CompleteAsync();

                return clinic;
            }
            catch (ValidationException ex)
            {
                _logger.LogWarning(ex, "Validation error occurred while creating clinic.");
                throw; // Rethrow to be caught in the controller for proper response
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while creating new clinic");
                throw new ApplicationException("An error occurred while creating new clinic. See inner exception for details.", ex);
            }
        }

        
        /// <summary>
        /// Deletes a clinic by ID.
        /// </summary>
        /// <param name="id">The ID of the clinic to delete.</param>
        /// <returns>The deleted clinic.</returns>
        /// <exception cref="KeyNotFoundException">Thrown when no clinic with the specified ID is found.</exception>
        /// <exception cref="ApplicationException">Thrown when an error occurs while deleting the clinic.</exception>
        public async Task<Clinic> DeleteClinicService(int id)
        {
            try
            {
                var clinic = await GetClinicByIdService(id)
                    ?? throw new KeyNotFoundException($"No Clinic Found with this ID: {id}");

                _unitOfWork.Reposirory<Clinic>().Delete(clinic);
                await _unitOfWork.CompleteAsync();

                return clinic;
            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogWarning(ex, "No clinic found with ID {Id}", id);
                throw;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while deleting clinic with ID {Id}", id);
                throw new ApplicationException("An error occurred while deleting the clinic. See inner exception for details.", ex);
            }
        }

        /// <summary>
        /// Deletes a user by ID.
        /// </summary>
        /// <param name="id">The ID of the user to delete.</param>
        /// <returns>A ProcessResult indicating the success or failure of the operation.</returns>
        public async Task<ProcessResult> DeleteUserService(string id)
        {
            try
            {
                // Attempt to retrieve the user by ID; throws KeyNotFoundException if user not found
                var user = await GetUserByIdService(id)
                           ?? throw new KeyNotFoundException($"No user found with ID: {id}");

                // Call repository method to delete the user
                await _unitOfWork.userRepository.DeleteUserRepository(id);

                // Return success result
                return new ProcessResult
                {
                    IsSucceeded = true,
                    Message = "User removed successfully"
                };
            }
            catch (KeyNotFoundException ex)
            {
                // Log a warning if user was not found
                _logger.LogWarning(ex, "User with ID {Id} not found", id);

                // Rethrow the exception to be caught by the controller
                throw;
            }
            catch (Exception ex)
            {
                // Log an error for any unexpected exception
                _logger.LogError(ex, "An error occurred while deleting user with ID {Id}", id);

                // Throw a new ApplicationException with a meaningful message
                throw new ApplicationException("An error occurred while deleting the user. See inner exception for details.", ex);
            }
        }

        public async Task<IEnumerable<ApplicationUser>> GetAllAdminsService()
        {
            try
            {
                if (_userManager == null)
                {
                    throw new NullReferenceException("_userManager is null");
                }
                var admins = await _userManager.GetUsersInRoleAsync("Admin");
                return admins ?? Enumerable.Empty<ApplicationUser>();
            }
            catch (Exception ex)
            {
                // Log the error and throw an application exception
                _logger.LogError(ex, "An error occurred while retrieving users in Admin role.");
                throw new ApplicationException("An error occurred while retrieving users in Admin role. See inner exception for details.", ex);
            }
        }

        /// <summary>
        /// Retrieves all clinics.
        /// </summary>
        /// <returns>A collection of all clinics.</returns>
        /// <exception cref="KeyNotFoundException">Thrown when no clinics are found.</exception>
        /// <exception cref="ApplicationException">Thrown when an error occurs while retrieving the clinics.</exception>
        public async Task<IEnumerable<Clinic>> GetAllClinicService()
        {
            try
            {
                var clinics = await _unitOfWork.Reposirory<Clinic>().GetAllAsync();

                return clinics ?? throw new KeyNotFoundException("No clinics found.");
            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogWarning(ex, "No clinics found.");
                throw;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while retrieving clinics");
                throw new ApplicationException("An error occurred while retrieving clinics. See inner exception for details.", ex);
            }
        }

        public async Task<IEnumerable<ApplicationUser>> GetAllDoctorsService()
        {
            try
            {
                // Ensure _userManager is not null before using it
                if (_userManager == null)
                {
                    throw new NullReferenceException("_userManager is null");
                }

                // Retrieve users in the "Doctor" role
                var doctors = await _userManager.GetUsersInRoleAsync("Doctor");

                // Return an empty collection if no users are found
                return doctors ?? Enumerable.Empty<ApplicationUser>();
            }
            catch (Exception ex)
            {
                // Log the error and throw an application exception
                _logger.LogError(ex, "An error occurred while retrieving users in Doctor role.");
                throw new ApplicationException("An error occurred while retrieving users in Doctor role. See inner exception for details.", ex);
            }
        }



        public async Task<IEnumerable<ApplicationUser>> GetAllPatientsService()
        {
            try
            {
                // Ensure _userManager is not null before using it
                if (_userManager == null)
                {
                    throw new NullReferenceException("_userManager is null");
                }

                // Retrieve users in the "Patient" role
                var users = await _userManager.GetUsersInRoleAsync("Patient");

                // Return an empty collection if no users are found
                return users ?? Enumerable.Empty<ApplicationUser>();
            }
            catch (Exception ex)
            {
                // Log the error and throw an application exception
                _logger.LogError(ex, "An error occurred while retrieving users in Patient role.");
                throw new ApplicationException("An error occurred while retrieving users in Patient role. See inner exception for details.", ex);
            }
        }


        /// <summary>
        /// Retrieves all users.
        /// </summary>
        /// <returns>A collection of all users.</returns>
        /// <exception cref="KeyNotFoundException">Thrown when no users are found.</exception>
        /// <exception cref="ApplicationException">Thrown when an error occurs while retrieving the users.</exception>
        public async Task<IEnumerable<ApplicationUser>> GetAllUsersService()
        {
            try
            {
                var users = await _unitOfWork.userRepository.GetAllUsersRepository();
                return users ?? throw new KeyNotFoundException("No users found.");
            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogWarning(ex, "No users found.");
                throw;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while retrieving users.");
                throw new ApplicationException("An error occurred while retrieving users. See inner exception for details.", ex);
            }
        }

        /// <summary>
        /// Retrieves a clinic by ID.
        /// </summary>
        /// <param name="id">The ID of the clinic to retrieve.</param>
        /// <returns>The clinic with the specified ID.</returns>
        /// <exception cref="KeyNotFoundException">Thrown when no clinic with the specified ID is found.</exception>
        /// <exception cref="ApplicationException">Thrown when an error occurs while retrieving the clinic.</exception>
        public async Task<Clinic> GetClinicByIdService(int id)
        {
            try
            {
                var clinic = await _unitOfWork.Reposirory<Clinic>().GetByIdAsync(id);

                return clinic ?? throw new KeyNotFoundException($"No Clinic found with ID: {id}");
            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogWarning(ex, "No clinic found with ID {Id}", id);
                throw;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while retrieving clinic with ID {Id}", id);
                throw new ApplicationException("An error occurred while retrieving the clinic. See inner exception for details.", ex);
            }
        }

        /// <summary>
        /// Retrieves a user by ID.
        /// </summary>
        /// <param name="id">The ID of the user to retrieve.</param>
        /// <returns>The user with the specified ID.</returns>
        /// <exception cref="KeyNotFoundException">Thrown when no user with the specified ID is found.</exception>
        /// <exception cref="ApplicationException">Thrown when an error occurs while retrieving the user.</exception>
        public async Task<ApplicationUser> GetUserByIdService(string id)
        {
            try
            {
                // Attempt to retrieve the user from the repository
                var user = await _unitOfWork.userRepository.GetUserByIdRepository(id)
                           ?? throw new KeyNotFoundException($"No user found with ID {id}");

                return user;
            }
            catch (KeyNotFoundException ex)
            {
                // Log a warning message indicating that the user was not found
                _logger.LogWarning(ex, "No user found with ID {Id}", id);
                throw;
            }
            catch (Exception ex)
            {
                // Log an error message indicating that an unexpected error occurred
                _logger.LogError(ex, "An error occurred while retrieving the user with ID {Id}", id);
                throw new ApplicationException("An error occurred while retrieving the user data. See inner exception for details.", ex);
            }
        }

        /// <summary>
        /// Retrieves the roles assigned to a user by ID.
        /// </summary>
        /// <param name="id">The ID of the user whose roles are to be retrieved.</param>
        /// <returns>A collection of roles assigned to the user.</returns>
        /// <exception cref="KeyNotFoundException">Thrown when no user with the specified ID is found.</exception>
        /// <exception cref="ArgumentException">Thrown when the user has no roles assigned.</exception>
        /// <exception cref="ApplicationException">Thrown when an error occurs while retrieving the user's roles.</exception>
        public async Task<IEnumerable<string>> GetUserRolesService(string id)
        {
            try
            {
                // Retrieve the user by ID
                var user = await GetUserByIdService(id)
                           ?? throw new KeyNotFoundException($"No user found with ID: {id}");

                // Retrieve the roles assigned to the user
                var userRoles = await _userManager.GetRolesAsync(user);

                if (userRoles == null || !userRoles.Any())
                {
                    throw new ArgumentException($"No roles assigned for the user with ID: {id}");
                }

                return userRoles;
            }
            catch (KeyNotFoundException ex)
            {
                // Log a warning and rethrow the exception if the user was not found
                _logger.LogWarning(ex, "No user found with ID {Id}", id);
                throw;
            }
            catch (ArgumentException ex)
            {
                // Log a warning and rethrow the exception if the user has no roles assigned
                _logger.LogWarning(ex, "No roles assigned for the user with ID {Id}", id);
                throw;
            }
            catch (Exception ex)
            {
                // Log an error and throw an application exception for unexpected errors
                _logger.LogError(ex, "An error occurred while retrieving roles for the user with ID {Id}", id);
                throw new ApplicationException("An error occurred while retrieving roles for the user. See inner exception for details.", ex);
            }
        }

        /// <summary>
        /// Updates a clinic.
        /// </summary>
        /// <param name="id">The ID of the clinic to update.</param>
        /// <param name="updatedClinic">The updated clinic data.</param>
        /// <returns>The updated clinic.</returns>
        /// <exception cref="KeyNotFoundException">Thrown when no clinic with the specified ID is found.</exception>
        /// <exception cref="ApplicationException">Thrown when an error occurs while updating the clinic.</exception>
        public async Task<Clinic> UpdateClinicService(int id, AdminClinicDto updatedClinic)
        {
            try
            {
                var existingClinic = await GetClinicByIdService(id)
                    ?? throw new KeyNotFoundException($"No clinic found with ID: {id}");

                await ValidateClinic(updatedClinic);
                // Update the properties
                existingClinic.Name = updatedClinic.Name;
                existingClinic.Price = updatedClinic.Price;
                existingClinic.Phone = updatedClinic.Phone;
                existingClinic.Address = updatedClinic.Address;
                existingClinic.Image = updatedClinic.Image;
                existingClinic.Description = updatedClinic.Description;
                existingClinic.DoctorName = updatedClinic.DoctorName;
                existingClinic.DoctorId = updatedClinic.DoctorId;

                _unitOfWork.Reposirory<Clinic>().Update(existingClinic);
                await _unitOfWork.CompleteAsync();

                return existingClinic;
            }
            catch (KeyNotFoundException ex)
            {
                _logger.LogWarning(ex, "No clinic found with ID {Id}", id);
                throw;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while updating clinic with ID {Id}", id);
                throw new ApplicationException("An error occurred while updating the clinic. See inner exception for details.", ex);
            }
        }

        /// <summary>
        /// Updates a user.
        /// </summary>
        /// <param name="id">The ID of the user to update.</param>
        /// <param name="user">The updated user data.</param>
        /// <returns>The updated user.</returns>
        /// <exception cref="ApplicationException">Thrown when an error occurs while updating the user.</exception>
        public async Task<ApplicationUser> UpdateUserService(string id, RegisterModel user)
        {
            try
            {
                if (user == null) throw new ArgumentNullException(nameof(user));

                var updatedUser = await _unitOfWork.userRepository.UpdateUserRepository(id, user);
                await _unitOfWork.CompleteAsync();

                return updatedUser;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while updating user with ID {Id}", id);
                throw new ApplicationException("An error occurred while updating the user. See inner exception for details.", ex);
            }
        }

        /// <summary>
        /// Validates a clinic DTO.
        /// </summary>
        /// <param name="clinic">The clinic DTO to validate.</param>
        /// <exception cref="ValidationException">Thrown when validation fails.</exception>
        private async Task ValidateClinic(AdminClinicDto clinic)
        {
            var validationErrors = new List<string>();

            if (clinic == null)
            {
                validationErrors.Add("Clinic object cannot be null.");
            }
            else
            {
                if (string.IsNullOrEmpty(clinic.Name))
                {
                    validationErrors.Add("Clinic Name is required.");
                }
                else if (clinic.Name.Length > 100)
                {
                    validationErrors.Add("Clinic Name cannot exceed 100 characters.");
                }

                if (clinic.Price < 0)
                {
                    validationErrors.Add("Clinic Price should be positive.");
                }

                if (string.IsNullOrEmpty(clinic.Phone))
                {
                    validationErrors.Add("Phone Number is required.");
                }
                else if (clinic.Phone.Length > 25)
                {
                    validationErrors.Add("Phone Number cannot exceed 25 characters.");
                }

                if (string.IsNullOrEmpty(clinic.DoctorName))
                {
                    validationErrors.Add("Doctor Name is required.");
                }
                else if (clinic.DoctorName.Length > 100)
                {
                    validationErrors.Add("Doctor Name cannot exceed 100 characters.");
                }
            }

            var user = await _userManager.FindByIdAsync(clinic.DoctorId);
            if (user == null)
            {
                validationErrors.Add($"No User Found With Id {clinic.DoctorId}");
            }
            else
            {
                var userRoles = await _userManager.GetRolesAsync(user);
                if (!userRoles.Any(role => role.Equals("Doctor", StringComparison.OrdinalIgnoreCase)))
                {
                    validationErrors.Add($"This User is not in a doctor role");
                }
            }

            if (validationErrors.Any())
            {
                throw new ValidationException(string.Join(Environment.NewLine, validationErrors));
            }
        }
    }
}
