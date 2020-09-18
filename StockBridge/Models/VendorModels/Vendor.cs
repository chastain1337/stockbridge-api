using System;

namespace StockBridge.Models.VendorModels
{
    public class Vendor
    {
        public int ID { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime? DateModified { get; set; }
        public int CreatedByEmployeeID { get; set; }
        public int? ModifiedByEmployeeID { get; set; }
        public bool DeleteFlag { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public double? OrderingMin { get; set; }
        public OrderingMethod OrderingMethod { get; set; }
        public string Email { get; set; }
        public string AccountNumber { get; set; }
        public string PhoneNumber { get; set; }
        public bool? WillDropShipForUs { get; set; }
        public bool? WillChargeFreightForDropShip { get; set; }
        public bool? WillChargeFreightForOrders { get; set; }
        public int? LeadTimeBusinessDays { get; set; }
        public bool UseAutoOrdering { get; set; }

    }
}