using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Authorization;
using StockBridge.Repositories.WarehouseRepositories;


namespace StockBridge.Controllers
{
    [ApiController]
    [Authorize]
    [Route("api/[controller]")]
    public class WarehouseController : SbController
    {
        private readonly ILogger<WarehouseController> _logger;
        private readonly IWarehouseRepository _warehouseRepository;

        public WarehouseController(ILogger<WarehouseController> logger, IWarehouseRepository warehouseRepository)
        {
            _logger = logger;
            _warehouseRepository = warehouseRepository;
        }

        [HttpGet]
        [AllowAnonymous]
        [Route("GetWarehouseLocations")]
        public IActionResult GetWarehouseLocations()
        {
            return DbHttpResponse(_warehouseRepository.GetLocations());
        }

    }
}
