<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site1.Master" AutoEventWireup="true" CodeBehind="vieworder.aspx.cs" Inherits="Ecomwebsite.Admin.view_order" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
           <h2>Customer Orders</h2>
<hr />
<asp:Repeater ID="rptOrders" runat="server">
    <HeaderTemplate>
        <table class="table table-hover border">
            <thead class="table-dark">
                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Date</th>
                    <th>Total Amount</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td>#<%# Eval("OrderID") %></td>
            <td><%# Eval("CustomerName") %></td>
            <td><%# Eval("OrderDate", "{0:dd-MMM-yyyy}") %></td>
            <td>₹<%# Eval("TotalAmount") %></td>
            <td>
                <span class="badge <%# GetStatusClass(Eval("Status").ToString()) %>">
                    <%# Eval("Status") %>
                </span>
            </td>
            <td>
                <a href="OrderDetails.aspx?id=<%# Eval("OrderID") %>" class="btn btn-sm btn-info">View Details</a>
            </td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
         
    </FooterTemplate>
</asp:Repeater>

</asp:Content>


