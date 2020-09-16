using System;
using Microsoft.AspNetCore.Mvc;

namespace StockBridge.Controllers
{
    public class SbController : ControllerBase
    {
        public int ActiveEmployeeID => Int32.Parse(HttpContext.User.Identity.Name);
    }
}