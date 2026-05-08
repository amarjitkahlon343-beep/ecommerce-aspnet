<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site1.Master" AutoEventWireup="true" CodeBehind="Category.aspx.cs" Inherits="Ecomwebsite.Admin.Category" %>
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
                    <h4 class="card-title"><b>Category:</b></h4>
                    <hr />
                    <div class="form-body">
                        <label class="font-weight-bold">Category Name </label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtCategoryName" runat="server" class="form-control" placeholder="Enter Category name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvCategory" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtCategoryName" runat="server" ErrorMessage="*Category name is Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <label class="font-weight-bold">Category Image </label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:FileUpload ID="FUCategoryImage" runat="server" CssClass="form-control" onchange="ImagePreview(this);"></asp:FileUpload>
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
                    <div>
                        <asp:Image ID="ImagePreview" runat="server" CssClass="img-thumbnail"></asp:Image>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-sm-12 col-md-8">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title"><b>Category List:</b></h4>
                    <hr />
                    <div class="table-responsive">
                        <asp:Repeater ID="rptCategory" runat="server" OnItemCommand="rptCategory_ItemCommand">
                           <HeaderTemplate>
    <table class="table data-table-export table-hover nowrap" style="width:100%">
        <thead>
            <tr>
                <th>Name</th>
                <th>Image</th>
                <th>IsActive</th>
                <th>Created Date</th>
                <th class="no-export">Action</th> 
            </tr>
        </thead>
        <tbody>
</HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="table-plus"><%#Eval("CategoryName") %></td>
                                    <td>
                                      <img src='<%#  Ecomwebsite.Utilscs.Utils.getImageUrl(Eval("CategoryImageUrl")) %>' 
                                           width="40" 
                                          alt="category image" 
                                            class="fixed-size-img" />                                       
                                    </td>
                                    <td>
                                  <span class='<%# Convert.ToBoolean(Eval("IsActive")) ? "badge badge-success" : "badge badge-danger" %>'>
                                       <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "In-Active" %>
                                     </span>
                                   </td>

                                    <td><%#Eval("CreatedDate","{0:dddd, dd/MM/yyyy}") %></td>
                                    

                                    <td>
                                        <asp:LinkButton ID="linkbtnEdit" runat="server" CssClass="badge badge-primary" CommandArgument='<%#Eval("CategoryID")%>' CommandName="Edit" CausesValidation="false">
                                            <i class="fas fa-edit"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="linkbtnDelete" runat="server" CssClass="badge badge-danger" CommandArgument='<%#Eval("CategoryID")%>' CommandName="Delete" CausesValidation="false">
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
