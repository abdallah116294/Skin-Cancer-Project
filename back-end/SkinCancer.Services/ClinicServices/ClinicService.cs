using AutoMapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.DoctorClinicDtos;
using SkinCancer.Entities.ModelsDtos.DoctorDtos;
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
        private readonly IClinicRepository _clinicRepository;

        public ClinicService(IUnitOfWork unitOfWork, IMapper mapper,
                             RoleManager<IdentityRole> roleManager,
                             UserManager<ApplicationUser> userManager,
                             IClinicRepository clinicRepository,
                             ILogger<ClinicService> logger)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _roleManager = roleManager;
            _userManager = userManager;
            _clinicRepository = clinicRepository;
            _logger = logger;
        }

        public async Task<ProcessResult> CreateClinicAsync(CreateClinicDto dto)
        {
            try
            {
                var clinic = _mapper.Map<Clinic>(dto);
                await _unitOfWork.Reposirory<Clinic>().AddAsync(clinic);
                await _unitOfWork.CompleteAsync();

                CalculateAverageRate(clinic);
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
            var clinicsWithSchedules = await _unitOfWork.Include<Clinic>(c => c.Schedules).ToListAsync();
            var dtos = _mapper.Map<IEnumerable<DoctorClinicDetailsDto>>(clinicsWithSchedules);
            return dtos;
        }

        public async Task<DoctorClinicDetailsDto> GetClinicById(int id)
        {
            try
            {
                var clinic = await _unitOfWork.Include<Clinic>(id, c => c.Schedules);
                if (clinic == null)
                {
                    throw new Exception($"Clinic with ID {id} not found.");
                }

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

        public async Task<ProcessResult> PatientRateClinicAsync(PatientRateDto dto)
        {
            var clinic = await _unitOfWork.Reposirory<Clinic>().GetByIdAsync(dto.ClinicId);
            if (clinic == null)
            {
                return new ProcessResult
                {
                    Message = $"No Clinic Found With This Id: {dto.ClinicId}"
                };
            }

            bool isPatientInClinic = _unitOfWork.scheduleRepository.IsPatientInClinic(dto);

            if (!isPatientInClinic)
            {
                return new ProcessResult
                {
                    Message = "This Patient is not in clinic"
                };
            }

            var patientRateClinic = _mapper.Map<PatientRateClinic>(dto);
            clinic.PatientRates.Add(patientRateClinic);

            await _unitOfWork.Reposirory<PatientRateClinic>().AddAsync(patientRateClinic);
            await _unitOfWork.CompleteAsync();

            CalculateAverageRate(clinic);
            await _unitOfWork.CompleteAsync();

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
                    Message = "An error occured while updating the clinic"
                };
            }
        }
        private void CalculateAverageRate(Clinic clinic)
        {
            clinic.Rate = clinic.PatientRates?.Count > 0 ?
                clinic.PatientRates.Average(r => r.Rate) : 0;
        }
    }
}
