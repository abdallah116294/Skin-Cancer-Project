namespace SkinCancer.Api.Extentions
{
	public static class FileUploadHelper
	{
		public static readonly string[] PermittedExtensions = { ".jpg", ".jpeg", ".png", ".gif", ".bmp" };

		public static async Task<string> UploadFileAsync(IFormFile file, string webRootPath)
		{

			var fileExtension = Path.GetExtension(file.FileName).ToLowerInvariant();

			var uniqueFileName = $"{Guid.NewGuid()}{fileExtension}";
			var detectionsFolderPath = Path.Combine(webRootPath, "detections");

			if (!Directory.Exists(detectionsFolderPath))
			{
				Directory.CreateDirectory(detectionsFolderPath);
			}

			var filePath = Path.Combine(detectionsFolderPath, uniqueFileName);

			using (var fileStream = new FileStream(filePath, FileMode.Create))
			{
				await file.CopyToAsync(fileStream);
			}

			return $"/detections/{uniqueFileName}";
		}
	}
}
