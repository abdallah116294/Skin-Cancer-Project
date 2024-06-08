using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.PatientDtos;
using SkinCancer.Entities.ModelsDtos.ScheduleDtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Repositories.Interface
{
    public interface IScheduleRepository
    {
        Task<IEnumerable<Schedule>> GetClinicSchedulesById(int clinicId);

        bool IsPatientInClinic(PatientRateDto dto);

        Task<int?> GetClinicId(int scheduleId);


    }
}
