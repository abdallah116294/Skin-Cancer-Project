﻿using Microsoft.AspNetCore.Mvc;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.ScheduleDtos;

namespace SkinCancer.Services.ScheduleServices
{
    public interface IScheduleService
    {
        Task<ActionResult<ProcessResult>> CreateSchedule(ScheduleDto dto);

        Task<ActionResult<ProcessResult>> UpdateSchedule(UpdateScheduleDto dto);

        Task<ActionResult<ProcessResult>> BookScheduleAsync(BookScheduleDto dto);

        Task<ActionResult<IEnumerable<ScheduleDetailsDto>>> GetSchedulesByClinicIdAsync(int clinicId);


    /*
         dayes---> data
    schdule

    id clinicId DateTile            isBooked
    1   1       10/10/2023 9am       true
    2   1       10/10/2023 10pm      false
    3   2       10/10/2023 10pm      true


   p => 1 2  3 4 
   1-> endpoing select * from schdule where clincId==cid

        Appointment
        asdasd  1
        ghdfsh  1   --->select apppintment where

         */
    }
}