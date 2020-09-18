using System;
using System.Collections.Generic;
using StockBridge.Models.EmployeeModels;
using StockBridge.Models.EmployeeModels.ProcRequests;

namespace StockBridge.Repositories.EmployeeRepositories
{
    public interface IEmployeeRepository
    {
        public DbResponse<IEnumerable<Role>> GetEmployeeRoles();
        public DbResponse<IEnumerable<Department>> GetEmployeeDepartments();
        public DbResponse<IEnumerable<Employee>> GetEmployees(DateTime? modifiedAfter = null);
        public DbResponse<Employee> GetEmployeeById(int id);
        public DbResponse<Employee> GetEmployeeByUsername(string username);
        public DbResponse<List<int>> UpsertEmployees(List<UpsertEmployeeRequest> employees, int userId);
        public DbResponse<List<int>> UpsertRoles(List<UpsertRoleRequest> roles, int userId);
        public DbResponse<List<int>> UpsertDepartments(List<UpsertDepartmentRequest> department, int userId);
    }
}