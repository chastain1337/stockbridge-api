using System;

namespace StockBridge.Models.WarehouseModels
{
    public class Location
    {
        public int ID { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime? DateModified { get; set; }
        public int CreatedByEmployeeID { get; set; }
        public int? ModifiedByEmployeeID { get; set; }
        public bool DeleteFlag { get; set; }
        public int? QuickPick { get; set; }
        public int? Aisle { get; set; }
        public string Section { get; set; }
        public int? Shelf { get; set; }
        public string Name { get; set; }
        public string CustomName { get; set; }
    }
}