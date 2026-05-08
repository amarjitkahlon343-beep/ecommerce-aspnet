<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Forget Pass.aspx.cs" Inherits="Ecomwebsite.Admin.Forget_Pass" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>

    <title>SB Admin 2 - Forgot Password</title>

   
         <link href="../AdminTemplate/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css"/>
<link href="../AdminTemplate/css/sb-admin-2.min.css" rel="stylesheet"/>
    <link href="../bundles/jquery.dataTables.min.css" rel="stylesheet" />
   <script src="../AdminTemplate/vendor/jquery/jquery.min.js"></script>
<script src="../AdminTemplate/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../AdminTemplate/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="../AdminTemplate/js/sb-admin-2.min.js"></script>

</head>
<body>
    <form id="form1" runat="server">
      
  
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-xl-6 col-lg-7 col-md-9">
                <div class="card shadow-lg my-5">
                    <div class="card-body p-5">
                        <div class="text-center">
                            <h1 class="h4 text-gray-900 mb-4">Reset Your Password</h1>
                        </div>

                        <div class="user">
                            <div class="form-group mb-3">
                                <label class="small">Username</label>
                                <asp:TextBox ID="txtResetUser" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
                            </div>

                            <div class="form-group mb-3">
                                <label class="small">Email Address</label>
                                <asp:TextBox ID="txtResetEmail" runat="server" CssClass="form-control" placeholder="Registered Email" TextMode="Email"></asp:TextBox>
                            </div>

                            <hr />

                            <div class="form-group mb-3">
                                <label class="small">New Password</label>
                                <asp:TextBox ID="txtNewPass" runat="server" CssClass="form-control" TextMode="Password" placeholder="New Password"></asp:TextBox>
                            </div>

                            <div class="form-group mb-4">
                                <label class="small">Confirm New Password</label>
                                <asp:TextBox ID="txtConfirmPass" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm Password"></asp:TextBox>
                                <asp:CompareValidator ID="cvPass" runat="server" ControlToCompare="txtNewPass" ControlToValidate="txtConfirmPass" 
                                    ErrorMessage="Passwords do not match!" ForeColor="Red" Display="Dynamic" />
                            </div>

                            <asp:Button ID="btnSubmitReset" runat="server" Text="Update Password" 
                                CssClass="btn btn-success btn-block w-100" OnClick="btnSubmitReset_Click" />
                        </div>

                        <hr>
                        <div class="text-center">
                            <a class="small" href="login.aspx">Back to Login</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
    </form>
</body>
</html>
