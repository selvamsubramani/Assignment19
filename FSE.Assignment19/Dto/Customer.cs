using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FSE.Assignment19.Dto
{
    public class Customer
    {
        public int CustomerId { get; set; }
        public string CustomerName { get; set; }
        public string Address { get; set; }
        public DateTime DOB { get; set; }
        public int Salary { get; set; }
    }
}