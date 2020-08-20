using System.Collections.Generic;
using System.Data;
using System.Linq;
using Dapper;
using StockBridge.Models.Employee;

namespace StockBridge.Repositories
{
    public class EmployeeRepository:BaseRepository,IEmployeeRepository
    {
        public EmployeeRepository() : base()
        {
        }

        public IEnumerable<Role> GetEmployeeRoles()
        {
            return _db.Query<Role>("SELECT * FROM StockBridge.Employee.Role");
        }

        public IEnumerable<Employee> GetEmployees()
        {
            return _db.Query<Role,Employee,Employee>("SELECT * FROM StockBridge.Employee.Role r, StockBridge.Employee.Employee e WHERE e.RoleID = r.ID", (role,employee) =>
            {
                employee.Role = role;
                return employee;
            });
        }

        public Employee GetEmployeeById(int id)
        {
            return _db.Query<Role,Employee,Employee>(
                sql: "SELECT * FROM StockBridge.Employee.Role r, StockBridge.Employee.Employee e WHERE e.RoleID = r.ID AND e.ID = @ID", param:
                new {@ID = id}, map: (role, employee) => { employee.Role = role;
                    return employee;
                }).FirstOrDefault();
        }

        public Employee GetEmployeeByUsername(string username)
        {
            return _db.Query<Role, Employee, Employee>(
                sql: "SELECT * FROM StockBridge.Employee.Role r, StockBridge.Employee.Employee e WHERE e.RoleID = r.ID AND e.UserName = @Username", param:
                new { @Username = username }, map: (role, employee) => {
                    employee.Role = role;
                    return employee;
                }).FirstOrDefault();
        }
    }
}