using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Net.Http.Headers;
using StockBridge.Helpers;
using StockBridge.Models.EmployeeModels;
using StockBridge.Models.EmployeeModels.ProcRequests;
using StockBridge.Repositories;
using StockBridge.Repositories.EmployeeRepositories;

namespace StockBridge.Controllers
{
    [ApiController]
    [Authorize]
    [Route("api/[controller]")]
    public class EmployeeController : SbController
    {
        private readonly IEmployeeRepository _employeeRepository;
        private readonly IEmployeeHelper _employeeHelper;
        private readonly ILogger<EmployeeController> _logger;
        private readonly AppSettings _appSettings;

        public EmployeeController(ILogger<EmployeeController> logger, IEmployeeRepository employeeRepository, IEmployeeHelper employeeHelper, IOptions<AppSettings> appSettings)
        {
            _logger = logger;
            _employeeRepository = employeeRepository;
            _employeeHelper = employeeHelper;
            _appSettings = appSettings.Value;
        }


        [HttpGet]
        [Route("GetEmployeeRoles")]
        public IActionResult GetEmployeeRoles()
        {
            return DbHttpResponse(_employeeRepository.GetEmployeeRoles());
        }

        [HttpGet]
        [Route("GetEmployeeDepartments")]
        public IActionResult GetEmployeeDepartments()
        {
            return DbHttpResponse(_employeeRepository.GetEmployeeDepartments());
        }

        [Route("GetEmployees")]
        public IActionResult GetEmployees(DateTime? modifiedAfter = null)
        {
            return DbHttpResponse(_employeeRepository.GetEmployees(modifiedAfter));
        }
        

        [Route("GetEmployees/{id?}")]
        public IActionResult GetEmployees(int id)
        {
            return DbHttpResponse(_employeeRepository.GetEmployeeById(id));
        }

        [Route("GetEmployees/{username?}")]
        public IActionResult GetEmployeeByUsername(string username)
        {
            return DbHttpResponse(_employeeRepository.GetEmployeeByUsername(username));
        }

        [Route("GetLoggedInEmployee")]
        public IActionResult GetLoggedInEmployee()
        {
            var res = new DbResponse<LoggedInEmployee>();
            var employee = _employeeRepository.GetEmployeeById(ActiveEmployeeID);
            if (employee.Data != null)
            {
                res.Data = new LoggedInEmployee(employee.Data,
                    Request.Headers[HeaderNames.Authorization].ToString().Replace("Bearer ", ""));
                return Ok(res);
            }

            res.Success = false;
            res.Errors.Add("There was an error fetching the logged in Employee based on your token. Please refresh and try again.");
            return BadRequest(res);
        }

        [HttpPost("UpsertEmployees")]
        public IActionResult UpsertEmployees([FromBody] List<UpsertEmployeeRequest> employees)
        {
            return DbHttpResponse(_employeeRepository.UpsertEmployees(employees, ActiveEmployeeID));
        }

        [HttpPost("UpsertRoles")]
        public IActionResult UpsertRoles([FromBody] List<UpsertRoleRequest> roles)
        {
            return DbHttpResponse(_employeeRepository.UpsertRoles(roles, ActiveEmployeeID));
        }

        [HttpPost("UpsertDepartments")]
        public IActionResult UpsertDepartments([FromBody] List<UpsertDepartmentRequest> departments)
        {
            return DbHttpResponse(_employeeRepository.UpsertDepartments(departments, ActiveEmployeeID));
        }


        [AllowAnonymous]
        [HttpPost("Authenticate")]
        public IActionResult Authenticate([FromBody] Authenticate model)
        {
            var res = new DbResponse<LoggedInEmployee>();
            var employee = _employeeHelper.Authenticate(model.UserName, model.Password);

            if (employee == null)
            {
                res.Success = false;
                res.Errors = new List<string>() {"Username or password is incorrect."};
                return BadRequest(res);
            }
            
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[] {new Claim(type: ClaimTypes.Name, employee.ID.ToString())}),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key),
                    SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            var tokenString = tokenHandler.WriteToken(token);

            res.Data = new LoggedInEmployee(employee, tokenString);

            return Ok(res);
        }
    }
}
