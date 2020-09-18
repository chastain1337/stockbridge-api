using System.Security.Cryptography;
using StockBridge.Models.EmployeeModels;
using StockBridge.Repositories.EmployeeRepositories;

namespace StockBridge.Helpers
{
    public class EmployeeHelper : IEmployeeHelper
    {
        private readonly IEmployeeRepository _employeeRepository;

        public EmployeeHelper(IEmployeeRepository employeeRepository)
        {
            _employeeRepository = employeeRepository;
        }

        public Employee Authenticate(string username, string password)
        {
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                return null;
            }

            var employee = _employeeRepository.GetEmployeeByUsername(username).Data;

            if (employee == null) return null;

            if (!PasswordIsValid(password, employee.Password)) return null;

            return employee;

        }

        private static bool PasswordIsValid(string plaintextPassword, byte[] storedPassword)
        {
            byte[] computedHash;
            using (var hashTool = new SHA512Managed())
            {
                computedHash = hashTool.ComputeHash(System.Text.Encoding.UTF8.GetBytes(plaintextPassword));
                hashTool.Clear();
            }

            for (int i = 0; i < computedHash.Length; i++)
            {
                if (computedHash[i] != storedPassword[i]) return false;
            }

            return true;
        }
    }
}