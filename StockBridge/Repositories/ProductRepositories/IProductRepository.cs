using System;
using System.Collections.Generic;
using StockBridge.Models.ProductModels;

namespace StockBridge.Repositories.ProductRepositories
{
    public interface IProductRepository
    {
        public DbResponse<List<Product>> GetProducts(DateTime? modifiedAfter);
    }
}