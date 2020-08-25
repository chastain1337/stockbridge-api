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
            _dbConnectionString = "Server=localhost;Database=StockBridge;User Id=sa;Password=White434$;";
            //_dbConnectionString =               "Server=\"(localdb)\\MSSQLLocalDB\";Initial Catalog=master;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
            _db = new SqlConnection(_dbConnectionString);
        }
    }
}