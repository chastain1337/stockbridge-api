using System.Collections.Generic;
using StockBridge.Models.VendorModels;
using StockBridge.Models.WarehouseModels.ProcRequests;

namespace StockBridge.Repositories.VendorRepositories
{
    public interface IVendorRepository
    {
        public DbResponse<List<OrderingMethod>> GetOrderingMethods();
        public DbResponse<List<Vendor>> GetVendors();

        public DbResponse<List<int>> UpsertOrderingMethods(List<UpsertOrderingMethodRequest> methods,
            int activeEmployeeID);
        public DbResponse<List<int>> UpsertVendors(List<UpsertVendorRequest> vendors,
            int activeEmployeeID);
    }
}