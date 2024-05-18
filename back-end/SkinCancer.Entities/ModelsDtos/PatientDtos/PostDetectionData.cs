using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Entities.ModelsDtos.PatientDtos
{
	public class PostDetectionData
	{
		[Required(ErrorMessage="User Id Is Required")]
		public string UserId { get; set; }
		[Required(ErrorMessage ="Result Id Is Required")]
		public string Result { get; set; }
		[Required(ErrorMessage ="Image Id Is Required")]
		public IFormFile Image { get; set; }


	}
}
