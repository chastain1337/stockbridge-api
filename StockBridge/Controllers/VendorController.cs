using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Authorization;
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

    }
}
