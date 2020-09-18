using StockBridge.Models.EmployeeModels;

namespace StockBridge.Helpers
{
    public interface IEmployeeHelper
    {
        public Employee Authenticate(string username, string password);
    }

}