using System;
using System.Collections.Generic;
using StockBridge.Models.WarehouseModels;
using StockBridge.Models.WarehouseModels.ProcRequests;


namespace StockBridge.Repositories.WarehouseRepositories
{
    public interface IWarehouseRepository
    {
        public DbResponse<List<Location>> GetLocations();
        public DbResponse<List<int>> UpsertWarehouseLocations(List<UpsertLocationRequest> locations, int activeEmployeeID);
    }
}