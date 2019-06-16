<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FSE.Assignment19._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Customers</h2>
    <hr />
    <table class="table">
        <tr>
            <td> <asp:Button ID="addcustomerButton" runat="server" Text="Add Customer" 
                    PostBackUrl="~/AddCustomer.aspx" CssClass="btn btn-primary btn-block col-2" /></td>
            <td> <asp:Button ID="loadallcustomers" runat="server" Text="Load All Customer" 
                    CssClass="btn btn-primary btn-block col-2" OnClick="loadallcustomers_Click" /></td>
            <td>
                <div class="form-group col-5">
                    <asp:TextBox ID="customerid" runat="server" CssClass="form-control col-2"></asp:TextBox>
                    <asp:Button ID="loadcustomer" runat="server" Text="Search" CssClass="btn btn-primary btn-block" OnClick="loadcustomer_Click" />
                </div>
            </td>
        </tr>
    </table>
    <asp:GridView ID="customerGrid" runat="server" AutoGenerateColumns="False"
        OnRowCancelingEdit="customerGrid_RowCancelingEdit" OnRowDeleting="customerGrid_RowDeleting"
        OnRowEditing="customerGrid_RowEditing"
        EmptyDataText="No records has been added." OnRowUpdating="customerGrid_RowUpdating">
        <Columns>
            <asp:BoundField DataField="CustomerId" HeaderText="Customer ID" ReadOnly="True" />
            <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" />
            <asp:BoundField DataField="DOB" HeaderText="Date Of Birth" ReadOnly="True" />
            <asp:BoundField DataField="Address" HeaderText="Address" />
            <asp:BoundField DataField="Salary" HeaderText="Salary" />
            <asp:CommandField ButtonType="Button" ShowEditButton="True" />
            <asp:CommandField ButtonType="Button" ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>
</asp:Content>