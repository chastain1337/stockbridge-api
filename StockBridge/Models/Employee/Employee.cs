using System;

namespace StockBridge.Models.Employee
{
    public class Employee
    {
        public Role Role { get; set; }
        public Department Department { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime? DateModified { get; set; }
        public int CreatedByEmployeeID { get; set; }
        public int? ModifiedByEmployeeID { get; set; }
        public byte[] Password { get; set; }
        public int? ID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string UserName { get; set; }
        public string Email { get; set; }
        public DateTime StartDate { get; set; }
        public double AvailableVacationHours { get; set; }
        public double BaseRate { get; set; }
        public bool Terminated { get; set; }
    }
}