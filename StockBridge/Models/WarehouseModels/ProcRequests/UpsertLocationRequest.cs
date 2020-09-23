namespace StockBridge.Models.WarehouseModels.ProcRequests
{
    public class UpsertLocationRequest
    {
        public int? ID { get; set; }
        public int? QuickPick { get; set; }
        public int Aisle { get; set; }
        public string Section { get; set; }
        public int Shelf { get; set; }
        public string Name { get; set; }
        public string CustomName { get; set; }
    }
}