using System;
using StockBridge.Models.WarehouseModels;
using StockBridge.Models.VendorModels;

namespace StockBridge.Models.ProductModels
{
    public class Product
    {
        public int ID {get; set;}
        public DateTime DateCreated { get; set; }
        public DateTime? DateModified { get; set; }
        public int CreatedByEmployeeID { get; set; }
        public int? ModifiedByEmployeeID { get; set; }
        public bool DeleteFlag { get; set; }
        public string SKU { get; set; }
        public string Description { get; set; }
        public string PartNumber { get; set; }
        public string OrderingPartNumber { get; set; }
        public int PrimaryVendor { get; set; }
        public int SecondaryVendor { get; set; }
        public double? LastUnitCost { get; set; }
        public int Location { get; set; }
        public int CasePack { get; set; }
        public double? Length_IN { get; set; }
        public double? Width_IN { get; set; }
        public double? Height_IN { get; set; }
        public int? Weight_OZ { get; set; }
        public int Minimum { get; set; }
        public int Maximum { get; set; }
        public int ShelfCount { get; set; }
        public int Pending { get; set; }
        public int OnOrder { get; set; }
        public int Available { get; set; }
        public int ToOrderQuantity { get; set; }
        public int ToOrderAmount { get; set; }
    }
}