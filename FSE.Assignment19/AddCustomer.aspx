<%@ Page Title="Add Customer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddCustomer.aspx.cs" Inherits="FSE.Assignment19.AddCustomer" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Add Customer</h2>
    <hr />
    <div class="form-horizontal mt-5">
        <div class="form-group">
            <label class="control-label col-md-2">Customer Name</label>
            <input type="text" id="customername" name="customername" class="form-class col-md-10" required />
        </div>

        <div class="form-group">
            <label class="control-label col-md-2">Address</label>
            <input type="text" id="address" name="address" class="form-class col-md-10" required />
        </div>

        <div class="form-group">
            <label class="control-label col-md-2">Date Of Birth</label>
            <input type="date" id="dob" name="dob" class="form-class col-md-10" required />
        </div>

        <div class="form-group">
            <label class="control-label col-md-2">Salary</label>
            <input type="number" id="salary" name="salary" class="form-class input col-md-10" required />
        </div>

        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <input type="submit" value="Create" class="btn btn-primary" 
                    runat="server" onserverclick="addcustomerButton_Click" />
            </div>
        </div>
    </div>
</asp:Content>
