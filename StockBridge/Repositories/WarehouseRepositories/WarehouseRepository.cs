
using System.Collections.Generic;
using System.Linq;
using Dapper;
using StockBridge.Models.WarehouseModels;

namespace StockBridge.Repositories.WarehouseRepositories
{
    public class WarehouseRepository:BaseRepository,IWarehouseRepository
    {
        public DbResponse<List<Location>> GetLocations()
        {
            return Try( () => _db.Query<Location>("SELECT * FROM StockBridge.Warehouse.Location").ToList());
        }
    }
}