using AutoMapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.ScheduleDtos;
using SkinCancer.Repositories.Interface;
using SkinCancer.Repositories.Repository;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Services.ScheduleServices
{
    public class ScheduleService : IScheduleService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly ILogger<ScheduleService> _logger;
        private readonly UserManager<ApplicationUser> _userManager;


        public ScheduleService(IUnitOfWork unitOfWork, IMapper mapper,
                               ILogger<ScheduleService> logger,
                               UserManager<ApplicationUser> userManager)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
            _userManager = userManager;
        }

        public async Task<ProcessResult> CreateSchedule(ScheduleDto dto)
        {  
            try
            {
                var clinic = await _unitOfWork.Reposirory<Clinic>()
                    .GetByIdAsync(dto.ClinicId);

                if (clinic == null)
                {

                    _logger.LogWarning("No clinic found with ID: {ClinicId}", dto.ClinicId);
                    return new ProcessResult
                    {
                        Message = "No Clinic Found With this Id"
                    };
                }
                if (dto.Date <= DateTime.Now)
                {
                    _logger.LogWarning("Invalid date for schedule creation: {Date}", dto.Date);
                    return new ProcessResult
                    {
                        Message = "Date Should Be in the future"
                    };
                }
                var schedule = _mapper.Map<Schedule>(dto);

                await _unitOfWork.Reposirory<Schedule>().AddAsync(schedule);
                await _unitOfWork.CompleteAsync();

                return new ProcessResult
                {
                    IsSucceeded = true,
                    Message = "Schedule created successfully"
                };
            }   
            catch (Exception ex)
            {
                return new ProcessResult
                {
                    Message =
                        $"An error occurred while creating schedule {ex.Message}" 
                };
            }
        }

        public async Task<ProcessResult> UpdateSchedule(UpdateScheduleDto dto)
        {
            try
            {
                var schedule = await _unitOfWork.Reposirory<Schedule>()
                    .GetByIdAsync(dto.Id);

                if (schedule == null)
                {
                    return new ProcessResult
                    {
                        Message = "No schedule With this id"
                    };
                }

                
                if (dto.Date <= DateTime.Now)
                {
                    return new ProcessResult
                    {
                        Message = "Date Should Be in the future"
                    };
                }
                _mapper.Map(dto, schedule);

                _unitOfWork.Reposirory<Schedule>().Update(schedule);
                await _unitOfWork.CompleteAsync();

                return new ProcessResult
                {
                    IsSucceeded = true,
                    Message = "Schedule Updated Successfully"
                };
            }
            catch (Exception ex)
            {
                return new ProcessResult
                {
                    Message =
                        $"Something went wrong while updating schedule: {ex.Message}"
                };
            }

        }


        public async Task<ProcessResult> BookScheduleAsync(BookScheduleDto dto)
        {
            try
            {
                var schedule = await _unitOfWork.Reposirory<Schedule>().GetByIdAsync(dto.ScheduleId);
                if (schedule == null)
                {

                    return new ProcessResult
                    {
                        Message = "No such schedule !",
                        IsSucceeded = false
                    };
                }
                schedule.PatientId = dto.PatientId;
                schedule.IsBooked = true;

                await _unitOfWork.CompleteAsync();
                return new ProcessResult
                {
                    IsSucceeded = true,
                    Message = "Patient Booked Successfully "
                };
            }
            catch(Exception ex)
            {
                return new ProcessResult { Message = $"An error occurred while booking schedule: {ex.Message}" };
            }

        }

        public async Task<IEnumerable<ScheduleDetailsDto>> GetSchedulesByClinicIdAsync(int clinicId)
        {
            try
            {
                var schedules = await _unitOfWork.scheduleRepository.GetClinicSchedulesById(clinicId);

                if (schedules == null || !schedules.Any())
                {
                    _logger.LogWarning("No schedules found for clinic with ID: {ClinicId}", clinicId);
                    return Enumerable.Empty<ScheduleDetailsDto>(); // Return an empty list
                }

                var schedulesDtos = _mapper.Map<IEnumerable<ScheduleDetailsDto>>(schedules);

                return schedulesDtos;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while fetching schedules for clinic with ID: {ClinicId}", clinicId);
                throw;
            }
        }

        public async Task<IEnumerable<PatientScheduleDetailsDto>> GetClinicBookedSchedules(int clinicId)
        {
            try
            {
                var schedules = _unitOfWork.SelectItem<Schedule>
                    (s => s.ClinicId == clinicId && s.IsBooked, s => s.Clinic,
                     s => s.Patient);

                if (schedules == null || !schedules.Any())
                {
                    return Enumerable.Empty<PatientScheduleDetailsDto>();
                }

                var dtos = _mapper.Map<IEnumerable<PatientScheduleDetailsDto>>(schedules).ToList();


                
                return dtos;
            }
            catch (Exception ex)
            {
                return Enumerable.Empty<PatientScheduleDetailsDto>();
            }

        }

        public async Task<IEnumerable<PatientScheduleDetailsDto>> GetPatientSchedules(string patientId)
        {

            try
            {
                var schedules =  _unitOfWork.SelectItem<Schedule>(
                 x => x.PatientId == patientId,
                 x => x.Clinic,
                 x => x.Patient);


                /* var patientSchedules = _unitOfWork.SelectItem<Schedule>
                                                         (x => x.PatientId == patientId,
                                                         x => x.Clinic,
                                                         x => x.Patient)
                                                         .Select(x => new
                                                         {
                                                             Id = x.Id,
                                                             Name = x.Patient.UserName,
                                                             Date = x.Date,
                                                             ClinicName = x.Clinic.Name,
                                                             PatientId = x.PatientId,
                                                         });*/

                if (schedules == null || !schedules.Any())
                {
                    return Enumerable.Empty<PatientScheduleDetailsDto>();
                }

                var patientSchedules = schedules.Select(s => new
                {
                    Id = s.Id,
                    PatientName = s.Patient.FirstName + " " + s.Patient.LastName,
                    Date = s.Date,
                    ClinicName = s.Clinic.Name,
                    PatientId = s.PatientId,
                });

                var result = new List<PatientScheduleDetailsDto>();

                foreach (var item in patientSchedules)
                {
                    var dto = new PatientScheduleDetailsDto
                    {
                        PatientId = item.PatientId,
                        PatientName = item.PatientName,
                        ClinicName = item.ClinicName,
                        Date = item.Date,
                        ScheduleId = item.Id
                    };
                    result.Add(dto);
                }


                return result;
            }
            catch (Exception ex)
            {
                return Enumerable.Empty<PatientScheduleDetailsDto>();
            }
        }
    }
}
