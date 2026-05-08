<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Ecomwebsite.Admin.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
<meta name="description" content=""/>
<meta name="author" content=""/>

<title>SB Admin 2 - Register</title>
     <link href="../AdminTemplate/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css"/>
<link href="../AdminTemplate/css/sb-admin-2.min.css" rel="stylesheet"/>
    <link href="../bundles/jquery.dataTables.min.css" rel="stylesheet" />
   <script src="../AdminTemplate/vendor/jquery/jquery.min.js"></script>
<script src="../AdminTemplate/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../AdminTemplate/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="../AdminTemplate/js/sb-admin-2.min.js"></script>
    <link href="../sweet%20alert/sweetalert.css" rel="stylesheet" />
    <script src="../sweet%20alert/sweetalert-dev.js"></script>
</head>
<body>
    <form id="form1" runat="server">
   <nav class="navbar navbar-expand-sm navbar-dark bg-dark">
    <a class="navbar-brand" href="Default.aspx">
        <img src="../AdminTemplate/img/undraw_profile.svg" alt="logo" width="49" height="49" /> 
        <strong>MegaShop</strong>
    </a>
    <div class="collapse navbar-collapse" id="collapsibleNavbar">
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link" href="Dashboardaspx.aspx">Home</a></li>
            <li class="nav-item"><a class="nav-link" href="#">Categories</a></li>
            <li class="nav-item"><a class="nav-link" href="#">Deals</a></li>
            <li class="nav-item"><a class="nav-link" href="#">Customer Service</a></li>
        </ul>
    </div>
    <div class="pmd-navbar-right-icon ml-auto">
        <a class="btn btn-sm btn-outline-light" href="login.aspx">Sign In</a>
    </div>
</nav>

<div class="jumbotron text-center bg-success border-bottom" style="margin-bottom: 0; padding: 2rem;">
    <h1 class="display-4">Join MegaShop Today</h1>
    <p class="lead">Create an account to track orders, save favorites, and get exclusive discounts!</p>
</div>

<div class="container-fluid mt-4">
    <div class="row">
        <div class="col-sm-2 border-right">         
            <h5 class="mt-3">Why Join Us?</h5>
            <ul class="nav flex-column small">
                <li class="nav-item mb-2">✅ Free Shipping on first order</li>
                <li class="nav-item mb-2">✅ Early access to Sales</li>
                <li class="nav-item mb-2">✅ Easy 30-day returns</li>
            </ul>
            <hr />
        </div>

        <div class="col-sm-10"> 
            <div class="container">
                <h3 class="text-center mb-4">Create Your Account</h3>
                
                <div class="row justify-content-center mb-4">
                    <div class="col-md-6 text-center">
                        <label class="d-block mb-2">I am shopping for:</label>
                        <asp:RadioButtonList ID="rblCustomerType" runat="server" 
                            RepeatDirection="Horizontal" 
                            CssClass="mx-auto" 
                            AutoPostBack="true">
                            <asp:ListItem Text="Personal Use" Value="Individual" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Business/Wholesale" Value="Business"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>

                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">Username</label>
                        <asp:TextBox ID="txtUsername" CssClass="form-control" placeholder="Choose a username" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUser" runat="server" ErrorMessage="* Required" ControlToValidate="txtUsername" ForeColor="Red" Display="Dynamic" />
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Password</label>
                        <asp:TextBox ID="txtPass" CssClass="form-control" placeholder="••••••••" TextMode="Password" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPass" runat="server" ErrorMessage="* Required" ControlToValidate="txtPass" ForeColor="Red" Display="Dynamic" />
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Full Name</label>
                        <asp:TextBox ID="txtFullName" CssClass="form-control" placeholder="John Doe" runat="server"></asp:TextBox>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Email Address</label>
                        <asp:TextBox ID="txtEmail" CssClass="form-control" TextMode="Email" placeholder="email@example.com" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="Invalid Email" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red" Display="Dynamic" />
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Phone Number</label>
                        <asp:TextBox ID="txtPhone" CssClass="form-control" placeholder="+91..." runat="server"></asp:TextBox>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Date of Birth (Optional)</label>
                        <asp:TextBox ID="txtDOB" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                    </div>

                    <div class="col-md-12 mt-4">
                        <h5>Shipping Address</h5>
                        <hr />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Street Address</label>
                        <asp:TextBox ID="txtAddress" CssClass="form-control" placeholder="House No, Street, Landmark" runat="server"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
                        <label class="form-label">City</label>
                        <asp:TextBox ID="txtCity" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>

                    <div class="col-md-2">
            <label class="form-label">State</label>
  <asp:DropDownList ID="ddlState" runat="server" CssClass="form-select">
    <asp:ListItem Text="-- Select State --" Value="0" />
    <asp:ListItem>Andhra Pradesh</asp:ListItem>
    <asp:ListItem>Arunachal Pradesh</asp:ListItem>
    <asp:ListItem>Assam</asp:ListItem>
    <asp:ListItem>Bihar</asp:ListItem>
    <asp:ListItem>Chhattisgarh</asp:ListItem>
    <asp:ListItem>Goa</asp:ListItem>
    <asp:ListItem>Gujarat</asp:ListItem>
    <asp:ListItem>Haryana</asp:ListItem>
    <asp:ListItem>Himachal Pradesh</asp:ListItem>
    <asp:ListItem>Jharkhand</asp:ListItem>
    <asp:ListItem>Karnataka</asp:ListItem>
    <asp:ListItem>Kerala</asp:ListItem>
    <asp:ListItem>Madhya Pradesh</asp:ListItem>
    <asp:ListItem>Maharashtra</asp:ListItem>
    <asp:ListItem>Manipur</asp:ListItem>
    <asp:ListItem>Meghalaya</asp:ListItem>
    <asp:ListItem>Mizoram</asp:ListItem>
    <asp:ListItem>Nagaland</asp:ListItem>
    <asp:ListItem>Odisha</asp:ListItem>
    <asp:ListItem>Punjab</asp:ListItem>
    <asp:ListItem>Rajasthan</asp:ListItem>
    <asp:ListItem>Sikkim</asp:ListItem>
    <asp:ListItem>Tamil Nadu</asp:ListItem>
    <asp:ListItem>Telangana</asp:ListItem>
    <asp:ListItem>Tripura</asp:ListItem>
    <asp:ListItem>Uttar Pradesh</asp:ListItem>
    <asp:ListItem>Uttarakhand</asp:ListItem>
    <asp:ListItem>West Bengal</asp:ListItem>
    <asp:ListItem>Andaman and Nicobar Islands</asp:ListItem>
    <asp:ListItem>Chandigarh</asp:ListItem>
    <asp:ListItem>Dadra and Nagar Haveli and Daman and Diu</asp:ListItem>
    <asp:ListItem>Delhi</asp:ListItem>
    <asp:ListItem>Jammu and Kashmir</asp:ListItem>
    <asp:ListItem>Ladakh</asp:ListItem>
    <asp:ListItem>Lakshadweep</asp:ListItem>
    <asp:ListItem>Puducherry</asp:ListItem>
</asp:DropDownList>
</div>
                    </div>

                    <div class="col-md-2">
                        <label class="form-label">Pin Code</label>
                        <asp:TextBox ID="txtPin" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>

                    <div class="col-12 mt-3">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="chkNewsletter"/>
                            <label class="form-check-label" for="chkNewsletter">
                                Send me updates about new arrivals and special offers.
                            </label>
                        </div>
                    </div>

                    <div class="text-center mt-4">
                        <asp:Button ID="btnRegister" CssClass="btn btn-warning btn-lg px-5 font-weight-bold" runat="server" Text="Create My Account" OnClick="btnRegister_Click" />
                    </div>

                    <div class="text-center mt-3 mb-5">
                        <p>Already have an account? <a href="login.aspx" class="text-primary">Sign In here</a></p>
                        <a href="Default.aspx" class="text-muted small">&laquo; Return to Shopping</a>
                    </div>
                </div>
            </div>
        </div> 
    </div>
</div>

<footer class="bg-dark text-white pt-5 pb-3">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h6>Customer Care</h6>
                <ul class="list-unstyled small">
                    <li><a href="#" class="text-white-50">Track Order</a></li>
                    <li><a href="#" class="text-white-50">Return Policy</a></li>
                    <li><a href="#" class="text-white-50">Shipping Info</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h6>About MegaShop</h6>
                <ul class="list-unstyled small">
                    <li><a href="#" class="text-white-50">Careers</a></li>
                    <li><a href="#" class="text-white-50">Privacy Policy</a></li>
                    <li><a href="#" class="text-white-50">Terms of Use</a></li>
                </ul>
            </div>
            <div class="col-md-4 text-center">
                <h6>Follow Our Socials</h6>
                <div class="mt-2">
                    <a href="#" class="text-white mr-3"><i class="fab fa-facebook fa-lg"></i></a>
                    <a href="#" class="text-white mr-3"><i class="fab fa-instagram fa-lg"></i></a>
                    <a href="#" class="text-white"><i class="fab fa-twitter fa-lg"></i></a>
                </div>
            </div>
        </div>
        <hr class="bg-secondary" />
        <p class="text-center small text-white-50">&copy; 2026 MegaShop Retail Pvt. Ltd. All rights reserved.</p>
    </div>
</footer>
    </form>
</body>
</html>
