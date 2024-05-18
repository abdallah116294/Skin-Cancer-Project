using AutoMapper;
using AutoMapper.Execution;
using SkinCancer.Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.DoctorClinicDtos
{
    public class DoctorClinicScheduleResolver : IValueResolver<Clinic, DoctorClinicDetailsDto, List<DateTime>>
    {
        public List<DateTime> Resolve(Clinic source, DoctorClinicDetailsDto destination, List<DateTime> destMember, ResolutionContext context)
        {
            var result = new List<DateTime>();
            foreach(var item in source.Schedules)
            {
                result.Add(item.Date);
            }

            return result;
        }
    }
}
