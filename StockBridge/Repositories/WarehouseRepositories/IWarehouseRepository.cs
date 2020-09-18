using System;
using System.Collections.Generic;
using StockBridge.Models.WarehouseModels;


namespace StockBridge.Repositories.WarehouseRepositories
{
    public interface IWarehouseRepository
    {
        public DbResponse<List<Location>> GetLocations();
    }
}