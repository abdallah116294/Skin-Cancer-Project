using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.Models
{
	public class DetectionData:BaseEntity
	{
		public string ImagePath { get; set; }	
		public string Result { get; set; }	
		public DateTime Date { get; set; }
		[ForeignKey("User")]
		public string UserId { get; set; }	

		public ApplicationUser User { get; set; }

	}
}
