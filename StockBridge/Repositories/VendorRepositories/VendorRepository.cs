using System.Collections.Generic;
using System.Data;
using System.Linq;
using Dapper;
using StockBridge.Models.VendorModels;
using StockBridge.Models.WarehouseModels.ProcRequests;

namespace StockBridge.Repositories.VendorRepositories
{
    public class VendorRepository:BaseRepository,IVendorRepository
    {
        public DbResponse<List<OrderingMethod>> GetOrderingMethods()
        {
            return Try((_db) => _db.Query<OrderingMethod>("SELECT * FROM StockBridge.Vendor.OrderingMethod").ToList());
        }
        public DbResponse<List<Vendor>> GetVendors()
        {
            return Try((_db) => _db.Query<OrderingMethod, Vendor, Vendor>("StockBridge.Vendor.GetVendors", (orderingMethod, vendor) =>
            {
                vendor.OrderingMethod = orderingMethod;
                return vendor;
            }, commandType: CommandType.StoredProcedure).ToList());
        }

        public DbResponse<List<int>> UpsertOrderingMethods(List<UpsertOrderingMethodRequest> methods, int activeEmployeeID)
        {
            var paramsList = methods.Select(method => new
            {
                @ID = method.ID,
                @ActiveEmployeeID = activeEmployeeID,
                @MethodName = method.MethodName
            }).ToList();
            return Upsert("StockBridge.Vendor.UpsertOrderingMethod", paramsList);
        }

        public DbResponse<List<int>> UpsertVendors(List<UpsertVendorRequest> vendors, int activeEmployeeID)
        {
            var paramsList = vendors.Select(vendor => new
            {
                @ID = vendor.ID,
                @ActiveEmployeeID = activeEmployeeID,
                @Code = vendor.Code,
                @Name = vendor.Name,
                @OrderingMin = vendor.OrderingMin,
                @OrderingMethodName = vendor.OrderingMethodName,
                @Email = vendor.Email,
                @AccountNumber = vendor.AccountNumber,
                @PhoneNumber = vendor.PhoneNumber,
                @WillDropShipForUs = vendor.WillDropShipForUs,
                @WillChargeFreightForDropShip = vendor.WillChargeFreightForDropShip,
                @WillChargeFreightForOrders = vendor.WillChargeFreightForOrders,
                @LeadTimeBusinessDays = vendor.LeadTimeBusinessDays,
                @UseAutoOrdering = vendor.UseAutoOrdering,
            }).ToList();
            var res = Upsert("StockBridge.Vendor.UpsertVendor", paramsList);
            if (res.Success && res.Data.Count == vendors.Count)
            {
                //Assign IDs to the new vendors
                for (int i = 0; i < res.Data.Count; i++)
                {
                    vendors[i].ID = res.Data[i];
                }

                var vendorsWithCustomFieldsThatHaveAValue =
                    vendors
                        .Where(v => v.CustomFields.Count > 0)
                        .Where(v => v.CustomFields
                            .All(cf => !string.IsNullOrEmpty(cf.Value)))
                        .ToList();
                if (vendorsWithCustomFieldsThatHaveAValue.Count > 0)
                {
                    var paramsListCustomFields = new List<dynamic>();

                    vendorsWithCustomFieldsThatHaveAValue.ForEach(v =>
                        v.CustomFields.ForEach(cf =>
                            paramsListCustomFields.Add(
                                new
                                {
                                    @ActiveEmployeeId = activeEmployeeID,
                                    @VendorID = v.ID,
                                    @SystemName = cf.SystemName,
                                    @FriendlyName = cf.FriendlyName,
                                    @Value = cf.Value,
                                    @Description = cf.Description
                                })));
                    return Upsert("StockBridge.Vendor.UpsertVendorCustomField", paramsListCustomFields);
                }
            }
            return res;

        }
    }
}