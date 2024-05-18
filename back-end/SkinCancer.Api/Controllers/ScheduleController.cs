﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.ScheduleDtos;
using SkinCancer.Services.ScheduleServices;

namespace SkinCancer.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ScheduleController : ControllerBase
    {
        public readonly IScheduleService _scheduleService;

        public ScheduleController(IScheduleService scheduleService)
        {
            _scheduleService = scheduleService;
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


        [HttpPut]
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
        public async Task<ActionResult<IEnumerable<ScheduleDetailsDto>>>
            GetClinicSchedulesByClinicIdAsync(int clincId)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            
            var schedules = await _scheduleService.GetSchedulesByClinicIdAsync(clincId);

            return schedules.ToList();

        }
    }
}
