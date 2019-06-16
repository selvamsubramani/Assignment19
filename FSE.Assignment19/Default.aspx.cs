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
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e) { }
        private void LoadGrid()
        {
            var customers = DataConnector.Instance.GetCustomers();
            customerGrid.DataSource = customers;
            customerGrid.DataBind();
        }
        protected void AddCustomer_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddCustomer");
        }
        protected void customerGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            customerGrid.EditIndex = -1;
            LoadGrid();
        }
        protected void customerGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            var id = Convert.ToInt32(e.Values["CustomerId"]);
            DataConnector.Instance.DeleteCustomer(id);
            LoadGrid();
        }
        protected void customerGrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            customerGrid.EditIndex = e.NewEditIndex;
            LoadGrid();
        }
        protected void customerGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Customer customer = new Customer
            {
                CustomerId = Convert.ToInt32(customerGrid.Rows[e.RowIndex].Cells[0].Text),
                CustomerName = $"{e.NewValues["CustomerName"]}",
                Address = $"{e.NewValues["Address"]}",
                Salary = Convert.ToInt32(e.NewValues["Salary"]),
                DOB = Convert.ToDateTime(customerGrid.Rows[e.RowIndex].Cells[2].Text)
            };
            DataConnector.Instance.UpdateCustomer(customer);
            customerGrid.EditIndex = -1;
            LoadGrid();
        }
        protected void loadallcustomers_Click(object sender, EventArgs e)
        {
            LoadGrid();
        }
        protected void loadcustomer_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(customerid.Text))
            {
                var id = Convert.ToInt32(customerid.Text);
                customerGrid.DataSource = new List<Customer> { DataConnector.Instance.GetCustomerById(id) };
                customerGrid.DataBind();
            }
        }
    }
}