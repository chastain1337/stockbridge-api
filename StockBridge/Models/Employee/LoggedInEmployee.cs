namespace StockBridge.Models.Employee
{
    public class LoggedInEmployee
    {
        public int ID { get; }
        public string FirstName { get; }
        public string LastName { get; }
        public string UserName { get; }
        public string Token { get; }

        public LoggedInEmployee(Employee employee, string token)
        {
            ID = employee.ID;
            UserName = employee.UserName;
            FirstName = employee.FirstName;
            LastName = employee.LastName;
            Token = token;
        }
    }
}