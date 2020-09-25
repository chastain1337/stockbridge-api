using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace StockBridge.Models.ProductModels
{
    public class ProductViewSetting
    {
        public string Field { get; set; }
        public int X { get; set; }
        public int Y { get; set; }
        public int Width { get; set; }
        public int Height { get; set; }
        public bool Visible { get; set; }
        public int EmployeeID { get; set; }
    }
}
