using System;

namespace StockBridge.Models.EmployeeModels.ProcRequests
{
    public class UpsertEmployeeRequest
    {
        public int? ID { get; set; }
        public string DepartmentName { get; set; }
        public string RoleName { get; set; }
        public string Password { get; set; }
        public string FirstName { get; set; }
        public string LastName  {get; set;}
        public string UserName {get; set;}
        public string Email {get; set;}
        public DateTime StartDate {get; set;}
        public double AvailableVacationHours {get; set;}
        public double BaseRate {get; set;}
        public bool TerminatedFlag { get; set; }
    }
}