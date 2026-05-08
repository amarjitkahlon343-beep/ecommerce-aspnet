using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Ecomwebsite.Utilscs;

namespace Ecomwebsite.Admin
{
    public partial class profile : System.Web.UI.Page
    {
        string strcon = Utils.getConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)// The ~/ starts at the root, then goes into the Admin folder
                Response.Redirect("~/Admin/login.aspx");

            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            using (MySqlConnection con = new MySqlConnection(strcon))
            {
                MySqlCommand cmd = new MySqlCommand("sp_GetUserProfile", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("p_UserId", Session["UserId"]);

                con.Open();
                MySqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtUsername.Text = dr["Username"].ToString();
                    txtFullName.Text = dr["FullName"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    txtPhone.Text = dr["Phone"].ToString();
                    txtAddress.Text = dr["Address"].ToString();
                    txtCity.Text = dr["City"].ToString();
                    txtState.Text = dr["State"].ToString();
                    txtPinCode.Text = dr["PinCode"].ToString();

                    // Formatting Date for the HTML5 Date Picker
                    if (dr["DOB"] != DBNull.Value)
                    {
                        txtDOB.Text = Convert.ToDateTime(dr["DOB"]).ToString("yyyy-MM-dd");
                    }
                }
            }
        }
        protected void btnSaveChanges_Click1(object sender, EventArgs e)
        {
            try
            {
                using (MySqlConnection con = new MySqlConnection(strcon))
                {
                    MySqlCommand cmd = new MySqlCommand("sp_UpdateUserProfile", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // 1. UserId
                    cmd.Parameters.AddWithValue("p_UserId", Session["UserId"]);
                    // 2. Full Name
                    cmd.Parameters.AddWithValue("p_FullName", txtFullName.Text.Trim());
                    // 3. Email (YOU WERE MISSING THIS ONE)
                    cmd.Parameters.AddWithValue("p_Email", txtEmail.Text.Trim());
                    // 4. Phone
                    cmd.Parameters.AddWithValue("p_Phone", txtPhone.Text.Trim());
                    // 5. Address
                    cmd.Parameters.AddWithValue("p_Address", txtAddress.Text.Trim());
                    // 6. City
                    cmd.Parameters.AddWithValue("p_City", txtCity.Text.Trim());
                    // 7. State
                    cmd.Parameters.AddWithValue("p_State", txtState.Text.Trim());
                    // 8. PinCode
                    cmd.Parameters.AddWithValue("p_PinCode", txtPinCode.Text.Trim());

                    con.Open();
                    int rows = cmd.ExecuteNonQuery();

                    if (rows > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "swal('Success','Profile Updated!','success')", true);
                    }
                    else
                    {
                        // This happens if the UserId in Session doesn't match any ID in the DB
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "swal('Warning','No changes were made. Verify your User ID.','warning')", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "swal('Error','" + ex.Message.Replace("'", "") + "','error')", true);
            }
        }
    }
}
