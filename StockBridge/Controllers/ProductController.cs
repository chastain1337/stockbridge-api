using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Authorization;
using StockBridge.Models.ProductModels;
using StockBridge.Models.ProductModels.ProcRequests;
using StockBridge.Repositories.ProductRepositories;

namespace StockBridge.Controllers
{
    [ApiController]
    [Authorize]
    [Route("api/[controller]")]
    public class ProductController : SbController
    {
        private readonly ILogger<ProductController> _logger;
        private readonly IProductRepository _productRepository;

        public ProductController(ILogger<ProductController> logger, IProductRepository productRepository)
        {
            _logger = logger;
            _productRepository = productRepository;
        }

        [HttpGet]
        [Route("GetProducts")]
        public IActionResult GetProducts(DateTime? modifiedAfter = null)
        {
            return DbHttpResponse( _productRepository.GetProducts(modifiedAfter) );
        }

        [HttpPost]
        [Route("UpsertProducts")]
        public IActionResult UpsertProducts(List<UpsertProductRequest> products)
        {
            return DbHttpResponse(_productRepository.UpsertProducts(products, ActiveEmployeeID));
        }

        [HttpGet]
        [Route("GetProductViewSettings")]
        public IActionResult GetProductViewSettings()
        {
            return DbHttpResponse(_productRepository.GetProductViewSettings(ActiveEmployeeID));
        }

    }
}
