using System;
using Microsoft.AspNetCore.Mvc;
using StockBridge.Repositories;

namespace StockBridge.Controllers
{
    public class SbController : ControllerBase
    {
        public int ActiveEmployeeID => Int32.Parse(HttpContext.User.Identity.Name);

        public IActionResult DbHttpResponse<T>(DbResponse<T> dbResponse)
        {
            if (dbResponse.Success) return Ok(dbResponse);
            return BadRequest(dbResponse);
        }
    }
}