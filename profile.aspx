<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="Ecomwebsite.Admin.profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>

    <title>SB Admin 2 - profile</title>

   
      <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet"/>
    
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
<div class="main-content">
        <div class="container-fluid mt-4">
            <div class="card bg-secondary shadow">
                <div class="card-header bg-white border-0">
                                         <a href="Dashboardaspx.aspx" class="btn btn-secondary">
                      <i class="bi bi-arrow-left-circle"></i> Return to Dashboard
                            </a>
                    <h3 class="mb-0">My Profile</h3>

                </div>
                <div class="card-body">
                    <h6 class="heading-small text-muted mb-4">Basic Information</h6>
                    <div class="pl-lg-4">
                        <div class="row">
                            <div class="col-lg-4">
                                <label class="form-control-label">Username</label>
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="col-lg-4">
                                <label class="form-control-label">Full Name</label>
                                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-lg-4">
                                <label class="form-control-label">Date of Birth</label>
                                <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <hr class="my-4">

                    <h6 class="heading-small text-muted mb-4">Contact Information</h6>
                    <div class="pl-lg-4">
                        <div class="row">
                            <div class="col-lg-6">
                                <label class="form-control-label">Email Address</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                            </div>
                            <div class="col-lg-6">
                                <label class="form-control-label">Phone Number</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <hr class="my-4">

                    <h6 class="heading-small text-muted mb-4">Address Details</h6>
                    <div class="pl-lg-4">
                        <div class="row">
                            <div class="col-md-12">
                                <label class="form-control-label">Street Address</label>
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-lg-4">
                                <label class="form-control-label">City</label>
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-lg-4">
                                <label class="form-control-label">State</label>
                                <asp:TextBox ID="txtState" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-lg-4">
                                <label class="form-control-label">Pin Code</label>
                                <asp:TextBox ID="txtPinCode" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="text-right mt-4">
                        <asp:Button ID="btnSaveChanges" runat="server" Text="Update Profile" CssClass="btn btn-success" OnClick="btnSaveChanges_Click1" />
                    </div>
                </div>
            </div>
        </div>
    </div>
        </form>
</body>
    </html>
