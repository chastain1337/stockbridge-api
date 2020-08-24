using System;

namespace StockBridge.Models.Employee
{
    public class Employee
    {
        public int ID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string UserName { get; set; }
        public byte[] Password { get; set; }
        public string Email { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime StartDate { get; set; }
        public Role Role { get; set; }
        public DateTime UpdatedDate { get; set; }
        public double AvailableVacationHours { get; set; }
        public double BaseRate { get; set; } 
        //public Department Department { get; set; }
    }
}