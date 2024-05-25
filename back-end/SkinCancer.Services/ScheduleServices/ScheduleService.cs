using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.ScheduleDtos;
using SkinCancer.Repositories.Interface;
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
        public readonly IUnitOfWork _unitOfWork;
        public readonly IMapper _mapper;
        private readonly ILogger<ScheduleService> _logger;


        public ScheduleService(IUnitOfWork unitOfWork, IMapper mapper, ILogger<ScheduleService> logger)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
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

        public async Task<IEnumerable<ScheduleDetailsDto>> GetClinicBookedSchedules(int clinicId)
        {
            try
            {
                var schedules = _unitOfWork.SelectItem<Schedule>
                    (s => s.ClinicId == clinicId && s.IsBooked, s => s.Clinic);

                if (schedules == null || !schedules.Any())
                {
                    return Enumerable.Empty<ScheduleDetailsDto>();
                }

                var dtos = _mapper.Map<IEnumerable<ScheduleDetailsDto>>(schedules);

                return dtos;
            }
            catch (Exception ex)
            {
                return Enumerable.Empty<ScheduleDetailsDto>();
            }

        }
    }
}
