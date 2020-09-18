using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Dapper;
using StockBridge.Models.ProductModels;
using StockBridge.Models.WarehouseModels;

namespace StockBridge.Repositories.ProductRepositories
{
    public class ProductRepository:BaseRepository,IProductRepository
    {
        public DbResponse<List<Product>> GetProducts(DateTime? modifiedAfter)
        {
            return Try(() => _db.Query<Location, Product, Product>("StockBridge.Product.GetProducts", (location, product) =>
            {
                product.Location = location;
                return product;
            }, param:new {@ModifiedAfter = modifiedAfter}, commandType: CommandType.StoredProcedure).ToList());
        }
    }
}