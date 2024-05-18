using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using SkinCancer.Entities.Models;
using System.Reflection.Emit;

namespace SkinCancer.Entities
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
            
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);



        }

        public DbSet<Schedule> Schedules { get; set; }
        public DbSet<Clinic> Clinics { get; set; }
        public DbSet<DetectionData> DetectionsData { get; set; }
       /* public DbSet<Appointment> Appointments { get; set; }*/
    }
}
