using System.Collections.Generic;

namespace StockBridge.Repositories
{
    public class DbResponse<T>
    {
        public T Data { get; set; }
        public bool Success { get; set; } = true;
        public List<string> Errors { get; set; }

        public DbResponse()
        {
            Errors = new List<string>();
        }
    }
}