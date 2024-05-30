// File: SkinCancer.Services.ClinicServices/ClinicService.cs

using AutoMapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.DoctorClinicDtos;
using SkinCancer.Entities.ModelsDtos.PatientDtos;
using SkinCancer.Repositories.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SkinCancer.Services.ClinicServices
{
    public class ClinicService : IClinicService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly ILogger<ClinicService> _logger;
        private readonly IMapper _mapper;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly UserManager<ApplicationUser> _userManager;

        public ClinicService(IUnitOfWork unitOfWork, IMapper mapper,
                             RoleManager<IdentityRole> roleManager,
                             UserManager<ApplicationUser> userManager,
                             ILogger<ClinicService> logger)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _roleManager = roleManager;
            _userManager = userManager;
            _logger = logger;
        }

        public async Task<ProcessResult> CreateClinicAsync(CreateClinicDto dto)
        {
            try
            {
                var clinic = _mapper.Map<Clinic>(dto);
                await _unitOfWork.Reposirory<Clinic>().AddAsync(clinic);
                await _unitOfWork.CompleteAsync();



                return new ProcessResult
                {
                    IsSucceeded = true,
                    Message = "Clinic Created Successfully"
                };
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while creating clinic and appointment");
                return new ProcessResult
                {
                    IsSucceeded = false,
                    Message = "An error occurred while creating clinic and appointment"
                };
            }
        }

        public async Task<ProcessResult> DeleteClinicAsync(int id)
        {
            try
            {
                var clinic = await _unitOfWork.Reposirory<Clinic>().GetByIdAsync(id);
                if (clinic == null)
                {
                    return new ProcessResult
                    {
                        Message = $"Clinic with ID '{id}' not found."
                    };
                }

                _unitOfWork.Reposirory<Clinic>().Delete(clinic);
                await _unitOfWork.CompleteAsync();

                return new ProcessResult
                {
                    IsSucceeded = true,
                    Message = "Clinic and associated Schedules deleted successfully"
                };
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while deleting clinic and appointment");
                return new ProcessResult
                {
                    IsSucceeded = false,
                    Message = "An error occurred while deleting clinic and appointment"
                };
            }
        }

        public async Task<IEnumerable<DoctorClinicDetailsDto>> GetAllClinicsAsync()
        {
            var clinicsWithSchedules = await _unitOfWork.Include<Clinic>
                                                        (c => c.Schedules)
                                                        .Include(c => c.PatientRates)
                                                        .ToListAsync();

            /*foreach (var item in clinicsWithSchedules)
            {
                UpdateAverageRate(item);
            }*/
            var dtos = _mapper.Map<IEnumerable<DoctorClinicDetailsDto>>(clinicsWithSchedules);
            return dtos;
        }

        public async Task<DoctorClinicDetailsDto> GetClinicById(int id)
        {
            try
            {
                var clinic = await _unitOfWork.Include<Clinic>
                                   (id, c => c.Schedules, c => c.PatientRates) ??
                                   throw new ClinicNotFoundException($"Clinic with ID {id} not found.");

                //UpdateAverageRate(clinic);

                var dto = _mapper.Map<DoctorClinicDetailsDto>(clinic);
                return dto;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while fetching the clinic by ID: {ClinicId}", id);
                throw;
            }
        }


        public async Task<IEnumerable<DoctorClinicDetailsDto>> GetClinicByName(string subName)
        {
            if (string.IsNullOrEmpty(subName))
            {
                throw new ArgumentException("SubName can't be null or empty.");
            }

            try
            {
                var clinics = await _unitOfWork.Include<Clinic>(c => c.Schedules)
                                               .Include(c => c.PatientRates)
                                               .ToListAsync();

                if (clinics == null || !clinics.Any())
                {
                    throw new Exception("There is No Clinics Yet");
                }

                var result = clinics.Where(c => c.Name.StartsWith(subName, StringComparison.OrdinalIgnoreCase)).ToList();

                if (!result.Any())
                {
                    throw new Exception($"No Clinic Found With this subName : {subName}");
                }

                var dtos = _mapper.Map<List<DoctorClinicDetailsDto>>(result);
                return dtos;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while fetching the clinic by name: {ClinicName}", subName);
                throw;
            }
        }

        public async Task<ProcessResult> IsDoctorHasClinicAsync(string doctorId)
        {
            try
            {
                var doctor = await _userManager.FindByIdAsync(doctorId);
                if (doctor == null)
                {
                    return new ProcessResult
                    {
                        Message = "No Doctor found with this Id" + doctorId,
                    };
                }

                var doctorRoles = await _userManager.GetRolesAsync(doctor);
                var doctorRolesLower = doctorRoles.Select(role => role.ToLower()).ToList();
                if (!doctorRolesLower.Contains("doctor"))
                {
                    return new ProcessResult
                    {
                        Message = "This User is already Patient so he can't own a clinic"
                    };
                }

                if (!(bool)doctor.DoctorHasClinic)
                {
                    return new ProcessResult
                    {
                        Message = "This Doctor Doesn't own a clinic yet"
                    };
                }

                return new ProcessResult
                {
                    IsSucceeded = true,
                    Message = "This Doctor has already clinic"
                };
            }
            catch (Exception ex)
            {
                return new ProcessResult
                {
                    Message = "An error occurred while processing the request"
                };
            }
        }

        public async Task<ProcessResult> PatientRateClinicAsync(PatientRateDto dto)
        {
            var clinic = await _unitOfWork.Include<Clinic>
                                   (dto.ClinicId, c => c.Schedules, c => c.PatientRates) ??
                                   throw new ClinicNotFoundException($"Clinic with ID {dto.ClinicId} not found.");

            if (clinic == null)
            {
                return new ProcessResult
                {
                    Message = $"No Clinic Found With This Id: {dto.ClinicId}"
                };
            }

            bool isPatientInClinic = _unitOfWork.scheduleRepository.IsPatientInClinic(dto);
            var patient = await _userManager.FindByIdAsync(dto.PatientId);

            var isPatientRateSameClinicBefore =  await _unitOfWork.clinicRepository
                    .IsPatientRateSameClinicBefore(dto.ClinicId, dto.PatientId);

            if (isPatientInClinic)
            {
                return new ProcessResult
                {
                    Message = "This Patient has rated this clinic before"
                };
            }


            if (!isPatientInClinic)
            {
                return new ProcessResult
                {
                    Message = "This Patient is not in clinic"
                };
            }

           
            var patientRateClinic = _mapper.Map<PatientRateClinic>(dto);
            // clinic.PatientRates.Add(patientRateClinic);

            await _unitOfWork.Reposirory<PatientRateClinic>().AddAsync(patientRateClinic);
            await _unitOfWork.CompleteAsync();

            UpdateAverageRate(clinic , dto.Rate);

            return new ProcessResult
            {
                IsSucceeded = true,
                Message = "Patient rated successfully"
            };
        }

        public async Task<ProcessResult> UpdateClinicAsync(DoctorClinicUpdateDto clinicDto)
        {
            try
            {
                var oldClinic = await _unitOfWork.Reposirory<Clinic>().GetByIdAsync(clinicDto.Id);

                if (oldClinic == null)
                {
                    return new ProcessResult { Message = $"No Clinic With ID : {clinicDto.Id}" };
                }

                _mapper.Map(clinicDto, oldClinic);
                _unitOfWork.Reposirory<Clinic>().Update(oldClinic);
                await _unitOfWork.CompleteAsync();

                return new ProcessResult
                {
                    IsSucceeded = true,
                    Message = $"Clinic with Id: {oldClinic.Id} updated successfully"
                };
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while updating the Clinic");
                return new ProcessResult
                {
                    Message = "An error occurred while updating the clinic"
                };
            }
        }

        private async Task UpdateAverageRate(Clinic clinic , double rate)
        {
            double totalRate = 0;
            int numberOfRatings = clinic.PatientRates.Count;

            var checkClinic = await _unitOfWork.Reposirory<Clinic>().GetByIdAsync(clinic.Id);

            var newAverage = _unitOfWork.clinicRepository.GetClinicAverageRate(clinic.Id);

            checkClinic.Rate = newAverage;
               
            /*foreach (var patientRate in clinic.PatientRates)
            {
                totalRate += patientRate.Rate;
            }
*/
        /*    totalRate += rate;
            // Calculate the average rate only if there are ratings
            clinic.Rate = numberOfRatings > 0 ? Math.Floor(totalRate / numberOfRatings) : 0;*/

            // Update the clinic entity to reflect the new average rate
            _unitOfWork.Reposirory<Clinic>().Update(clinic);
            await _unitOfWork.CompleteAsync();
        }
    }
}
