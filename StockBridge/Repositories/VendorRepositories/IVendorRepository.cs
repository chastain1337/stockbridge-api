using System.Collections.Generic;
using StockBridge.Models.VendorModels;

namespace StockBridge.Repositories.VendorRepositories
{
    public interface IVendorRepository
    {
        public DbResponse<List<OrderingMethod>> GetOrderingMethods();
        public DbResponse<List<Vendor>> GetVendors();
    }
}