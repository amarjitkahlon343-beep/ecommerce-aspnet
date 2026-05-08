<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site1.Master" AutoEventWireup="true" CodeBehind="customer.aspx.cs" Inherits="Ecomwebsite.Admin.customer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid px-4 mt-4">
        <div class="card shadow mb-4">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h5 class="m-0"><i class="fas fa-users me-2"></i>Customer Directory</h5>
              <%--  <a href="AddCustomer.aspx" class="btn btn-light btn-sm">Add New Customer</a>--%>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <asp:Repeater ID="rptCustomers" runat="server">
                        <HeaderTemplate>
                            <table class="table table-hover table-bordered" id="customerTable">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Mobile</th>
                                        <th>City</th>
                                        <th>Joined Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>#<%# Eval("CustomerID") %></td>
                                <td class="fw-bold"><%# Eval("FullName") %></td>
                                <td><%# Eval("Email") %></td>
                                <td><%# Eval("Mobile") %></td>
                                <td><%# Eval("City") %></td>
                                <td><%# Eval("RegDate", "{0:dd MMM yyyy}") %></td>
                                <td>
              


                                    <%--  <asp:LinkButton ID="btnedit"  runat="server" class="btn btn-sm btn-outline-primary" Onclick="btnedit_Click" ><i class="fas fa-edit"></asp:LinkButton>
                                    <a href='EditCustomer.aspx?id=<%# Eval("CustomerID") %>' class="btn btn-sm btn-outline-primary" Onclick="" ><i class="fas fa-edit"> </i></a>
                                    <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-sm btn-outline-danger" Onclick="btnDelete_Click"><i class="fas fa-trash"></i></asp:LinkButton>--%>
                                </td>
                            </tr>
                          
                        </ItemTemplate>
                        <FooterTemplate>
                                </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
</asp:Content>