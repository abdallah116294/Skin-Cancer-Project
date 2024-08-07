﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SkinCancer.Entities;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.ScheduleDtos;
using SkinCancer.Repositories.Interface;
using SkinCancer.Repositories.Repository;
using SkinCancer.Services.ScheduleServices;

namespace SkinCancer.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ScheduleController : ControllerBase
    {
        public readonly IScheduleService _scheduleService;
        private readonly IUnitOfWork  unitOfWork;
		private readonly ApplicationDbContext _context;

        public ScheduleController(IScheduleService scheduleService, ApplicationDbContext context, IUnitOfWork unitOfWork)
        {
            _scheduleService = scheduleService;
            _context = context;
            this.unitOfWork = unitOfWork;
        }


        [HttpPost("DoctorCreateSchedule")]
        public async Task<ActionResult> CreateScheduleAsync(ScheduleDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);  
            }

            return Ok(await _scheduleService.CreateSchedule(dto));
        }


        [HttpPost("PatientBookSchedule")]
        public async Task<ActionResult<ProcessResult>> BookScheduleAsync
            (BookScheduleDto dto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var result = await _scheduleService.BookScheduleAsync(dto);

            if (!result.IsSucceeded)
            {
                return BadRequest(result);
            }
            return Ok(result);
        }


        [HttpPut("UpdateSchedule")]
        public async Task<ActionResult> UpdateScheduleAsync(UpdateScheduleDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var result = await _scheduleService.UpdateSchedule(dto);

            if (!result.IsSucceeded)
            {
                return BadRequest(ModelState);
            }

            return Ok(dto);
        }

        [HttpGet("GetClinicSchedules")]
        public async Task<ActionResult<IEnumerable<ScheduleDetailsDto>>> GetClinicSchedulesByClinicIdAsync(int clinicId)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var schedulesResult = await _scheduleService.GetSchedulesByClinicIdAsync(clinicId);

            if (schedulesResult == null)
            {
                return NotFound($"No schedules found for clinic ID {clinicId}.");
            }
                
            return Ok(schedulesResult);
        }


        [HttpGet("GetPatientSchedules")]
        public async Task<ActionResult> GetPatientSchedulesAsync(string patientId)
        {

            if (string.IsNullOrWhiteSpace(patientId))
            {
                return BadRequest(new { Message = "Patient ID cannot be null or empty." });
            }
            try
            {
                var patientSchedules = await _scheduleService.GetPatientSchedules(patientId);

                if (patientSchedules == null || !patientSchedules.Any())
                {
                    return NotFound(new { Message = "No schedules found for the specified patient." });
                }

                return Ok(patientSchedules);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Message = "An error occurred while fetching patient schedules." + ex.Message });
            }
        }



        [HttpGet("GetClinicBookedSchedules")]
        public async Task<ActionResult> GetClinicBookedSchedules(int clinicId)
        {
            try
            {
                var clinicSchedules = await _scheduleService
                    .GetClinicBookedSchedules(clinicId);

                if (clinicSchedules == null || !clinicSchedules.Any())
                {
                    return NotFound(new { Message = "No schedules found for the specified patient." });
                }

                return Ok(clinicSchedules);
            }
            catch
            {
                return StatusCode(500, "An error occurred while fetching clinic appointments");
            }
        }	
	}
}
