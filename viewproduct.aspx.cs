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
    public partial class viewproduct : System.Web.UI.Page
    {
        private Utils _dataAccessUtility = new Utils();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if ProductID exists in URL
                if (Request.QueryString["id"] != null)
                {
                    int productId = Convert.ToInt32(Request.QueryString["id"]);
                    LoadProductDetails(productId);
                }
                else
                {
                    Response.Redirect("Product.aspx"); // Redirect if no ID provided
                }
            }
        }
        private void LoadProductDetails(int productId)
        {
            var parameters = new List<MySqlParameter>
        {
            new MySqlParameter("p_Action", "GETBYID"),
            new MySqlParameter("p_ProductID", productId)
        };

            // Assuming you have an SP named sp_Product_Crud
            DataTable dt = _dataAccessUtility.ExecuteStoredProcedure("sp_Product_Crud", parameters);

            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                lblProductName.Text = row["ProductName"].ToString();
                lblCategory.Text = row["CategoryName"].ToString(); // From a JOIN in your SP
                lblPrice.Text = string.Format("{0:C}", row["Price"]);
                lblDescription.Text = row["Description"].ToString();
                lblStock.Text = row["Stock"].ToString();
                lblStatus.Text = Convert.ToBoolean(row["IsActive"]) ? "Active" : "Inactive";
                imgProduct.ImageUrl = row["ImageURL"].ToString();
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            Response.Redirect($"AddEditProduct.aspx?id={id}");
        }
    }
}
