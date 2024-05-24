using Microsoft.EntityFrameworkCore;
using SkinCancer.Entities;
using SkinCancer.Entities.Models;
using SkinCancer.Repositories.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Repositories.Repository
{
	public class DetectionRepository: GenericRepository<DetectionData>, IDetectionRepository
	{
        private readonly ApplicationDbContext _context;
        public DetectionRepository(ApplicationDbContext context):base(context)
        {
                _context = context;
        }

            

		public async Task<ICollection<DetectionData>> Get(string userId, string baseUrl)=>
            await _context.DetectionsData.Where(x => x.UserId == userId).Select(x=>new DetectionData{
            Result=x.Result,
            UserId=userId,
            ImagePath=baseUrl+x.ImagePath,
            Date=x.Date,
            Id=x.Id,    
            Diagnosis=x.Diagnosis,
            }).ToListAsync();
	}

}
