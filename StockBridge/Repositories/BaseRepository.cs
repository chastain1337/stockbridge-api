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
        //private readonly string _dbConnectionString;
        //public readonly IDbConnection _db;
        private readonly string cs;
        protected BaseRepository()
        {
            cs = "Server=localhost;Database=StockBridge;User Id=sa;Password=StockBridge1234;";
            //cs = "Server=\"(localdb)\\MSSQLLocalDB\";Initial Catalog=master;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False;MultipleActiveResultSets=true";
            //_db = new SqlConnection(cs);
        }

        public DbResponse<List<int>> Upsert<T>(string procName, List<T> parametersList)
        {
            return Try((transaction,db) =>
            {
                return parametersList.Select(setOfParams =>
                    db.Query<int>(procName, setOfParams, transaction, commandType: CommandType.StoredProcedure)
                        .FirstOrDefault()).ToList();
            });
        }

        public DbResponse<T> Try<T>(Func<IDbTransaction, IDbConnection, T> func)
        {
            using var db = new SqlConnection(cs);
            var res = new DbResponse<T>();
            try
            {
                db.Open();
                var transaction = db.BeginTransaction();
                try
                {
                    res.Data = func(transaction, db);
                    transaction.Commit();
                    db.Close();
                    return res;
                }
                catch (Exception e)
                {
                    res.Errors.Add(e.Message);
                    res.Success = false;
                    transaction.Rollback();
                    db.Close();
                    return res;
                }
            }
            catch (Exception e)
            {
                res.Errors.Add(e.Message);
                res.Success = false;
                db.Close();
                return res;
            }
        }

        public DbResponse<T> Try<T>(Func<IDbConnection,T> func)
        {
            using var db = new SqlConnection(cs);
            var res = new DbResponse<T>();
            try
            {
                //_db.Open();
                res.Data = func(db);
                //_db.Close();
                return res;
            }
            catch (Exception e)
            {
                res.Errors.Add(e.Message);
                res.Success = false;
                //_db.Close();
                return res;
            }
        }
    }
}