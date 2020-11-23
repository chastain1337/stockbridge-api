using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Dapper;
using StockBridge.Models.ProductModels;
using StockBridge.Models.ProductModels.ProcRequests;
using StockBridge.Models.WarehouseModels;

namespace StockBridge.Repositories.ProductRepositories
{
    public class ProductRepository:BaseRepository,IProductRepository
    {
        public DbResponse<List<Product>> GetProducts(DateTime? modifiedAfter)
        {
            return Try(_db =>
            {
                var productsList = _db.Query<Product>("StockBridge.Product.GetProducts",
                    param: new {@ModifiedAfter = modifiedAfter},
                    commandType: CommandType.StoredProcedure).ToList();

                var modifiedAfterClause = modifiedAfter.HasValue ? $" and DateModified > '{modifiedAfter}'" : "";
                var productCustomFieldsList =
                    _db.Query<ProductCustomField>($"select * from StockBridge.Product.CustomField where DeleteFlag = 0{modifiedAfterClause}").ToList();
                
                productCustomFieldsList.ForEach(cf =>
                {
                    var idx = productsList.FindIndex(p => p.ID == cf.ProductID);
                    if (idx > -1)
                    {
                        productsList[idx].CustomFields.Add(cf);
                    }
                });
                return productsList;
            });
        }

        public DbResponse<List<int>> UpsertProductCustomFields(List<ProductCustomField> customFields, int activeEmployeeID)
        {
            var paramsList = customFields.Select(cf => new
            {
                @ActiveEmployeeID = activeEmployeeID,
                @ID = cf.ID,
                @DeleteFlag = cf.DeleteFlag,
                @ProductID = cf.ProductID,
                @SystemName = cf.SystemName,
                @FriendlyName = cf.FriendlyName,
                @Value = cf.Value,
                @Description = cf.Description
            }).ToList();
           
            return Upsert("StockBridge.Product.UpsertProductCustomField", paramsList);
        }


        public DbResponse<List<int>> UpsertProducts(List<UpsertProductRequest> products, int activeEmployeeID)
        {
            var paramsList = products.Select(p => new
            {
                @ID = p.ID,
                @ActiveEmployeeID = activeEmployeeID,
                @SKU = p.SKU,
                @Description = p.Description,
                @PartNumber = p.PartNumber,
                @OrderingPartNumber = p.OrderingPartNumber,
                @PrimaryVendorCode = p.PrimaryVendorCode,
                @SecondaryVendorCode = p.SecondaryVendorCode,
                @LastUnitCost = p.LastUnitCost,
                @LocationName = p.LocationName,
                @CasePack = p.CasePack,
                @Length_IN = p.Length_IN,
                @Width_IN = p.Width_IN,
                @Height_IN = p.Height_IN,
                @Weight_OZ = p.Weight_OZ,
                @Minimum = p.Minimum,
                @Maximum = p.Maximum,
                @ShelfCount = p.ShelfCount,
                @Pending = p.Pending,
                @OnOrder = p.OnOrder
            }).ToList();
            var res = Upsert("StockBridge.Product.UpsertProduct",paramsList);

            if (res.Success && res.Data.Count == products.Count)
            {
                //Assign IDs to the new prodcut fields
                for (int i = 0; i < res.Data.Count; i++)
                {
                    products[i].ID = res.Data[i];
                }

                var productsWithCustomFieldsThatHaveAValue =
                    products
                        .Where(v => v.CustomFields.Count > 0)
                        .Where(v => v.CustomFields
                            .All(cf => !string.IsNullOrEmpty(cf.Value)))
                        .ToList();
                if (productsWithCustomFieldsThatHaveAValue.Count > 0)
                {
                    var paramsListCustomFields = new List<dynamic>();

                    productsWithCustomFieldsThatHaveAValue.ForEach(v =>
                        v.CustomFields.ForEach(cf =>
                            paramsListCustomFields.Add(
                                new
                                {
                                    @ActiveEmployeeId = activeEmployeeID,
                                    @ID = cf.ID,
                                    @DeleteFlag = cf.DeleteFlag,
                                    @ProductID = v.ID,
                                    @SystemName = cf.SystemName,
                                    @FriendlyName = cf.FriendlyName,
                                    @Value = cf.Value,
                                    @Description = cf.Description
                                })));
                    return Upsert("StockBridge.Product.UpsertProductCustomField", paramsListCustomFields);
                }
            }
            return res;
        }

        public DbResponse<List<ProductViewSetting>> GetProductViewSettings(int employeeID)
        {
            return Try(db => db.Query<ProductViewSetting>(
                    $"SELECT Field, X, Y, Width, Height, Visible FROM StockBridge.Product.ProductViewSettings WHERE EmployeeID = {employeeID}")
                .ToList());
        }

        public DbResponse<List<int>> UpsertProductViewSettings(List<ProductViewSetting> settings, int activeEmployeeID)
        {
            var paramsList = settings.Select(setting =>
                new
                {
                    @ActiveEmployeeID = activeEmployeeID,
                    @EmployeeID = activeEmployeeID,
                    @Field = setting.Field,
                    @X = setting.X,
                    @Y = setting.Y,
                    @Width = setting.Width,
                    @Height = setting.Height,
                    @Visible = setting.Visible
                }).ToList();
            return Upsert("StockBridge.Product.UpsertProductViewSetting", paramsList);
        }

        public DbResponse<List<int>> DeleteProducts(List<int> productIDs, int activeEmployeeID)
        {
            var res = Try((transaction, db) =>
            {
                return productIDs.Select(id =>
                    db.Query<int>(sql: $"UPDATE StockBridge.Product.Product SET DeleteFlag = 1 WHERE ID = {id}", transaction: transaction)
                        .FirstOrDefault()).ToList();
            });
            return res;
        }
    }
}