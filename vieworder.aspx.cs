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
    public partial class view_order : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindOrders();
            }
        }

        private void BindOrders()
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(Utilscs.Utils.getConnection()))
                {
                    // Update this query to match your actual table names
                    string query = "SELECT OrderID, CustomerName, OrderDate, TotalAmount, Status FROM tblOrders ORDER BY OrderDate DESC";
                    MySqlDataAdapter da = new MySqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptOrders.DataSource = dt;
                    rptOrders.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Use the ShowAlert method we created earlier
                // ShowAlert("Error loading orders: " + ex.Message, "danger");
            }
        }

        // Helper method to color-code order status
        protected string GetStatusClass(string status)
        {
            switch (status.ToLower())
            {
                case "pending": return "bg-warning text-dark";
                case "completed": return "bg-success";
                case "cancelled": return "bg-danger";
                default: return "bg-secondary";
            }
        }
    }
}