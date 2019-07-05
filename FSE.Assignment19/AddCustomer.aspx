<%@ Page Title="Add Customer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddCustomer.aspx.cs" Inherits="FSE.Assignment19.AddCustomer" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h2 class="panel-title">Add Customer</h2>
            </div>
            <div class="panel-body">

                <div class="form-group form-inline">
                    <label class="control-label col-md-2 col-sm-3">Customer Name</label>
                    <input type="text" id="customername" name="customername" class="form-control" required />
                </div>

                <div class="form-group form-inline">
                    <label class="control-label col-md-2 col-sm-3">Address</label>
                    <input type="text" id="address" name="address" class="form-control" required />
                </div>

                <div class="form-group form-inline">
                    <label class="control-label col-md-2 col-sm-3">Date Of Birth</label>
                    <input type="date" id="dob" name="dob" class="form-control" required />
                </div>

                <div class="form-group form-inline">
                    <label class="control-label col-md-2 col-sm-3">Salary</label>
                    <input type="number" id="salary" name="salary" class="form-control" required />
                </div>

                <div class="form-group form-inline">
                    <div class="col-md-offset-2 col-sm-offset-3 col-md-10 col-sm-9">
                        <input type="submit" value="Create" class="btn btn-primary"
                            runat="server" onserverclick="addcustomerButton_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--<h2>Add Customer</h2>
    <hr />
    <div class="form-horizontal mt-5">
         <div class="form-group">
            <label class="control-label col-md-2">Customer Name</label>
            <input type="text" id="customername" name="customername" class="form-control col-md-10" required />
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
    </div>--%>
</asp:Content>
