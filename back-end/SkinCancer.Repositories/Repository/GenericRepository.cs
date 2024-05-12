using Microsoft.EntityFrameworkCore;
using SkinCancer.Entities;
using SkinCancer.Entities.Models;
using SkinCancer.Repositories.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Repositories.Repository
{
    public class GenericRepository<TEntity> :
        IGenericRepository<TEntity> where TEntity : BaseEntity
    {
        private readonly ApplicationDbContext context;

        public GenericRepository(ApplicationDbContext context)
        {
            this.context = context;
        }

        public async Task AddAsync(TEntity entity)
            => await context.Set<TEntity>().AddAsync(entity);


        public void Delete(TEntity entity)
            => context.Set<TEntity>().Remove(entity);

        public async Task<TEntity> FirstOrDefaultAsync(Expression<Func<TEntity, bool>> predicate)
        {
            return await context.Set<TEntity>().FirstOrDefaultAsync(predicate);    
        }

        public async Task<IReadOnlyList<TEntity>> GetAllAsync()
            => await context.Set<TEntity>().ToListAsync();


        public async Task<TEntity> GetByIdAsync(int Id)
            => await context.Set<TEntity>().FindAsync(Id);

        public void Update(TEntity entity)
            => context.Set<TEntity>().Update(entity);
    }
}