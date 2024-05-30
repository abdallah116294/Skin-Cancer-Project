using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.DoctorDtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Repositories.Interface
{
    public interface IClinicRepository
    {
        Task<Clinic> GetClinicByNameAsync(string name);

        Task<TEntity> Include<TEntity>(string name, 
                params Expression<Func<TEntity, object>>[] includes) where TEntity : Clinic;


        int GetClinicAverageRate(int clinicId);

        Task<bool> IsPatientRateSameClinicBefore (int clinicId , string patientId);

           
    }
}
