using AutoMapper;
using Humanizer;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Build.Framework;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.DoctorDtos;
using SkinCancer.Repositories.Interface;
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

                // Now set the ClinicId for the Appointment
                var appointment = _mapper.Map<Appointment>(dto);
                appointment.ClinicId = clinic.Id;

                // Add the appointment entity to the context
                await _unitOfWork.Reposirory<Appointment>().AddAsync(appointment);

                // Save changes to the database
                await _unitOfWork.CompleteAsync();

                return new ProcessResult
                {
                    IsSucceeded = true,
                    Message = "Clinic and Appointment Created Successfully"
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

                var appointment = await _unitOfWork.Reposirory<Appointment>()
                    .FirstOrDefaultAsync(a => a.ClinicId == id);

                if (appointment != null)
                {
                    _unitOfWork.Reposirory<Appointment>().Delete(appointment);

                }

                await _unitOfWork.CompleteAsync();

                return new ProcessResult
                {
                    IsSucceeded = true,
                    Message = "Clinic and associated appointment deleted successfully"
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
        public async Task<IEnumerable<DoctorClinicDto>> GetAllClinicsAsync()
        {
            var clinicsWithAppointments = await _unitOfWork.Include<Clinic>
                                                    (c => c.Appointment)
                                                   .ToListAsync();

            var dtos = _mapper.Map<IEnumerable<DoctorClinicDto>>(clinicsWithAppointments);

            return dtos;
        }

        // Done
        public async Task<ActionResult<DoctorClinicDto>> GetClinicById(int id)
        {
            try
            {
                var clinic = await _unitOfWork.Include<Clinic>(id, c => c.Appointment);

                if (clinic == null)
                {
                    // Clinic not found, return 404 Not Found
                    return new NotFoundObjectResult($"Clinic with ID {id} not found.");
                }

                var dto = _mapper.Map<DoctorClinicDto>(clinic);

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
        public async Task<ActionResult<DoctorClinicDto>> GetClinicByName(string name)
        {
            try
            {
                var clinic = await _clinicRepository.Include<Clinic>
                    (name, c => c.Appointment);

                if (clinic == null)
                {
                    return new NotFoundObjectResult($"Clinic with name `{name}` not found.");
                }
                var dto = _mapper.Map<DoctorClinicDto>(clinic);

                return dto;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while fetching the clinic by name: {ClinicName}"
                    , name);

                return new ObjectResult("An error occurred while processing your request. Please try again later.")
                {
                    StatusCode = 500
                };
            }
        }


        public async Task<ProcessResult> UpdateClinicAsync(DoctorClinicDto clinicDto)
        {
            try
            {
                var oldClinic = await _unitOfWork.Include<Clinic>(clinicDto.Id, c => c.Appointment);

                if (oldClinic == null)
                {
                    return new ProcessResult { Message = $"No Clinic With ID : {clinicDto.Id}" };
                }

                // Map properties from clinicDto to oldClinic
                _mapper.Map(clinicDto, oldClinic);

                // If the oldClinic has an associated Appointment, update its properties
                if (oldClinic.Appointment != null)
                {
                    _mapper.Map(oldClinic.Appointment, clinicDto);   
                }

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
    }

}


