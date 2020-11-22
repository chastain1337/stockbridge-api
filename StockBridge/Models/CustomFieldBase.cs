using System;
using StockBridge.Models.WarehouseModels;
using StockBridge.Models.VendorModels;

namespace StockBridge.Models
{
    public abstract class CustomFieldBase
    {
        public int ID { get; set; } = -1;
        public DateTime DateCreated { get; set; } = DateTime.Now;
        public DateTime? DateModified { get; set; }
        public int CreatedByEmployeeID { get; set; } = -1;
        public int? ModifiedByEmployeeID { get; set; }
        public bool DeleteFlag { get; set; } = false;
        public string SystemName { get; set; }
        public string FriendlyName { get; set; }
        public string Value { get; set; }
        public string Description { get; set; }
    }
}