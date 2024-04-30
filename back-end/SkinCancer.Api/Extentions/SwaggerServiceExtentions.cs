using Microsoft.OpenApi.Models;

namespace SkinCancer.Api
{
	public static class SwaggerServiceExtentions
	{
		public static IServiceCollection AddSwaggerDocumentation(this IServiceCollection services)
		{
			services.AddSwaggerGen(options =>
			{
				options.SwaggerDoc("v1", new OpenApiInfo
				{
					Title = "Skin Cancer",
					Version = "v1",
				});

				var securityScheme = new OpenApiSecurityScheme
				{
					Description = "Temp Description",
					Name = "Authorization",
					In = ParameterLocation.Header,
					Type = SecuritySchemeType.ApiKey,
					Scheme = "bearer",
					Reference = new OpenApiReference
					{
						Type = ReferenceType.SecurityScheme,
						Id = "bearer"
					}
				};
				options.AddSecurityDefinition("bearer",securityScheme);

				var securityRequirments = new OpenApiSecurityRequirement
				{
					{securityScheme,new []{"bearer"} }
				};

				options.AddSecurityRequirement(securityRequirments);
			});
			return services;
		}
	}
}
