using AutoMapper;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.ScheduleDtos;
using SkinCancer.Repositories.Interface;
using System;
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

        public ScheduleService(IUnitOfWork unitOfWork, IMapper mapper = null)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }

        public async Task<ProcessResult> CreateSchedule(ScheduleDto dto)
        {  
            try
            {
                var clinic = await _unitOfWork.Reposirory<Clinic>()
                    .GetByIdAsync(dto.ClinicId);
                
                if (clinic == null)
                {
                    return new ProcessResult
                    {
                        Message = "No Clinic Found With this Id"
                    };
                }
                if (dto.Date <= DateTime.Now)
                {
                    return new ProcessResult
                    {
                        Message = "Date Should Be in the future"
                    };
                }
                var schedule = _mapper.Map<Schedule>(dto);

                // Set the clinic for the schedule
               // schedule.Clinic = clinic;

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

        public async Task<IEnumerable<ScheduleDetailsDto>> GetSchedulesByClinicIdAsync(int clinicId)
        {
            var schedules = await _unitOfWork.scheduleRepository.GetClinicSchedulesById(clinicId);

            var schedulesDtos = _mapper.Map<IEnumerable<ScheduleDetailsDto>>(schedules);

            return schedulesDtos;
                
        }
    }
}
