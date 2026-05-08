using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Ecomwebsite.Utilscs;

namespace Ecomwebsite.Admin
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using MySql.Data.MySqlClient; // Changed to MySQL
    using System.Web.UI.WebControls;

    public partial class SubCategory : System.Web.UI.Page
    {
        private readonly Utils _dataAccessUtility;

        public SubCategory()
        {
            // Initialize utility with your MySQL connection string
            _dataAccessUtility = new Utils();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            lblMsg.Visible = false;

            if (!IsPostBack)
            {
                Session["breadcrumbTitle"] = "Manage Sub-Category";
                Session["breadcrumbPage"] = "SubCategory";
                BindCategories();
                BindSubCategories();
            }
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            int subCategoryID = Convert.ToInt32(hfCategoryID.Value);
            string action = (subCategoryID == 0) ? "INSERT" : "UPDATE";

            var parameters = new List<MySqlParameter>
        {
            new MySqlParameter("p_Action", action),
            new MySqlParameter("p_SubCategoryID", subCategoryID),
            new MySqlParameter("p_SubCategoryName", txtSubCategoryName.Text.Trim()),
            new MySqlParameter("p_CategoryID", Convert.ToInt32(ddlCategory.SelectedValue)),
            new MySqlParameter("p_IsActive", cbIsActive.Checked)
        };

            try
            {
                // Using the utility to execute the stored procedure
                _dataAccessUtility.ExecuteStoredProcedure("sp_SubCategory_Crud", parameters);

                ShowMessage($"Sub-Category {(subCategoryID == 0 ? "Inserted" : "Updated")} Successfully", "alert alert-success");
                BindSubCategories();
                clear();
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, "alert alert-danger");
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }

        void clear()
        {
            txtSubCategoryName.Text = string.Empty;
            cbIsActive.Checked = false;
            hfCategoryID.Value = "0";
            ddlCategory.SelectedIndex = 0;
            btnAddOrUpdate.Text = "Add";
        }

        private void BindCategories()
        {
            var parameters = new List<MySqlParameter>
        {
            new MySqlParameter("p_Action", "GETALL"),
            new MySqlParameter("p_CategoryID", 0), // Placeholders required by your SP signature
            new MySqlParameter("p_CategoryName", null),
            new MySqlParameter("p_CategoryImageUrl", null),
            new MySqlParameter("p_IsActive", true)
        };

            DataTable dt = _dataAccessUtility.ExecuteStoredProcedure("sp_Category_Crud", parameters);
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CategoryID";
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new ListItem("Select Category", "0"));
        }

        private void BindSubCategories()
        {
            var parameters = new List<MySqlParameter>
        {
            new MySqlParameter("p_Action", "GETALL"),
            new MySqlParameter("p_SubCategoryID", 0),
            new MySqlParameter("p_SubCategoryName", null),
            new MySqlParameter("p_CategoryID", 0),
            new MySqlParameter("p_IsActive", true)
        };

            DataTable dt = _dataAccessUtility.ExecuteStoredProcedure("sp_SubCategory_Crud", parameters);
            rptSubCategory.DataSource = dt;
            rptSubCategory.DataBind();
        }

        private void ShowMessage(string message, string cssClass)
        {
            lblMsg.Visible = true;
            lblMsg.Text = message;
            lblMsg.CssClass = cssClass;
        }

        protected void rptSubCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int subId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Edit")
            {
                var parameters = new List<MySqlParameter>
            {
                new MySqlParameter("p_Action", "GETBYID"),
                new MySqlParameter("p_SubCategoryID", subId),
                new MySqlParameter("p_SubCategoryName", null),
                new MySqlParameter("p_CategoryID", 0),
                new MySqlParameter("p_IsActive", true)
            };

                DataTable dt = _dataAccessUtility.ExecuteStoredProcedure("sp_SubCategory_Crud", parameters);

                if (dt.Rows.Count > 0)
                {
                    txtSubCategoryName.Text = dt.Rows[0]["SubCategoryName"].ToString();
                    cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
                    hfCategoryID.Value = dt.Rows[0]["SubCategoryID"].ToString();
                    ddlCategory.SelectedValue = dt.Rows[0]["CategoryID"].ToString();
                    btnAddOrUpdate.Text = "Update";
                }
            }
            else if (e.CommandName == "Delete")
            {
                try
                {
                    var parameters = new List<MySqlParameter>
                {
                    new MySqlParameter("p_Action", "DELETE"),
                    new MySqlParameter("p_SubCategoryID", subId),
                    new MySqlParameter("p_SubCategoryName", null),
                    new MySqlParameter("p_CategoryID", 0),
                    new MySqlParameter("p_IsActive", true)
                };

                    _dataAccessUtility.ExecuteStoredProcedure("sp_SubCategory_Crud", parameters);
                    ShowMessage("Sub-Category Deleted Successfully", "alert alert-success");
                    BindSubCategories();
                    clear();
                }
                catch (Exception ex)
                {
                    ShowMessage("Error: " + ex.Message, "alert alert-danger");
                }
            }
        }
    }
}