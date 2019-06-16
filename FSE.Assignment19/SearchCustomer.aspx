<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchCustomer.aspx.cs" Inherits="FSE.Assignment19.SearchCustomer" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Customers</h2>
    <h3>Search Customer</h3>

    <div class="form-horizontal mt-5 container">
        <div class="form-group col-md-10">
            <input type="date" id="date" name="date" class="form-control col-md-3" required />
            <input type="button" id="search" name="search" value="Search" class="btn btn-primary btn-block"
                runat="server" onserverclick="Search_Click" />
        </div>
    </div>
    <asp:GridView ID="customergridview" runat="server"></asp:GridView>
</asp:Content>
