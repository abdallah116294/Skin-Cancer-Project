using Microsoft.AspNetCore.Http;
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

		public ScheduleController(IScheduleService scheduleService, ApplicationDbContext context)
        {
            _scheduleService = scheduleService;
            _context = context;
            unitOfWork=new UnitOfWork(_context);
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
        [HttpGet("GetPatientAppointments")]
        public IActionResult GetPatientAppointments(string userId) {
        /*var patientSchedules = unitOfWork.SelectItem<Schedule>(x => x.PatientId == userId,
													x => x.Clinic,
													x => x.Patient).Select(x=>
                                                    new {
                                                    Id=x.Id,
                                                    Name=x.Patient.FirstName+" "+x.Patient.LastName,
                                                    Date=x.Date,
                                                    ClinicName=x.Clinic.Name,
                                                    userId=x.PatientId,
                                                    });*/
            return Ok();
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
                    return Ok(new ProcessResult { Message = "No booked schedules found for this clinic." });
                }

                return Ok(clinicSchedules);
            }
            catch
            {
                return StatusCode(500 , "An error occurred while fetching clinic appointments");
            }
		}

	}
}
