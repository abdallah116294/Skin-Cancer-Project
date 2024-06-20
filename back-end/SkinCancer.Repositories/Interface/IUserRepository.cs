using SkinCancer.Entities.AuthModels;
using SkinCancer.Entities.Models;
using SkinCancer.Entities.ModelsDtos.AuthenticationUserDtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Repositories.Interface
{
    public interface IUserRepository
    {
        Task<IEnumerable<ApplicationUser>> GetAllUsersRepository();

        Task<ApplicationUser> GetUserByIdRepository(string id);

        Task<ProcessResult> DeleteUserRepository(string id);

        Task<ApplicationUser> CreateNewUserRepository(RegisterModel user);

        Task<ApplicationUser> UpdateUserRepository(string id , RegisterModel user);
    }
}
