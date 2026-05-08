<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site1.Master" AutoEventWireup="true" CodeBehind="viewproduct.aspx.cs" Inherits="Ecomwebsite.Admin.viewproduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h3>Product Details</h3>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4">
                        <asp:Image ID="imgProduct" runat="server" CssClass="img-fluid rounded border" />
                    </div>
                    <div class="col-md-8">
                        <h2 class="font-weight-bold"><asp:Label ID="lblProductName" runat="server" /></h2>
                        <hr />
                        <p class="text-muted">Category: <asp:Label ID="lblCategory" runat="server" /></p>
                        <h4 class="text-success"><asp:Label ID="lblPrice" runat="server" /></h4>
                        <p class="mt-3"><strong>Description:</strong></p>
                        <p><asp:Label ID="lblDescription" runat="server" /></p>
                        
                        <div class="mt-4">
                            <span class="badge badge-info p-2">Stock: <asp:Label ID="lblStock" runat="server" /></span>
                            <span class="badge badge-secondary p-2">Status: <asp:Label ID="lblStatus" runat="server" /></span>
                        </div>
                        
                        <div class="mt-5">
                            <a href="Product.aspx" class="btn btn-outline-secondary">Back to List</a>
                            <asp:Button ID="btnEdit" runat="server" Text="Edit Product" CssClass="btn btn-warning" OnClick="btnEdit_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
