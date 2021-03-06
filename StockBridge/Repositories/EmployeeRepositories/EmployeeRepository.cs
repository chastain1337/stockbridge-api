﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Dapper;
using StockBridge.Models.EmployeeModels;
using StockBridge.Models.EmployeeModels.ProcRequests;

namespace StockBridge.Repositories.EmployeeRepositories
{
    public class EmployeeRepository:BaseRepository,IEmployeeRepository
    {
        public DbResponse<IEnumerable<Role>> GetEmployeeRoles()
        {
            return Try( (_db) => _db.Query<Role>("SELECT * FROM StockBridge.Employee.Role WHERE DeletedFlag = 0"));
        }

        public DbResponse<IEnumerable<Department>> GetEmployeeDepartments()
        {
            return Try( (_db) => _db.Query<Department>("SELECT * FROM StockBridge.Employee.Department WHERE DeletedFlag = 0"));
        }

        public DbResponse<IEnumerable<Employee>> GetEmployees(DateTime? modifiedAfter = null)
        {
            return Try( (_db) => _db.Query<Role, Department, Employee, Employee>("StockBridge.Employee.GetEmployees", (role, department, employee) =>
            {
                employee.Role = role;
                employee.Department = department;
                return employee;
            }, new { @LastTimeUpdated = modifiedAfter }, commandType: CommandType.StoredProcedure));
        }

        public DbResponse<Employee> GetEmployeeById(int id)
        {
            return Try( (_db) =>
            
                _db.Query<Role, Department, Employee, Employee>(sql: "StockBridge.Employee.GetEmployees",
                    param: new {@Id = id}, map: (role, department, employee) =>
                    {
                        employee.Role = role;
                        employee.Department = department;
                        return employee;
                    }).FirstOrDefault()
            );
            
        }

        public DbResponse<Employee> GetEmployeeByUsername(string username)
        {
            return Try( (_db) =>
            {
                return _db.Query<Role, Department, Employee, Employee>(
                    sql: "StockBridge.Employee.GetEmployees",
                    param: new {@Username = username},
                    map: (role, department, employee) =>
                    {
                        employee.Role = role;
                        employee.Department = department;
                        return employee;
                    },
                    commandType: CommandType.StoredProcedure)
                    .FirstOrDefault();
            });
        }

        public DbResponse<List<int>> UpsertEmployees(List<UpsertEmployeeRequest> employees,int userId)
        {
            var paramsList = employees.Select(employee => new
            {
                @ID = employee.ID,
                @DepartmentName = employee.DepartmentName,
                @RoleName = employee.RoleName,
                @FirstName = employee.FirstName,
                @LastName = employee.LastName,
                @UserName = employee.UserName,
                @Email = employee.Email,
                @Password = employee.Password,
                @StartDate = employee.StartDate.Date,
                @AvailableVacationHours = employee.AvailableVacationHours,
                @BaseRate = employee.BaseRate,
                @TerminatedFlag = employee.TerminatedFlag,
                @ActiveEmployeeID = userId
            }).ToList();
            return Upsert("StockBridge.Employee.UpsertEmployee", paramsList);
        }

        public DbResponse<List<int>> UpsertDepartments(List<UpsertDepartmentRequest> departments, int userId)
        {
            var paramsList = departments.Select(department => new
            {
                @ID = department.ID,
                @DepartmentName = department.Name,
                @ActiveEmployeeID = userId
            }).ToList();
            return Upsert("StockBridge.Employee.UpsertDepartment", paramsList);
        }

        public DbResponse<List<int>> UpsertRoles(List<UpsertRoleRequest> roles, int userId)
        {
            var paramsList = roles.Select(role => new
            {
                @ID = role.ID,
                @RoleName = role.Name,
                @ActiveEmployeeID = userId
            }).ToList();
            return Upsert("StockBridge.Employee.UpsertRole", paramsList);
        }
    }
}