using System;
namespace StockBridge.Models.Employee
{
    public class Department
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string SystemName { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime? DateModified { get; set; }
        public int? ModifiedByEmployeeID { get; set; }
        public int CreatedByEmployeeID { get; set; }
    }
}
