using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Dapper;

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
            var res = new DbResponse<List<int>> { Data = new List<int>() };
            _db.Open();
            var transaction = _db.BeginTransaction();
            try
            {
                parametersList.ForEach(setOfParams =>
                {
                    var id = _db.Query<int>(procName, setOfParams, transaction, commandType: CommandType.StoredProcedure).FirstOrDefault();
                    res.Data.Add(id);
                });
            }
            catch (Exception e)
            {
                res.Errors.Add(e.Message);
                res.Success = false;
                transaction.Rollback();
                _db.Close();
                return res;
            }
            transaction.Commit();
            _db.Close();

            return res;
        }
    }
}