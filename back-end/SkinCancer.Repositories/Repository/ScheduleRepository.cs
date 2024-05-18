using Microsoft.EntityFrameworkCore;
using SkinCancer.Entities;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.PatientDtos;
using SkinCancer.Entities.ModelsDtos.ScheduleDtos;
using SkinCancer.Repositories.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Repositories.Repository
{
    public class ScheduleRepository : IScheduleRepository
    {
        public readonly ApplicationDbContext _context;

        public ScheduleRepository(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Schedule>> GetClinicSchedulesById(int clinicId)
        => await _context.Schedules.Where(s=>s.ClinicId == clinicId).ToListAsync();

        public  bool IsPatientInClinic(PatientRateDto dto)
           =>  _context.Schedules.Any(s => s.ClinicId == dto.ClinicId && s.PatientId == dto.PatientId);
    }
}
