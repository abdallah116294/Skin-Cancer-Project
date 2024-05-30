using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SkinCancer.Entities;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.DoctorDtos;
using SkinCancer.Repositories.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Repositories.Repository
{
    public class ClinicRepository : IClinicRepository
    {
        private readonly ApplicationDbContext _context;
        public ClinicRepository(ApplicationDbContext context) 
        {
            _context = context;
        }

        public int GetClinicAverageRate(int clinicId)
        {
            var average = (int) _context.PatientRateClinics.Where(c => c.ClinicId == clinicId).Average(c => c.Rate);

            return average;
        }

        public async Task<Clinic> GetClinicByNameAsync(string name)
            => await _context.Clinics.FirstOrDefaultAsync(c => c.Name == name);


        public async Task<TEntity> Include<TEntity>(string name, 
            params Expression<Func<TEntity, object>>[] includes) where TEntity : Clinic
        {
            var query = _context.Set<TEntity>().AsQueryable();

            foreach (var include in includes)
            {
                query = query.Include(include);
            }

            return await query.FirstOrDefaultAsync(e => e.Name == name);
        }

        public async Task<bool> IsPatientRateSameClinicBefore(int clinicId, string patientId)
        {
            return await _context.PatientRateClinics.AnyAsync(r => r.ClinicId == clinicId && 
                                                              r.PatientId == patientId);
        }
    }
}
