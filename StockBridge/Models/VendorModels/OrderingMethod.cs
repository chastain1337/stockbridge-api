using System;

namespace StockBridge.Models.VendorModels
{
    public class OrderingMethod
    {
        public int ID { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime? DateModified { get; set; }
        public int CreatedByEmployeeID { get; set; }
        public int? ModifiedByEmployeeID { get; set; }
        public string MethodName { get; set; }
        public string MethodSystemName { get; set; }


    }
}