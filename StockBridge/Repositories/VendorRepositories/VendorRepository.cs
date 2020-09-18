using System.Collections.Generic;
using System.Data;
using System.Linq;
using Dapper;
using StockBridge.Models.VendorModels;

namespace StockBridge.Repositories.VendorRepositories
{
    public class VendorRepository:BaseRepository,IVendorRepository
    {
        public DbResponse<List<OrderingMethod>> GetOrderingMethods()
        {
            return Try(() => _db.Query<OrderingMethod>("SELECT * FROM StockBridge.Vendor.OrderingMethod").ToList());
        }
        public DbResponse<List<Vendor>> GetVendors()
        {
            return Try(() => _db.Query<OrderingMethod, Vendor, Vendor>("StockBridge.Vendor.GetVendors", (orderingMethod, vendor) =>
            {
                vendor.OrderingMethod = orderingMethod;
                return vendor;
            }, commandType: CommandType.StoredProcedure).ToList());
        }
    }
}