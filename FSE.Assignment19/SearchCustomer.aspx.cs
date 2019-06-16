using FSE.Assignment19.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FSE.Assignment19
{
    public partial class SearchCustomer : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Search_Click(object sender, EventArgs e)
        {
            var date = Convert.ToDateTime(Page.Request.Form["date"]);
            customergridview.DataSource = DataConnector.Instance.GetCustomerBornAfterDate(date);
            customergridview.DataBind();
        }
    }
}