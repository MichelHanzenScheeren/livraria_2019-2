﻿using Microsoft.EntityFrameworkCore;
using Model.Excpetions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;

namespace Data.Configurations
{
    public class Repository<T> where T : class
    {
        protected readonly LivrariaMHSContext _context;

        public Repository(LivrariaMHSContext context)
        {
            _context = context;
        }

        public async Task AddAsync(T entidade)
        {
            _context.Set<T>().Add(entidade);
            await _context.SaveChangesAsync();
        }

        public async Task RemoveAsync(T entidade)
        {
            try
            {
                _context.Set<T>().Remove(entidade);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException erro)
            {
                throw new IntegrityException(erro.Message);
            }
        }

        public async Task UpdateAsync(T entidade)
        {
            try
            {
                _context.Set<T>().Update(entidade);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException e)
            {
                throw new DbConcurrencyException(e.Message);
            }
        }

        public async Task<List<T>> FindAllAsync(Expression<Func<T, bool>> predicado, params string[] incluir)
        {
            if (incluir.Length != 0)
            {
                var pesquisa = _context.Set<T>().Include(incluir[0]);
                for (int i = 1; i < incluir.Length; i++)
                {
                    pesquisa = pesquisa.Include(incluir[i]);
                }
                return await pesquisa.Where(predicado).ToListAsync();
            }
            else
                return await _context.Set<T>().Where(predicado).ToListAsync();
        }

        public async Task<T> FindFirstAsync(Expression<Func<T, bool>> predicado, params string[] incluir)
        {
            var pesquisa = _context.Set<T>().Where(predicado);
            for (int i = 0; i < incluir.Length; i++)
            {
                pesquisa = pesquisa.Include(incluir[i]);
            }
            return await pesquisa.FirstOrDefaultAsync();
        }

        public async Task<bool> ExistAsync(Expression<Func<T, bool>> predicado)
        {
            return await _context.Set<T>().AnyAsync(predicado);
        }

        public async Task<T> LastAsync()
        {
            return await _context.Set<T>().LastAsync();
        }

        public async Task<List<T>> GetAllAsync(params string[] incluir)
        {
            if(incluir.Length != 0)
            {
                var pesquisa = _context.Set<T>().Include(incluir[0]);
                for (int i = 1; i < incluir.Length; i++)
                {
                    pesquisa = pesquisa.Include(incluir[i]);
                }
                return await pesquisa.ToListAsync();
            }
            else
                return await _context.Set<T>().ToListAsync();
        }

        public DbSet<T> Select()
        {
            return _context.Set<T>();
        }
    }
}
