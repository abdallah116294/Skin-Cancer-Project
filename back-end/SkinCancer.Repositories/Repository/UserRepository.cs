// Ignore Spelling: Dto

using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;
using SkinCancer.Entities;
using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.AuthenticationUserDtos;
using SkinCancer.Repositories.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SkinCancer.Repositories.Repository
{
    public class UserRepository : IUserRepository
    {
        private readonly ApplicationDbContext _context;
        private readonly IMapper _mapper;
        private readonly UserManager<ApplicationUser> _userManager;

        public UserRepository(ApplicationDbContext context, IMapper mapper, UserManager<ApplicationUser> userManager)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
            _userManager = userManager ?? throw new ArgumentNullException(nameof(userManager));
        }

        public async Task<ApplicationUser> CreateNewUserRepository(RegisterModel userDto)
        {
            var appUser = _mapper.Map<ApplicationUser>(userDto);
            var result = await _userManager.CreateAsync(appUser, userDto.Password);

            if (!result.Succeeded)
            {
                throw new ApplicationException("Failed to create user.");
            }

            return appUser;
        }

        public async Task<ProcessResult> DeleteUserRepository(string id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return new ProcessResult { Message = "No User Found With this Id", IsSucceeded = false };
            }

            _context.Users.Remove(user);
            await _context.SaveChangesAsync();
            return new ProcessResult { Message = "User deleted successfully", IsSucceeded = true };
        }

        public async Task<IEnumerable<ApplicationUser>> GetAllUsersRepository()
        {
            return await _context.Users.ToListAsync();
        }

        public async Task<ApplicationUser> GetUserByIdRepository(string id)
        {
            return await _context.Users.FindAsync(id);
        }

        public async Task<ApplicationUser> UpdateUserRepository(string id, RegisterModel user)
        {
            var appUser = await _context.Users.FindAsync(id);
            if (appUser == null)
            {
                throw new KeyNotFoundException($"User with ID {id} not found.");
            }

            appUser.FirstName = user.FirstName;
            appUser.LastName = user.LastName;
            appUser.Email = user.Email;
            appUser.PhoneNumber = user.PhoneNumber;
            appUser.UserName = user.UserName;

            // Only update the password if it's provided
            if (!string.IsNullOrWhiteSpace(user.Password))
            {
                var hashedPassword = _userManager.PasswordHasher.HashPassword(appUser, user.Password);
                appUser.PasswordHash = hashedPassword;
            }

            _context.Users.Update(appUser);
            await _context.SaveChangesAsync();
            return appUser;
        }
    }
}

