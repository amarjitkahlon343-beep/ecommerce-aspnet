<%@ Page Title="" Language="C#" MasterPageFile="~/User/Site1.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Ecomwebsite.User.login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script>
        window.onload = function () {
            var specialLink = document.getElementById("loginLink");
            if (specialLink) {
                specialLink.style.display = "none";
            }
        };
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
       <div class="container-fluid">
       <div class="container" style="border: 2px solid black">
           <div class="col-lg-12 d-flex justify-content-center align-items-center right-side border:1">
               <div class="card shadow p-4" style="width: 100%; max-width: 600px;">
                   <h3 class="text-center mb-4">Welcome Back!</h3>

                   <div class="mb-3">
                       <label for="email" class="form-label">Email address</label>
                       <asp:TextBox ID="txtemail" class="form-control" placeholder="Enter your email" runat="server" TextMode="Email"></asp:TextBox>

                   </div>
                   <div class="mb-3">
                       <label for="password" class="form-label">Password</label>

                       <asp:TextBox ID="txtpassword" class="form-control" placeholder="Enter your password" runat="server" TextMode="Password"></asp:TextBox>
                   </div>
                   <div class="d-flex justify-content-between align-items-center mb-3">
                       <div class="form-check">
                           <asp:CheckBox ID="CheckBoxremember" class="form-check-input" runat="server" />
                           <label class="form-check-label" for="remember">Remember me</label>
                       </div>
                       <a href="#" class="text-decoration-none">Forgot password?</a>
                   </div>

                   <asp:Button ID="btnlogin" class="btn btn-primary w-100" runat="server" Text="Login" />

                   <div class="text-center mt-3">
                       <p class="mb-0">Don't have an account? <a href="register.aspx" class="text-decoration-none">Sign up</a></p>
                   </div>
               </div>
           </div>
       </div>

   </div>
</asp:Content>
