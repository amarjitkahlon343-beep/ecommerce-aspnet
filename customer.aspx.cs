using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ecomwebsite.Admin
{
    public partial class customer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                BindCustomerData();
                
                
            }
        }
        private void BindCustomerData()
        {
            try
            {
                // Using your existing connection utility
                using (MySqlConnection conn = new MySqlConnection(Utilscs.Utils.getConnection()))
                {
                    string query = "SELECT CustomerID, FullName, Email, Mobile, City, RegDate FROM tblCustomers ORDER BY FullName ASC";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptCustomers.DataSource = dt;
                        rptCustomers.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                // Silent error log for debugging
                System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
            }
        }
        protected void rptCustomers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteCustomer")
            {
                int customerId = Convert.ToInt32(e.CommandArgument);
                DeleteCustomerFromDb(customerId);
            }
        }

        private void DeleteCustomerFromDb(int id)
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(Utilscs.Utils.getConnection()))
                {
                    string query = "DELETE FROM tblCustomers WHERE CustomerID = @ID";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ID", id);

                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        // Refresh the list after deletion
                        BindCustomerData();
                        // If you have SweetAlert or ShowAlert, use it here:
                        // ShowAlert("Customer deleted successfully", "success");
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Delete Error: " + ex.Message);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {

        }

        protected void btnedit_Click(object sender, EventArgs e)
        {         }
     
    }
}
   