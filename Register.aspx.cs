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
    public partial class Register : System.Web.UI.Page
    {
        DBconnect db = new DBconnect();
        MySqlConnection con;
        MySqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                // Get connection string from your Utils class
                string connString = Utils.getConnection();

                using (MySqlConnection conn = new MySqlConnection(connString))
                {
                    using (MySqlCommand cmd = new MySqlCommand("sp_RegisterUser", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        // Add Parameters
                        cmd.Parameters.AddWithValue("p_CustomerType", rblCustomerType.SelectedValue);
                        cmd.Parameters.AddWithValue("p_Username", txtUsername.Text.Trim());
                        cmd.Parameters.AddWithValue("p_Password", txtPass.Text.Trim()); // Note: In production, hash this!
                        cmd.Parameters.AddWithValue("p_FullName", txtFullName.Text.Trim());
                        cmd.Parameters.AddWithValue("p_Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("p_Phone", txtPhone.Text.Trim());

                        // Handle Date
                        DateTime dob;
                        if (DateTime.TryParse(txtDOB.Text, out dob))
                            cmd.Parameters.AddWithValue("p_DOB", dob);
                        else
                            cmd.Parameters.AddWithValue("p_DOB", DBNull.Value);

                        cmd.Parameters.AddWithValue("p_Address", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("p_City", txtCity.Text.Trim());
                        cmd.Parameters.AddWithValue("p_State", ddlState.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("p_PinCode", txtPin.Text.Trim());

                        conn.Open();
                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Success','Account created successfully','success')", true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the error (ex.Message)
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Error','Error! record not inserted.. try again','error')", true);
            }
        }
    }
    
}