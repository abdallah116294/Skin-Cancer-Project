using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using SkinCancer.Entities.Models;
using SkinCancer.Services.AuthServices.Interfaces;
using SkinCancer.Services.AuthServices;
using Microsoft.OpenApi.Models;
using Microsoft.AspNetCore.Identity.UI.Services;
using SkinCancer.Entities;
using SkinCancer.Repositories.Interface;
using SkinCancer.Services.DoctorServices;
using SkinCancer.Repositories.Repository;
using SkinCancer.Services.ClinicServices;
using SkinCancer.Services.ScheduleServices;
using Stripe;

namespace SkinCancer.Api
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            //test
            builder.Services.AddDbContext<ApplicationDbContext>(o => o.UseSqlServer(
                  builder.Configuration.GetConnectionString("DefaultConnection")
                ));
            builder.Services.AddLogging(cfg =>
            {
                //auth
                cfg.AddDebug();
                cfg.AddConsole();
            });

            // Add Stripe Configurations for Payment
            StripeConfiguration.ApiKey = builder.Configuration["Stripe:SecretKey"];

            // Add CorsPolicy to Payment
            builder.Services.AddCors(options =>
            {
                options.AddDefaultPolicy(builder =>
                {
                    builder.AllowAnyOrigin();
                    builder.AllowAnyHeader();
                    builder.AllowAnyMethod();
                });
            });

            builder.Services.AddRouting(options => options.LowercaseUrls = true);

            builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();
            builder.Services.AddScoped<IDoctorService, DoctorService>();
            builder.Services.AddTransient<IClinicService, ClinicService>();
            builder.Services.AddScoped<IClinicRepository, ClinicRepository>();
            builder.Services.AddScoped<IScheduleService, ScheduleService>();

            builder.Services.AddScoped<IScheduleRepository, ScheduleRepository>();

            builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

            builder.Services.AddDataProtection();

            builder.Services.AddIdentity<ApplicationUser, IdentityRole>()
                .AddEntityFrameworkStores<ApplicationDbContext>()
                .AddDefaultTokenProviders();

            builder.Services.AddScoped<IAuthService, AuthService>();

            builder.Services.AddScoped<IEmailSender, EmailSender>();

            builder.Services.AddAuthentication(options =>
            {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            })
            .AddJwtBearer(o =>
            {
                o.RequireHttpsMetadata = false;
                o.SaveToken = false;
                o.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ValidIssuer = builder.Configuration["JWT:Issuer"],
                    ValidAudience = builder.Configuration["JWT:Audience"],
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["JWT:Key"]))
                };
            });

            // Add services to the container.
            builder.Services.AddControllers();

            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen(o =>
            {
                o.SwaggerDoc("v1", new OpenApiInfo()
                {
                    Version = "v1",
                    Title = "SkinCancer api",
                    Description = "Graduation Project",
                    Contact = new OpenApiContact()
                    {
                        Name = "Skin Cancer",
                        Email = "amargamal832909@gmail.com",
                        Url = new Uri("https://mydomain.com")
                    }
                });

                o.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme()
                {
                    Name = "Authorization",
                    Type = SecuritySchemeType.ApiKey,
                    Scheme = "Bearer",
                    BearerFormat = "JWT",
                    In = ParameterLocation.Header,
                    Description = "JWT Authorization header using the Bearer scheme. \r\n\r\n Enter 'Bearer' [space] and then your token in the text input below.\r\n\r\nExample: \"Bearer 12345abcdef\""
                });

                o.AddSecurityRequirement(new OpenApiSecurityRequirement()
                {
                    {
                       new OpenApiSecurityScheme()
                       {
                          Reference = new OpenApiReference()
                          {
                             Type = ReferenceType.SecurityScheme,
                             Id = "Bearer"
                          },
                          Name = "Bearer",
                          In = ParameterLocation.Header
                       },
                       new List<string>()
                    }
                });
            });

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            app.UseSwagger();
            app.UseSwaggerUI();

            app.UseHttpsRedirection();
            app.UseStaticFiles();

            // Required to allow CORS
            app.UseCors();

            app.UseRouting();

            // Add authentication and authorization middleware
            app.UseAuthentication();
            app.UseAuthorization();

            app.MapControllers();

            app.Run();
        }
    }
}
