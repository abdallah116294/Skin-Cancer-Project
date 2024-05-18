using AutoMapper;
using Humanizer;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Build.Framework;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.DoctorClinicDtos;
using SkinCancer.Entities.ModelsDtos.DoctorDtos;
using SkinCancer.Entities.ModelsDtos.PatientDtos;
using SkinCancer.Repositories.Interface;
using SkinCancer.Repositories.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Services.ClinicServices
{
    public class ClinicService : IClinicService
    {

        public readonly IUnitOfWork _unitOfWork;
        public readonly ILogger<ClinicService> _logger;
        public readonly IMapper _mapper;
        public readonly RoleManager<IdentityRole> _roleManager;
        public readonly UserManager<ApplicationUser> _userManager;
        public readonly IClinicRepository _clinicRepository;

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

        // Done
        public async Task<ProcessResult> CreateClinicAsync(DoctorClinicDto dto)
        {
            try
            {
                // You can check for null and so on here...

                // Map DoctorClinicDto to Clinic entity
                var clinic = _mapper.Map<Clinic>(dto);

                // Add the clinic entity to the context
                await _unitOfWork.Reposirory<Clinic>().AddAsync(clinic);

                // Save changes to the database to obtain the Clinic's ID
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
                // Log and handle any exceptions
                _logger.LogError(ex, "An error occurred while creating clinic and appointment");
                return new ProcessResult
                {
                    IsSucceeded = false,
                    Message = "An error occurred while creating clinic and appointment"
                };
            }
        }

        // Done
        public async Task<ProcessResult> DeleteClinicAsync(int id)
        {
            try
            {
                var clinic = await _unitOfWork.Reposirory<Clinic>().GetByIdAsync(id);

                if (clinic == null)
                {
                    return new ProcessResult
                    {
                        Message = $"Clinic with ID '{id} not found."
                    };
                }

                _unitOfWork.Reposirory<Clinic>().Delete(clinic);

                /*  var appointment = await _unitOfWork.Reposirory<Schedule>()
                      .Where(a => a.Id == id);

                  if (appointment != null)
                  {
                      _unitOfWork.Reposirory<Schedule>().Delete(appointment);

                  }
  */
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

        // Done
        public async Task<IEnumerable<DoctorClinicDetailsDto>> GetAllClinicsAsync()
        {
            var clinicsWithAppointments = await _unitOfWork.Include<Clinic>
                                                    (c => c.Schedules)
                                                   .ToListAsync();

            var dtos = _mapper.Map<IEnumerable<DoctorClinicDetailsDto>>(clinicsWithAppointments);

            return dtos;
        }

        // Done
        public async Task<ActionResult<DoctorClinicDetailsDto>> GetClinicById(int id)
        {
            try
            {
                var clinic = await _unitOfWork.Include<Clinic>(id, c => c.Schedules);

                if (clinic == null)
                {
                    // Clinic not found, return 404 Not Found
                    return new NotFoundObjectResult($"Clinic with ID {id} not found.");
                }

                var dto = _mapper.Map<DoctorClinicDetailsDto>(clinic);

                return dto;
            }
            catch (Exception ex)
            {
                // Log the exception
                _logger.LogError(ex, "An error occurred while fetching the clinic by ID: {ClinicId}", id);

                // Return an internal server error response
                return new ObjectResult("An error occurred while processing your request. Please try again later.")
                {
                    StatusCode = 500
                };
            }
        }

        // Done

        public async Task<ActionResult<IEnumerable<DoctorClinicDetailsDto>>> GetClinicByName
            (string subName)
        {
            if (string.IsNullOrEmpty(subName))
            {
                return new BadRequestObjectResult("SubName can't be null or empty.");
            }
            try
            {
                var clinics = await _unitOfWork.Include<Clinic>
                                                        (c => c.Schedules)
                                                        .ToListAsync();

                if (clinics == null || !clinics.Any())
                {
                    return new NotFoundObjectResult($"There is No Clinics Yet");
                }

                var result = clinics
                    .Where(c => c.Name.StartsWith(subName, StringComparison.OrdinalIgnoreCase))
                    .ToList();

                if (!result.Any())
                {
                    return new NotFoundObjectResult($"No Clinic Found With this subName : {subName}");

                }

                var dtos = _mapper.Map<List<DoctorClinicDetailsDto>>(result);

                return new OkObjectResult(dtos);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while fetching the clinic by name: {ClinicName}"
                    , subName);

                return new ObjectResult("An error occurred while processing your request. Please try again later.")
                {
                    StatusCode = 500
                };
            }
        }

        public async Task<ProcessResult> PatientRateClinicAsync(PatientRateDto dto)
        {
            /* bool isPatientInClinic = _unitOfWork.scheduleRepository.IsPatientInClinic(dto);

             if (!isPatientInClinic)
             {
                 return new ProcessResult
                 {
                     Message = "This Patient is not in Clinic"
                 };
             }
             var patientRateClinic = _mapper.Map<PatientRateClinic>(dto);

             var clinic = await _unitOfWork.Reposirory<Clinic>().GetByIdAsync(patientRateClinic.ClinicId);

             // Calculate the Average Rate for a clinic
             clinic.Rate += (dto.Rate);

             clinic.Rate /= clinic.PatientRates.Count;*/

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

                // Map properties from clinicDto to oldClinic
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
                _logger.LogError(ex, "An error occurred while updating the clinic");

                return new ProcessResult()
                {
                    IsSucceeded = false,
                    Message = "An error occurred while updating the clinic"
                };
            }
        }


        // Average Rate
        private void CalculateAverageRate(Clinic clinic)
        {
            if (clinic.PatientRates != null && clinic.PatientRates.Count > 0)
            {
                clinic.Rate = clinic.PatientRates.Average(r => r.Rate);
            }
            else
            {
                clinic.Rate = 0;
            }
        }


    }

}


