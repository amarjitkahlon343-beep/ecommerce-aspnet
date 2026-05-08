using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Ecomwebsite.Utilscs;
using static System.Collections.Specialized.BitVector32;
namespace Ecomwebsite.Admin
{
    public partial class Category : System.Web.UI.Page
    {
        // Use your existing DBconnect helper class
        DBconnect db = new DBconnect();
        private readonly Utils _dataAccessUtility;

        public Category()
        {
            // Initializes using the "cm" connection string from Utils
            _dataAccessUtility = new Utils();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            lblMsg.Visible = false;

            if (!IsPostBack)
            {
                Session["breadcrumbTitle"] = "Manage Category";
                Session["breadcrumbPage"] = "Category";
                BindCategories();
            }
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName, imagePath = string.Empty;
            bool isValidToExecute = false;
            int categoryID = Convert.ToInt32(hfCategoryID.Value);

            // Initialize Command for MySQL
            MySqlCommand cmd = new MySqlCommand("SP_Category_Crud");
            cmd.CommandType = CommandType.StoredProcedure;

            // Parameters matching MySQL Procedure
            cmd.Parameters.AddWithValue("p_Action", categoryID == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("p_CategoryID", categoryID);
            cmd.Parameters.AddWithValue("p_CategoryName", txtCategoryName.Text.Trim());
            cmd.Parameters.AddWithValue("p_IsActive", cbIsActive.Checked ? 1 : 0);

            // Image Logic using the Utils helper
            if (FUCategoryImage.HasFile)
            {
                if (Utils.IsValidExtension(FUCategoryImage.FileName))
                {
                    string newImageName = Utils.getUniqueID();
                    string fileExtension = Path.GetExtension(FUCategoryImage.FileName);

                    // 1. This is the path stored in the DATABASE (Relative)
                    imagePath = "Images/Category/" + newImageName + fileExtension;

                    // 2. This is where the file is SAVED on the server (Physical)
                    // Server.MapPath converts "~/Images/Category/" to "C:\YourProject\Images\Category\"
                    FUCategoryImage.PostedFile.SaveAs(Server.MapPath("~/") + imagePath);

                    cmd.Parameters.AddWithValue("p_CategoryImageUrl", imagePath);
                    isValidToExecute = true;
                }
            }
            else if (categoryID != 0)
            {
                // If updating and no new image is uploaded, keep the old one
                imagePath = _dataAccessUtility.GetCurrentCategoryImage(categoryID);
                cmd.Parameters.AddWithValue("p_CategoryImageUrl", imagePath);
                isValidToExecute = true;
            }
            else
            {
                // New category without image
                cmd.Parameters.AddWithValue("p_CategoryImageUrl", DBNull.Value);
                isValidToExecute = true;
            }

            if (isValidToExecute)
            {
                try
                {
                    cmd.Connection = db.GetCon();
                    db.OpenCon();
                    cmd.ExecuteNonQuery();

                    actionName = categoryID == 0 ? "Inserted" : "Updated";
                    ShowMessage("Category " + actionName + " Successfully", "alert alert-success");
                    BindCategories();
                    clear();
                }
                catch (Exception ex)
                {
                    ShowMessage("Error: " + ex.Message, "alert alert-danger");
                }
                finally
                {
                    db.CloseCon();
                }
            }
        }

        private void BindCategories()
        {
            MySqlCommand bindCmd = new MySqlCommand("SP_Category_Crud");
            bindCmd.CommandType = CommandType.StoredProcedure;

            // Providing default values for all parameters as required by MySQL SPs
            bindCmd.Parameters.AddWithValue("p_Action", "GETALL");
            bindCmd.Parameters.AddWithValue("p_CategoryID", 0);
            bindCmd.Parameters.AddWithValue("p_CategoryName", DBNull.Value);
            bindCmd.Parameters.AddWithValue("p_CategoryImageUrl", DBNull.Value);
            bindCmd.Parameters.AddWithValue("p_IsActive", DBNull.Value);

            DataTable dt = db.Load_Data(bindCmd);
            rptCategory.DataSource = dt;
            rptCategory.DataBind();
        }

        protected void rptCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Edit")
            {
                MySqlCommand editCmd = new MySqlCommand("SP_Category_Crud");
                editCmd.CommandType = CommandType.StoredProcedure;
                editCmd.Parameters.AddWithValue("p_Action", "GETBYID");
                editCmd.Parameters.AddWithValue("p_CategoryID", id);
                editCmd.Parameters.AddWithValue("p_CategoryName", DBNull.Value);
                editCmd.Parameters.AddWithValue("p_CategoryImageUrl", DBNull.Value);
                editCmd.Parameters.AddWithValue("p_IsActive", DBNull.Value);

                DataTable dt = db.Load_Data(editCmd);
                if (dt.Rows.Count > 0)
                {
                    txtCategoryName.Text = dt.Rows[0]["CategoryName"].ToString();
                    cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);

                    // Use Utils to get URL correctly
                    string imgUrl = dt.Rows[0]["CategoryImageUrl"].ToString();
                    ImagePreview.ImageUrl = Utils.getImageUrl(imgUrl);

                    hfCategoryID.Value = dt.Rows[0]["CategoryID"].ToString();
                    btnAddOrUpdate.Text = "Update";
                }
            }
            else if (e.CommandName == "Delete")
            {
                MySqlCommand delCmd = new MySqlCommand("SP_Category_Crud");
                delCmd.CommandType = CommandType.StoredProcedure;
                delCmd.Parameters.AddWithValue("p_Action", "DELETE");
                delCmd.Parameters.AddWithValue("p_CategoryID", id);
                delCmd.Parameters.AddWithValue("p_CategoryName", DBNull.Value);
                delCmd.Parameters.AddWithValue("p_CategoryImageUrl", DBNull.Value);
                delCmd.Parameters.AddWithValue("p_IsActive", DBNull.Value);

                try
                {
                    delCmd.Connection = db.GetCon();
                    db.OpenCon();
                    delCmd.ExecuteNonQuery();
                    ShowMessage("Category Deleted Successfully", "alert alert-success");
                    BindCategories();
                }
                catch (Exception ex)
                {
                    ShowMessage("Delete Error: " + ex.Message, "alert alert-danger");
                }
                finally
                {
                    db.CloseCon();
                }
            }
        }

        private void clear()
        {
            txtCategoryName.Text = string.Empty;
            cbIsActive.Checked = false;
            hfCategoryID.Value = "0";
            ImagePreview.ImageUrl = "../Images/No_Image.png";
            btnAddOrUpdate.Text = "Add";
        }

        private void ShowMessage(string message, string cssClass)
        {
            lblMsg.Visible = true;
            lblMsg.Text = message;
            lblMsg.CssClass = cssClass;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }

    }
}