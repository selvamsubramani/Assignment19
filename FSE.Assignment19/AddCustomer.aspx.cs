using FSE.Assignment19.Dto;
using FSE.Assignment19.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FSE.Assignment19
{
    public partial class AddCustomer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void addcustomerButton_Click(object sender, EventArgs e)
        {
            Customer customer = new Customer
            {
                CustomerName = Page.Request.Form["customername"],
                Address = Page.Request.Form["address"],
                DOB = Convert.ToDateTime(Page.Request.Form["dob"]),
                Salary = Convert.ToInt32(Page.Request.Form["salary"])
            };
            DataConnector.Instance.AddCustomer(customer);
            Response.Redirect("Default");
        }
    }
}