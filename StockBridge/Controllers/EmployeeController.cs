using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Net.Http.Headers;
using StockBridge.Helpers;
using StockBridge.Models.Employee;
using StockBridge.Repositories;

namespace StockBridge.Controllers
{
    [ApiController]
    [Authorize]
    [Route("api/[controller]")]
    public class EmployeeController : ControllerBase
    {
        private readonly ILogger<EmployeeController> _logger;
        private readonly IEmployeeRepository _employeeRepository;
        private readonly IEmployeeHelper _employeeHelper;
        private readonly AppSettings _appSettings;
       
        public EmployeeController(ILogger<EmployeeController> logger, IEmployeeRepository employeeRepository, IEmployeeHelper employeeHelper, IOptions<AppSettings> appSettings)
        {
            _logger = logger;
            _employeeRepository = employeeRepository;
            _employeeHelper = employeeHelper;
            _appSettings = appSettings.Value;
        }

        [HttpGet]
        [AllowAnonymous]
        [Route("Test")]
        public IActionResult Test()
        {
            return Ok(new { testWas = "success" });
        }

        [HttpGet]
        [Route("GetEmployeeRoles")]
        public IActionResult GetEmployeeRoles()
        {
            var model = _employeeRepository.GetEmployeeRoles().ToArray();
            return Ok(model);
        }

        [Route("GetEmployees")]
        public IEnumerable<Employee> GetEmployees()
        {
            return _employeeRepository.GetEmployees().ToArray();
        }

        [Route("GetEmployees/{id?}")]
        public Employee GetEmployees(int id)
        {
            return _employeeRepository.GetEmployeeById(id);
        }

        [Route("GetEmployees/{username?}")]
        public Employee GetEmployeeByUsername(string username)
        {
            return _employeeRepository.GetEmployeeByUsername(username);
        }

        [Route("GetLoggedInEmployee")]
        public IActionResult GetLoggedInEmployee()
        {
            var employeeId = int.Parse(HttpContext.User.Identity.Name);
            

            var employee = _employeeRepository.GetEmployeeById(employeeId);
            
            
            return Ok( new LoggedInEmployee(employee, Request.Headers[HeaderNames.Authorization].ToString().Replace("Bearer ","")));
        }

        [AllowAnonymous]
        [HttpPost("Authenticate")]
        public IActionResult Authenticate([FromBody] Authenticate model)
        {
            var employee = _employeeHelper.Authenticate(model.UserName, model.Password);

            if (employee == null) return BadRequest(new {message = "Username or password is incorrect."});

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[] {new Claim(ClaimTypes.Name, employee.ID.ToString())}),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key),
                    SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            var tokenString = tokenHandler.WriteToken(token);

            return Ok(new LoggedInEmployee(employee, tokenString));
        }

        //[HttpPost("Add")]
        //public IActionResult Add(List<Employee> employees)
        //{
        //    _employeeRepository.
        //}
    }
}
