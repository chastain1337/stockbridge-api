using System.Collections.Generic;
using StockBridge.Models.Employee;

namespace StockBridge.Repositories
{
    public interface IEmployeeRepository
    {
        public IEnumerable<Role> GetEmployeeRoles();
        public IEnumerable<Employee> GetEmployees();
        public Employee GetEmployeeById(int id);
        public Employee GetEmployeeByUsername(string username);
        public void Add(List<Employee> employees);
    }
}