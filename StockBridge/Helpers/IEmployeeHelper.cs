using StockBridge.Models.Employee;

namespace StockBridge.Helpers
{
    public interface IEmployeeHelper
    {
        public Employee Authenticate(string username, string password);
    }

}