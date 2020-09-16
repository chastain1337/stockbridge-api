using System.Collections.Generic;
using StockBridge.Models.Employee;
using StockBridge.Models.Employee.ProcRequests;

namespace StockBridge.Repositories
{
    public interface IEmployeeRepository
    {
        public IEnumerable<Role> GetEmployeeRoles();
        public IEnumerable<Department> GetEmployeeDepartments();
        public IEnumerable<Employee> GetEmployees();
        public Employee GetEmployeeById(int id);
        public Employee GetEmployeeByUsername(string username);
        public DbResponse<List<int>> UpsertEmployees(List<UpsertEmployeeRequest> employees, int userId);
        public DbResponse<List<int>> UpsertRoles(List<UpsertRoleRequest> roles, int userId);
        public DbResponse<List<int>> UpsertDepartments(List<UpsertDepartmentRequest> department, int userId);
    }
}