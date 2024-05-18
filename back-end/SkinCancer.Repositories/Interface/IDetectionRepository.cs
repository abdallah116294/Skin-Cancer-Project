using SkinCancer.Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Repositories.Interface
{
	public interface IDetectionRepository:IGenericRepository<DetectionData>
	{
		Task<ICollection<DetectionData>> Get(string userId, string baseUrl);
	}
}
