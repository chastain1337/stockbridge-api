using System.Collections.Generic;

namespace StockBridge.Models.WarehouseModels.ProcRequests
{
    public class UpsertVendorRequest
    {
        public int? ID { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public double OrderingMin { get; set; }
        public string OrderingMethodName { get; set; }
        public string Email { get; set; }
        public string AccountNumber { get; set; }
        public string PhoneNumber { get; set; }
        public bool? WillDropShipForUs { get; set; }
        public bool? WillChargeFreightForDropShip { get; set; }
        public bool? WillChargeFreightForOrders { get; set; }
        public int? LeadTimeBusinessDays { get; set; }
        public bool UseAutoOrdering { get; set; }
        public List<GenericCustomField> CustomFields { get; set; }

    }
}