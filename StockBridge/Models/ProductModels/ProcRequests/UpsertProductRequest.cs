using System.Collections.Generic;

namespace StockBridge.Models.ProductModels.ProcRequests
{
    public class UpsertProductRequest
    {
        public int? ID { get; set; }
        public string SKU { get; set; }
        public string Description { get; set; }
        public string PartNumber { get; set; }
        public string OrderingPartNumber { get; set; }
        public string PrimaryVendorCode { get; set; }
        public string SecondaryVendorCode { get; set; }
        public double LastUnitCost { get; set; }
        public string LocationName { get; set; }
        public int CasePack { get; set; }
        public double? Length_IN { get; set; }
        public double? Width_IN { get; set; }
        public double? Height_IN { get; set; }
        public double? Weight_OZ { get; set; }
        public int Minimum { get; set; }
        public int Maximum { get; set; }
        public int? ShelfCount { get; set; }
        public int Pending { get; set; } = 0;
        public int OnOrder { get; set; } = 0;
        public List<GenericCustomField> CustomFields { get; set; }
    }
}