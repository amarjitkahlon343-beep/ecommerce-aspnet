using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Ecomwebsite.Utilscs;

namespace Ecomwebsite.Admin
{
    public partial class Dashboardaspx : System.Web.UI.Page
    {
        private readonly Utils _dataAccessUtility;

        public Dashboardaspx()
        {
            // Initialize utility with your MySQL connection string
            _dataAccessUtility = new Utils();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // ... your other bindings
           
                BindRecentOrders();
            }
        }
     
        private void BindRecentOrders()
        {
            try
            {
                // If you have a stored procedure for orders:
                var parameters = new List<MySqlParameter>
        {
            new MySqlParameter("p_Action", "GET_RECENT"),
            new MySqlParameter("p_Limit", 10) // Show last 10 orders
        };

                DataTable dt = _dataAccessUtility.ExecuteStoredProcedure("sp_Order_Crud", parameters);

                if (dt != null)
                {
                    gvRecentOrders.DataSource = dt;
                    gvRecentOrders.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine("Error binding orders: " + ex.Message);
            }
        }
        // Handle Pagination
        protected void gvRecentOrders_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvRecentOrders.PageIndex = e.NewPageIndex;
            BindRecentOrders();
        }

        // Handle Action Buttons (View/Update)
        protected void gvRecentOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int orderId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "ViewOrder")
            {
                Response.Redirect($"ViewOrder.aspx?OrderId={orderId}");
            }
            else if (e.CommandName == "UpdateStatus")
            {
                // Logic to open a modal or redirect to status update page
            }
        }
    }
}