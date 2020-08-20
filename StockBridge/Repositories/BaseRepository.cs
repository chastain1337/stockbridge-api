using System.Data;
using System.Data.SqlClient;

namespace StockBridge.Repositories
{
    public abstract class BaseRepository
    {
        private readonly string _dbConnectionString;
        public readonly IDbConnection _db;
        protected BaseRepository()
        {
            _dbConnectionString = "Server=\"(localdb)\\MSSQLLocalDB\";Initial Catalog=master;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
            _db = new SqlConnection(_dbConnectionString);
        }
    }
}