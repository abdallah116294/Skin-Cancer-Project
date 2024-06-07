using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SkinCancer.Api.Extentions;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.PatientDtos;
using SkinCancer.Repositories.Interface;

namespace SkinCancer.Api.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class DetectionController : ControllerBase
	{
		private readonly IWebHostEnvironment _webHostEnvironment;
		private readonly IUnitOfWork _unitOfWork;


		public DetectionController(IWebHostEnvironment webHostEnvironment,IUnitOfWork unitOfWork)
		{
			_webHostEnvironment = webHostEnvironment;
			_unitOfWork = unitOfWork;
		}

		[HttpPost]
		public async Task<IActionResult> Upload([FromForm]PostDetectionData dto)
		{
			if (!ModelState.IsValid) {
			return BadRequest(dto);
			}

			try
			{
				var fileExtension = Path.GetExtension(dto.Image.FileName).ToLowerInvariant();
				if (string.IsNullOrEmpty(fileExtension) || !FileUploadHelper.PermittedExtensions.Contains(fileExtension))
				{
					return BadRequest("Invalid file extension");
				}
				var filePath = await FileUploadHelper.UploadFileAsync(dto.Image, _webHostEnvironment.WebRootPath);
				var detectionData = new DetectionData
				{
					ImagePath = filePath,
					Result = dto.Result,
					Date = DateTime.UtcNow,
					UserId = dto.UserId,
					Diagnosis=""
				};
				 await _unitOfWork.detectionRepositoty.AddAsync(detectionData);
				await _unitOfWork.CompleteAsync();
				return Ok(new { Message="Data Saved Successffly"});
			}
			catch (Exception ex)
			{
				return BadRequest(ex);
			}
		}

		[HttpGet]
		public async Task<IActionResult> GetDetectionsData(string userID) {
			var url = Request.Scheme + "://" + Request.Host + Request.PathBase;
			var data = await _unitOfWork.detectionRepositoty.Get(userID, url);
			return Ok(data);


		}

		[HttpPost("AddDiagnosis")]
		public async Task<IActionResult> AddDiagnosis(int Id, string Diagonosis) {
			var detectionData = _unitOfWork.SelectItem<DetectionData>(x => x.Id == Id).FirstOrDefault();
			if (detectionData == null)
			{
				return BadRequest($"this Id {Id} Not Found");
			}
			try
			{
				detectionData.Diagnosis = Diagonosis;
				_unitOfWork.detectionRepositoty.Update(detectionData);
				await _unitOfWork.CompleteAsync();
				return Ok("added success");
			}
			catch (Exception ex)
			{

				return BadRequest(ex);
			}
			
		}
	}
}
