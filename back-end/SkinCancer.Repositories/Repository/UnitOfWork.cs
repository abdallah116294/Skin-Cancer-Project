using SkinCancer.Entities.Models;
using SkinCancer.Repositories.Interface;
using SkinCancer.Repositories.Repository;
using SkinCancer.Entities;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;

namespace SkinCancer.Repositories.Repository
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly ApplicationDbContext context;
        private Hashtable repositories;

        public IScheduleRepository scheduleRepository { get; set;}

        public UnitOfWork(ApplicationDbContext context, IScheduleRepository scheduleRepository)
        {
            this.context = context;
            this.scheduleRepository = scheduleRepository;
        }

        public async Task<int> CompleteAsync() => await context.SaveChangesAsync();

        public IGenericRepository<TEntity> Reposirory<TEntity>() where TEntity : BaseEntity
        {

            if (repositories == null)
                repositories = new Hashtable();

            var entityKey = typeof(TEntity).Name;
            if (!repositories.ContainsKey(entityKey))
            {
                var repositoryType = typeof(GenericRepository<>);
                var repositoryInsatnce = Activator.CreateInstance
                    (repositoryType.MakeGenericType(typeof(TEntity)), context);

                repositories.Add(entityKey, repositoryInsatnce);
            }
            return (IGenericRepository<TEntity>)repositories[entityKey];
        }

        public IQueryable<TEntity> Include<TEntity>(
            params Expression<Func<TEntity, object>>[] includes) where TEntity : class
        {
            IQueryable<TEntity> query = context.Set<TEntity>();

            foreach (var include in includes)
            {
                query = query.Include(include);
            }

            return query;
        }
        public async Task<TEntity> Include<TEntity>(int id,
            params Expression<Func<TEntity, object>>[] includes) where TEntity : BaseEntity
        {
            var query = context.Set<TEntity>().AsQueryable();

            foreach (var include in includes)
            {
                query = query.Include(include);
            }

            return await query.FirstOrDefaultAsync(e => e.Id == id);
        }

    }
}