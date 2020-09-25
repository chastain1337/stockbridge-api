using System;
using System.Collections.Generic;
using StockBridge.Models.ProductModels;
using StockBridge.Models.ProductModels.ProcRequests;

namespace StockBridge.Repositories.ProductRepositories
{
    public interface IProductRepository
    {
        public DbResponse<List<Product>> GetProducts(DateTime? modifiedAfter);
        DbResponse<List<int>> UpsertProducts(List<UpsertProductRequest> products, int activeEmployeeID);
        DbResponse<List<ProductViewSetting>> GetProductViewSettings(int employeeID);
        DbResponse<List<int>> UpsertProductViewSettings(List<ProductViewSetting> settings, int activeEmployeeID);
    }
}