using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Authorization;
using StockBridge.Models.WarehouseModels.ProcRequests;
using StockBridge.Repositories.VendorRepositories;


namespace StockBridge.Controllers
{
    [ApiController]
    [Authorize]
    [Route("api/[controller]")]
    public class VendorController : SbController
    {
        private readonly ILogger<VendorController> _logger;
        private readonly IVendorRepository _vendorRepository;

        public VendorController(ILogger<VendorController> logger, IVendorRepository vendorRepository)
        {
            _logger = logger;
            _vendorRepository = vendorRepository;
        }

        [HttpGet]
        [Route("GetOrderingMethods")]
        public IActionResult GetOrderingMethods()
        {
            return DbHttpResponse(_vendorRepository.GetOrderingMethods());
        }

        [HttpGet]
        [Route("GetVendors")]
        public IActionResult GetVendors()
        {
            return DbHttpResponse(_vendorRepository.GetVendors());
        }

        [HttpPost]
        [Route("UpsertOrderingMethods")]
        public IActionResult UpsertOrderingMethods(List<UpsertOrderingMethodRequest> methods)
        {
            return DbHttpResponse(_vendorRepository.UpsertOrderingMethods(methods, ActiveEmployeeID));
        }

        [HttpPost]
        [Route("UpsertVendors")]
        public IActionResult UpsertVendors(List<UpsertVendorRequest> vendors)
        {
            return DbHttpResponse(_vendorRepository.UpsertVendors(vendors, ActiveEmployeeID));
        }
    }
}
