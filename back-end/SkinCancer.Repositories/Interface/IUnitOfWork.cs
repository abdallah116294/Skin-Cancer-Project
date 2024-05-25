using SkinCancer.Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace SkinCancer.Repositories.Interface
{
    public interface IUnitOfWork
    {
        IGenericRepository<TEntity> Reposirory<TEntity>() where TEntity : BaseEntity;
        IScheduleRepository scheduleRepository { get; set; }
		IDetectionRepository detectionRepositoty { get; set; }

        Task<int> CompleteAsync();

        IQueryable<TEntity> Include<TEntity>(
            params Expression<Func<TEntity, object>>[] includes) where TEntity : class;


        Task<TEntity> Include<TEntity>(int id, 
            params Expression<Func<TEntity, object>>[] includes) where TEntity : BaseEntity;
        List<T> SelectItem<T>(Expression<Func<T, bool>> predicate,
            params Expression<Func<T, object>>[] includes) where T : class;


        Task<List<T>> SelectItemAsync<T>(Expression<Func<T, bool>> predicate,
            params Expression<Func<T, object>>[] includes) where T : class;


    }
}
