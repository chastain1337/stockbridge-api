
using System.Collections.Generic;
using System.Linq;
using Dapper;
using StockBridge.Models.WarehouseModels;
using StockBridge.Models.WarehouseModels.ProcRequests;

namespace StockBridge.Repositories.WarehouseRepositories
{
    public class WarehouseRepository:BaseRepository,IWarehouseRepository
    {
        public DbResponse<List<Location>> GetLocations()
        {
            return Try( (_db) => _db.Query<Location>("SELECT * FROM StockBridge.Warehouse.Location").ToList());
        }

        public DbResponse<List<int>> UpsertWarehouseLocations(List<UpsertLocationRequest> locations, int activeEmployeeID)
        {
            var paramsList = locations.Select( location => new
            {
                @ID = location.ID,
                @ActiveEmployeeID = activeEmployeeID,
                @QuickPick = location.QuickPick,
                @Aisle = location.Aisle,
                @Section = location.Section,
                @Shelf = location.Shelf,
                @Name = location.Name,
                @CustomName = location.CustomName
            }).ToList();
            return Upsert("StockBridge.Warehouse.UpsertLocation", paramsList);
        }
    }
}