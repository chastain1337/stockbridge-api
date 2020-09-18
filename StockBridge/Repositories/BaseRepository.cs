using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Dapper;
using Microsoft.AspNetCore.Mvc;

namespace StockBridge.Repositories
{
    public abstract class BaseRepository
    {
        private readonly string _dbConnectionString;
        public readonly IDbConnection _db;
        protected BaseRepository()
        {
            //_dbConnectionString = "Server=localhost;Database=StockBridge;User Id=sa;Password=White434$;";
            _dbConnectionString =               "Server=\"(localdb)\\MSSQLLocalDB\";Initial Catalog=master;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
            _db = new SqlConnection(_dbConnectionString);
        }

        public DbResponse<List<int>> Upsert<T>(string procName, List<T> parametersList)
        {
            return Try(transaction =>
            {
                return parametersList.Select(setOfParams =>
                    _db.Query<int>(procName, setOfParams, transaction, commandType: CommandType.StoredProcedure)
                        .FirstOrDefault()).ToList();
            });
        }

        public DbResponse<T> Try<T>(Func<IDbTransaction,T> func)
        {
            _db.Open();
            var transaction =_db.BeginTransaction();
            var res = new DbResponse<T>();
            try
            {
                res.Data = func(transaction);
                transaction.Commit();
                _db.Close();
                return res;
            }
            catch (Exception e)
            {
                res.Errors.Add(e.Message);
                res.Success = false;
                transaction.Rollback();
                _db.Close();
                return res;
            }
            
        }

        public DbResponse<T> Try<T>(Func<T> func)
        {
            _db.Open();
            var res = new DbResponse<T>();
            try
            {
                res.Data = func();
                _db.Close();
                return res;
            }
            catch (Exception e)
            {
                res.Errors.Add(e.Message);
                res.Success = false;
                _db.Close();
                return res;
            }
            
        }
    }
}