using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Ecomwebsite.Utilscs;

namespace Ecomwebsite.Admin
{
    public partial class Forget_Pass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

       

        protected void btnSubmitReset_Click(object sender, EventArgs e)
        {

            string user = txtResetUser.Text.Trim();
            string email = txtResetEmail.Text.Trim();
            string newPass = txtNewPass.Text.Trim();

            // Basic validation
            if (string.IsNullOrEmpty(user) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(newPass))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "swal('Error', 'All fields are required!', 'warning');", true);
                return;
            }

            try
            {
                using (MySqlConnection conn = new MySqlConnection(Utils.getConnection()))
                {
                    using (MySqlCommand cmd = new MySqlCommand("sp_ResetPassword", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("p_Username", user);
                        cmd.Parameters.AddWithValue("p_Email", email);
                        cmd.Parameters.AddWithValue("p_NewPassword", newPass);

                        conn.Open();
                        // ExecuteScalar is used because the procedure returns a single value (1 or 0)
                        object result = cmd.ExecuteScalar();

                        if (result != null && result.ToString() == "1")
                        {
                            // Success: Redirect to Loginpage.aspx inside Admin folder
                            string script = "swal('Success', 'Password updated! Redirecting to Login.', 'success').then(function() { window.location='Admin/Loginpage.aspx'; });";
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                        }
                        else
                        {
                            // Failure: Details didn't match
                            string script = "swal('Error', 'Account verification failed. Check Username/Email.', 'error');";
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Clean error message for SweetAlert
                string cleanMessage = ex.Message.Replace("'", "");
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "swal('Database Error', '" + cleanMessage + "', 'error');", true);
            }
        }
    }
    
}