<%@ Page Title="" Language="C#" MasterPageFile="~/User/Site1.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="Ecomwebsite.User.register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
            <script>
                window.onload = function () {
                    var specialLink = document.getElementById("registerLink");
                    if (specialLink) {
                        specialLink.style.display = "none";
                    }
                };
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
       <div class="container-fluid">
       <div class="row h-100">
           <!-- Right Side: Registration Form -->
           <div class="col-lg-12 d-flex justify-content-center align-items-center right-side">
               <div class="card shadow p-4" style="width: 100%; max-width: 600px;">
                   <h3 class="text-center mb-4">Create an Account</h3>
                   <!-- Full Name -->
                   <div class="mb-3">
                       <label for="name" class="form-label font-weight-bold" >Full Name</label>
                       <asp:TextBox ID="txtfullname" class="form-control" placeholder="Enter your full name" runat="server" focus="true" ></asp:TextBox>
                   </div>

                   <!-- UserName Address -->
                   <div class="mb-3">
                       <label for="username" class="form-label font-weight-bold">UserName</label>
                       <asp:TextBox ID="txtUsername" class="form-control" placeholder="Enter your username" runat="server"></asp:TextBox>
                   </div>

                   <!-- Email Address -->
                   <div class="mb-3">
                       <label for="email" class="form-label font-weight-bold">Email Address</label>
                       <asp:TextBox ID="txtemail" class="form-control" placeholder="Enter your email" runat="server" TextMode="Email"></asp:TextBox>
                   </div>

                   <!-- Phone Number -->
                   <div class="mb-3">
                       <label for="phone" class="form-label font-weight-bold">Phone Number</label>                        
                        <asp:TextBox ID="txtPhone" class="form-control" placeholder="Enter your Phone Number" runat="server" ></asp:TextBox>
                   </div>

                   <!-- Password -->
                   <div class="mb-3">
                       <label for="password" class="form-label font-weight-bold">Password</label>                        
                       <asp:TextBox ID="txtpassword" class="form-control" placeholder="Enter your password" runat="server" TextMode="Password"></asp:TextBox>
                   </div>

                   <!-- Confirm Password -->
                   <div class="mb-3">
                       <label for="confirm-password" class="form-label font-weight-bold">Confirm Password</label>
                       <asp:TextBox ID="txtConfirmPassword" class="form-control" placeholder="Confirm your password" runat="server" TextMode="Password"></asp:TextBox>
                   </div>

                   <!-- Terms and Conditions -->
                   <div class="mb-3 form-check">
                       <input type="checkbox" class="form-check-input font-weight-bold" id="terms" required>
                       <label class="form-check-label" for="terms">
                           I agree to the <a href="#" class="text-decoration-none">Terms & Conditions</a>
                       </label>
                   </div>

                   <!-- Submit Button -->                    
                   <asp:Button ID="btnRegister" class="btn btn-info w-100" runat="server" Text="Register" />

                   <div class="text-center mt-3">
                       <p class="mb-0">Already have an account? <a href="login.aspx" class="text-decoration-none">Login</a></p>
                   </div>
               </div>
           </div>
       </div>
   </div>
</asp:Content>
