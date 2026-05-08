<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site1.Master" AutoEventWireup="true" CodeBehind="SubCategory.aspx.cs" Inherits="Ecomwebsite.Admin.SubCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mb-4">
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
    </div>

    <div class="row">
        <div class="col-sm-12 col-md-4">
            <div class="card">
                <div class="card-body">
                    <%--<h4 class="card-title"></h4>--%>
                    <h4 class="card-title"><b>SubCategory:</b></h4>
                    <hr />
                    <div class="form-body">
                        <label class="font-weight-bold">SubCategory Name </label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtSubCategoryName" runat="server" class="form-control" placeholder="Enter Category name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvCategory" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtSubCategoryName" runat="server" ErrorMessage="*Category name is Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <label class="font-weight-bold">Category: </label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:DropDownList ID="ddlCategory" runat="server" AppendDataBoundItems="true" CssClass="form-control">
                                        <%-- <asp:ListItem Value="0">Select Category</asp:ListItem>--%>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="rfvddlcategory" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="ddlCategory" runat="server" ErrorMessage="*Category name is Required" InitialValue="0"></asp:RequiredFieldValidator>
                                    <asp:HiddenField ID="hfCategoryID" runat="server" Value="0" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; IsActive" />
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="form-actiona pb-5">
                        <div class="text-left">
                            <asp:Button ID="btnAddOrUpdate" runat="server" Text="Add" CssClass="btn btn-info" OnClick="btnAddOrUpdate_Click" />
                            <asp:Button ID="btnClear" runat="server" Text="Reset" CssClass="btn btn-danger" OnClick="btnClear_Click" />
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="col-sm-12 col-md-8">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title"><b>SubCategory List:</b></h4>
                    <hr />
                    <div class="table-responsive">
                        <asp:Repeater ID="rptSubCategory" runat="server" OnItemCommand="rptSubCategory_ItemCommand">
                            <HeaderTemplate>
                                <table class="table data-table-export table-hover nowrap" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th class="table-plus">SubCategory</th>
                                            <th>Category</th>
                                            <th>IsActive</th>
                                            <th>Created Date</th>
                                            <th class="dataTable-nosort">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="table-plus"><%#Eval("SubCategoryName") %></td>
                                    <td>
                                        <%#Eval("CategoryName") %>
                                    </td>
                                    <td>
                                  <span class='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge badge-success" : "badge badge-danger" %>'>
                                       <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "In-Active" %>
                                     </span>
                                   </td>
                            

                                    <td><%#Eval("CreatedDate","{0:dddd, dd/MM/yyyy}") %></td>


                                    <td>
                                        <asp:LinkButton ID="linkbtnEdit" runat="server" CssClass="badge badge-primary" CommandArgument='<%#Eval("SubCategoryID")%>' CommandName="Edit" CausesValidation="false">
                                         <i class="fas fa-edit"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="linkbtnDelete" runat="server" CssClass="badge badge-danger" CommandArgument='<%#Eval("SubCategoryID")%>' CommandName="Delete" CausesValidation="false">
                                         <i class="fas fa-trash-alt"></i>
                                        </asp:LinkButton>
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

    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.data-table-export').DataTable({
                "destroy": true, // Critical if using UpdatePanels
                dom: 'Bfrtip',   // B = Buttons, f = search, r = processing, t = table, i = info, p = pagination
                buttons: [
                    { extend: 'copy', className: 'btn btn-primary btn-sm' },
                    { extend: 'csv', className: 'btn btn-success btn-sm' },
                    { extend: 'pdf', className: 'btn btn-danger btn-sm' },
                    { extend: 'print', className: 'btn btn-info btn-sm' }
                ]
            });
        });
    </script>
</asp:Content>
