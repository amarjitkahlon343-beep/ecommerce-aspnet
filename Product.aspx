<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site1.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="Ecomwebsite.Admin.Product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <script type="text/javascript">
      function ImagePreview(input) {
          if (input.files && input.files[0]) {
              // Check if the file is an image
              var file = input.files[0];
              var fileType = file["type"];
              var validImageTypes = ["image/gif", "image/jpeg", "image/png", "image/webp"];

              if ($.inArray(fileType, validImageTypes) < 0) {
                  alert("Please select a valid image file (JPG, PNG, WEBP).");
                  input.value = ""; // Clear the input
                  return;
              }

              var reader = new FileReader();
              reader.onload = function (e) {
                  // Get the ID of the file upload control
                  var id = input.id;

                  // Target the specific image control based on which FileUpload was used
                  if (id.includes('FileUploadImg1')) {
                      bindImage('<%=imageProduct1.ClientID%>', e.target.result);
                } else if (id.includes('FileUploadImg2')) {
                    bindImage('<%=imageProduct2.ClientID%>', e.target.result);
                } else if (id.includes('FileUploadImg3')) {
                    bindImage('<%=imageProduct3.ClientID%>', e.target.result);
                } else if (id.includes('FileUploadImg4')) {
                    bindImage('<%=imageProduct4.ClientID%>', e.target.result);
                } else if (id.includes('FileUploadImg5')) {
                    bindImage('<%=imageProduct5.ClientID%>', e.target.result);
                  }
              };
              reader.readAsDataURL(input.files[0]);
          }
      }

      // Helper function to keep code DRY (Don't Repeat Yourself)
      function bindImage(imgControlId, result) {
          var $img = $('#' + imgControlId);
          $img.show();
          $img.attr('src', result);
          $img.css({
              'width': '180px',
              'height': '200px',
              'object-fit': 'cover' // Keeps the image from looking stretched
          });
      }
      $(document).ready(function () {
          // This initializes the multi-select behavior
          $('#<%= listboxSize.ClientID %>').select2({
        placeholder: "Choose sizes...",
        allowClear: true,
        width: '100%' 
    });

    // Repeat for Color if needed
          $('#<%= listboxColor.ClientID %>').select2({
              placeholder: "Choose colors...",
              allowClear: true,
              width: '100%'
          });
      });
  </script>
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="mb-4">
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
    </div>

    <div class="row">
        <div class="col-sm-12 col-md-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title"><b>Product:</b></h4>
                    <hr />
                    <div class="form-body">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="font-weight-bold">Product Name </label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtProductName" runat="server" class="form-control" placeholder="Enter Product name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvProduct" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtProductName" runat="server" ErrorMessage="*Product name is Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                         <div class="col-md-3">
    <label class="font-weight-bold">Category Name </label>
    <div class="form-group">
        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" 
            AutoPostBack="true" 
            OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
            <asp:ListItem Value="0">Select Category</asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvddlcategory" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="ddlCategory" runat="server" ErrorMessage="*Category name is Required" InitialValue="0"></asp:RequiredFieldValidator>
    </div>
</div>

<div class="col-md-3">
    <label class="font-weight-bold">SubCategory </label>
    <div class="form-group">
        <%-- Set AppendDataBoundItems to false here --%>
        <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-control" AppendDataBoundItems="false">
            <asp:ListItem Value="0">Select SubCategory</asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvSubCategory" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="ddlSubCategory" runat="server" ErrorMessage="*SubCategory name is Required" InitialValue="0"></asp:RequiredFieldValidator>
    </div>
</div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label class="font-weight-bold">Price</label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtPrice" runat="server" class="form-control" placeholder="Enter Category name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvtxtprice" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtPrice" runat="server" ErrorMessage="*Product price is Required"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revtxtPrice" runat="server" ErrorMessage="*Product Price is invalid" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ValidationExpression="\d+(?:.\d{1,2})?" ControlToValidate="txtPrice"></asp:RegularExpressionValidator>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <label class="font-weight-bold">Color </label>
                                <div class="form-group">
                                    <asp:ListBox ID="listboxColor" CssClass="form-control" SelectionMode="Multiple" runat="server">
                                        <asp:ListItem Value="1">Blue</asp:ListItem>
                                        <asp:ListItem Value="2">Green</asp:ListItem>
                                        <asp:ListItem Value="3">Orange</asp:ListItem>
                                        <asp:ListItem Value="4">Yellow</asp:ListItem>
                                        <asp:ListItem Value="5">Purple</asp:ListItem>
                                        <asp:ListItem Value="6">Brown</asp:ListItem>
                                        <asp:ListItem Value="7">Gray</asp:ListItem>
                                        <asp:ListItem Value="8">Red</asp:ListItem>
                                        <asp:ListItem Value="9">Black</asp:ListItem>
                                        <asp:ListItem Value="10">Olive</asp:ListItem>
                                        <asp:ListItem Value="11">Maroon</asp:ListItem>
                                        <asp:ListItem Value="12">Violet</asp:ListItem>
                                        <asp:ListItem Value="13">Charcoal </asp:ListItem>
                                        <asp:ListItem Value="14">Magenta </asp:ListItem>
                                        <asp:ListItem Value="15">Bronze </asp:ListItem>
                                        <asp:ListItem Value="16">Cream </asp:ListItem>
                                        <asp:ListItem Value="17">Tan </asp:ListItem>
                                        <asp:ListItem Value="18">Teal </asp:ListItem>
                                        <asp:ListItem Value="19">Mustard </asp:ListItem>
                                        <asp:ListItem Value="20">Navy Blue </asp:ListItem>
                                        <asp:ListItem Value="21">Coral </asp:ListItem>
                                        <asp:ListItem Value="22">Burgundy </asp:ListItem>
                                        <asp:ListItem Value="23">Lavender </asp:ListItem>
                                        <asp:ListItem Value="24">Mauve </asp:ListItem>
                                        <asp:ListItem Value="25">Peach </asp:ListItem>
                                        <asp:ListItem Value="26">Rust </asp:ListItem>
                                        <asp:ListItem Value="27">Gold </asp:ListItem>
                                        <asp:ListItem Value="28">Pink </asp:ListItem>
                                        <asp:ListItem Value="29">Silver </asp:ListItem>
                                        <asp:ListItem Value="30">Cyan </asp:ListItem>
                                        <asp:ListItem Value="31">White </asp:ListItem>
                                        <asp:ListItem Value="32">Indigo </asp:ListItem>
                                        <asp:ListItem Value="33">Turquoise </asp:ListItem>
                                        <asp:ListItem Value="34">Beige </asp:ListItem>
                                        <asp:ListItem Value="35">Salmon </asp:ListItem>
                                        <asp:ListItem Value="36">Khaki </asp:ListItem>
                                        <asp:ListItem Value="37">Plum </asp:ListItem>
                                        <asp:ListItem Value="38">Emerald </asp:ListItem>
                                        <asp:ListItem Value="39">Navy </asp:ListItem>
                                        <asp:ListItem Value="40">Ruby </asp:ListItem>
                                        <asp:ListItem Value="41">Periwinkle </asp:ListItem>
                                        <asp:ListItem Value="42">Orchid </asp:ListItem>
                                        <asp:ListItem Value="43">Rose </asp:ListItem>
                                        <asp:ListItem Value="44">Ivory </asp:ListItem>
                                        <asp:ListItem Value="45">Cobalt </asp:ListItem>
                                        <asp:ListItem Value="46">Slate </asp:ListItem>
                                        <asp:ListItem Value="47">Apricot </asp:ListItem>
                                        <asp:ListItem Value="48">Lilac </asp:ListItem>
                                        <asp:ListItem Value="49"> Sapphire </asp:ListItem>
                                        <asp:ListItem Value="50">Royal Blue </asp:ListItem>
                                        <asp:ListItem Value="51">Baby Pink </asp:ListItem>
                                    </asp:ListBox>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <label class="font-weight-bold">Size </label>
                                <div class="form-group">
                                    <asp:ListBox ID="listboxSize" CssClass="form-control" SelectionMode="Multiple" runat="server">
                                        <asp:ListItem Value="1">XS</asp:ListItem>
                                        <asp:ListItem Value="2">S</asp:ListItem>
                                        <asp:ListItem Value="3">M</asp:ListItem>
                                        <asp:ListItem Value="4">L</asp:ListItem>
                                        <asp:ListItem Value="5">XL</asp:ListItem>
                                        <asp:ListItem Value="6">XXL</asp:ListItem>
                                        <asp:ListItem Value="7">XXXL</asp:ListItem>
                                    </asp:ListBox>
                                    <asp:RequiredFieldValidator ID="rfvsize" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="listboxSize" runat="server" ErrorMessage="*Product size is Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label class="font-weight-bold">Quantity</label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtQty" runat="server" class="form-control" placeholder="Enter Quantity name" TextMode="Number"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvqty" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtQty" runat="server" ErrorMessage="*Product Quantity is Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="font-weight-bold">Company Name</label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtCompanyName" runat="server" class="form-control" placeholder="Enter Quantity name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvcompany" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtCompanyName" runat="server" ErrorMessage="*Company name is Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <label class="font-weight-bold">Short Description</label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtShortDesc" runat="server" class="form-control" placeholder="Enter Short Description"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <label class="font-weight-bold">Long Description</label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtLongDesc" runat="server" class="form-control" placeholder="Enter Product Long Description" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <label class="font-weight-bold">Additional Description</label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtAdditionalDesc" runat="server" class="form-control" placeholder="Enter Product Additional Description" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <label class="font-weight-bold">Tags (Search Keywords)</label>
                                <div class="form-group">
                                    <asp:TextBox ID="txtTags" runat="server" class="form-control" placeholder="Enter Product Search Keywords"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label class="font-weight-bold">Product Image-1</label>
                                <div class="form-group">
                                    <asp:FileUpload ID="FileUploadImg1" runat="server" CssClass="form-control" onchange="ImagePreview(this);"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label class="font-weight-bold">Product Image-2</label>
                                <div class="form-group">
                                    <asp:FileUpload ID="FileUploadImg2" runat="server" CssClass="form-control" onchange="ImagePreview(this);"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label class="font-weight-bold">Product Image-3</label>
                                <div class="form-group">
                                    <asp:FileUpload ID="FileUploadImg3" runat="server" CssClass="form-control" onchange="ImagePreview(this);"></asp:FileUpload>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label class="font-weight-bold">Product Image-4</label>
                                <div class="form-group">
                                    <asp:FileUpload ID="FileUploadImg4" runat="server" CssClass="form-control" onchange="ImagePreview(this);"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="font-weight-bold">Product Image-5</label>
                                <div class="form-group">
                                    <asp:FileUpload ID="FileUploadImg5" runat="server" CssClass="form-control" onchange="ImagePreview(this);"></asp:FileUpload>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label class="font-weight-bold">Default Image</label>
                                <div class="form-group">
                                    <asp:RadioButtonList ID="rblDefaultImage" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="1"> &nbsp; First &nbsp; </asp:ListItem>
                                        <asp:ListItem Value="2"> &nbsp; Second &nbsp; </asp:ListItem>
                                        <asp:ListItem Value="3"> &nbsp; Third &nbsp; </asp:ListItem>
                                        <asp:ListItem Value="4"> &nbsp; Fourth &nbsp; </asp:ListItem>
                                        <asp:ListItem Value="5"> &nbsp; Fifth &nbsp; </asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:HiddenField ID="hfDefaultImage" runat="server" Value="0" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <label class="font-weight-bold">Is Customized</label>
                                <div class="form-group">
                                    <asp:CheckBox ID="IsCBCustomized" runat="server" Text="&nbsp; IsCustomized" />
                                </div>
                            </div>
                            <div class="col-md-3">
                                <label class="font-weight-bold">IsActive</label>
                                <div class="form-group">
                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; IsActive" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 align-content-sm-between pl-3">
                                <span>
                                    <asp:Image ID="imageProduct1" runat="server" CssClass="img-thumbnail" AlternateText=""></asp:Image>
                                </span>
                                <span>
                                    <asp:Image ID="imageProduct2" runat="server" CssClass="img-thumbnail" AlternateText=""></asp:Image>
                                </span>
                                <span>
                                    <asp:Image ID="imageProduct3" runat="server" CssClass="img-thumbnail" AlternateText=""></asp:Image>
                                </span>
                                <span>
                                    <asp:Image ID="imageProduct4" runat="server" CssClass="img-thumbnail" AlternateText=""></asp:Image>
                                </span>
                                <span>
                                    <asp:Image ID="imageProduct5" runat="server" CssClass="img-thumbnail" AlternateText=""></asp:Image>
                                </span>
                            </div>
                        </div>

                        <%--<label class="font-weight-bold">Category Image </label>
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
                        </div>--%>
                    </div>
                      <div class="form-actiona pb-4">
                        <div class="text-left">
                            <asp:Button ID="btnAddOrUpdate" runat="server" Text="Add" CssClass="btn btn-info" OnClick="btnAddOrUpdate_Click" />
                            <asp:Button ID="btnClear" runat="server" Text="Reset" CssClass="btn btn-danger" CausesValidation="false" OnClick="btnClear_Click" />
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        // 1. Define the function to initialize Select2
        function initSelect2() {
            $('#<%= listboxSize.ClientID %>').select2({
            placeholder: "Choose sizes...",
            allowClear: true,
            width: '100%'
        });

        $('#<%= listboxColor.ClientID %>').select2({
                placeholder: "Choose colors...",
                allowClear: true,
                width: '100%'
            });
        }

        // 2. Run on first page load
        $(document).ready(function () {
            initSelect2();
        });

        // 3. Run after every UpdatePanel refresh (Partial Postback)
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm) {
            prm.add_endRequest(function () {
                initSelect2();
            });
        }
    </script>
</asp:Content>


