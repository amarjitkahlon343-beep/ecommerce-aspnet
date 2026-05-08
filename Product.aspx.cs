using MySql.Data.MySqlClient; // Change this
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Web.UI.WebControls;
using static Ecomwebsite.Utilscs;
namespace Ecomwebsite.Admin
{


    public partial class Product : System.Web.UI.Page
    {
        // Use the MySQL types
        MySqlConnection con;
        MySqlCommand cmd;
        MySqlDataAdapter sda;
        DataTable dt;
        string[] imagepath ;
        ProductObj productObj;
        ProductDAL productDAL;
        List<ProductImageObj> productImages = new List<ProductImageObj>();
        int defaultImgAfterEdit = 0;
        private readonly Utils _dataAccessUtility;
        // ... (Your other variables remain the same)
        public Product()
        {
            // Initialize utility with your MySQL connection string
            _dataAccessUtility = new Utils();
        }
        protected void Page_Load(object sender, EventArgs e)
        {

            lblMsg.Visible = false;
            // Only run once when the page is first loaded (not on postbacks)
            if (!IsPostBack)
            {
                Session["breadcrumbTitle"] = "Manage Product";
                Session["breadcrumbPage"] = "Product";
                BindCategories();
                if (Request.QueryString["id"] != null)
                {
                    GetProductDetails();
                }
            }
        }
        private void BindCategories()
        {
            var parameters = new List<MySqlParameter>
    {
        new MySqlParameter("@p_Action", "GETALL"),
        new MySqlParameter("@p_CategoryID", 0),
        new MySqlParameter("@p_CategoryName", ""),
        new MySqlParameter("@p_CategoryImageUrl", ""),
        new MySqlParameter("@p_IsActive", 1)
    };

            // MAKE SURE THIS IS THE CATEGORY PROCEDURE NAME
            DataTable dt = _dataAccessUtility.ExecuteStoredProcedure("SP_Category_Crud", parameters);

            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CategoryID";
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new ListItem("Select Category", "0"));
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
           
            int categoryId = Convert.ToInt32(ddlCategory.SelectedValue);

            if (categoryId > 0)
            {
                BindSubCategories(categoryId);
            }
            else
            {
                // Reset subcategory if no category is selected
                ddlSubCategory.Items.Clear();
                ddlSubCategory.Items.Insert(0, new ListItem("Select SubCategory", "0"));
            }
        }

        private void BindSubCategories(int CID)
        {
            var parameters = new List<MySqlParameter>
    {
        new MySqlParameter("@p_Action", "SUBCATEGORYBYID"),
        new MySqlParameter("@p_SubCategoryID", 0),
        new MySqlParameter("@p_SubCategoryName", ""),
        new MySqlParameter("@p_CategoryID", CID),
        new MySqlParameter("@p_IsActive", 1)
    };

            DataTable dt = _dataAccessUtility.ExecuteStoredProcedure("sp_SubCategory_Crud", parameters);

            ddlSubCategory.Items.Clear();

            if (dt != null && dt.Rows.Count > 0)
            {
                ddlSubCategory.DataSource = dt;
                ddlSubCategory.DataTextField = "SubCategoryName";
                ddlSubCategory.DataValueField = "SubCategoryID";
                ddlSubCategory.DataBind();
            }

            ddlSubCategory.Items.Insert(0, new ListItem("Select SubCategory", "0"));
        }
        void GetProductDetails()
        {
            if (Request.QueryString["id"] != null)
            {
                int productid = Convert.ToInt32(Request.QueryString["id"]);
                productDAL = new ProductDAL();

                // This calls the MySQL-compatible DAL method
                dt = productDAL.ProductByIdWithImages(productid);

                if (dt != null && dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];

                    txtProductName.Text = row["ProductName"].ToString();
                    txtPrice.Text = row["Price"].ToString();
                    txtQty.Text = row["Quantity"].ToString();
                    txtShortDesc.Text = row["ShortDesc"].ToString();
                    txtLongDesc.Text = row["LongDesc"].ToString();
                    txtAdditionalDesc.Text = row["AdditionalDesc"].ToString();

                    // Handling Colors (split by comma)
                    string[] color = row["Color"].ToString().Split(',');
                    foreach (string c in color)
                    {
                        var item = listboxColor.Items.FindByText(c.Trim());
                        if (item != null) item.Selected = true;
                    }

                    // Handling Sizes (split by comma)
                    string[] size = row["Size"].ToString().Split(',');
                    foreach (string s in size)
                    {
                        var item = listboxSize.Items.FindByText(s.Trim());
                        if (item != null) item.Selected = true;
                    }

                    txtCompanyName.Text = row["CompanyName"].ToString();
                    ddlCategory.SelectedValue = row["CategoryID"].ToString();
                    BindSubCategories(Convert.ToInt32(row["CategoryID"]));
                    ddlSubCategory.SelectedValue = row["SubCategoryID"].ToString();

                    IsCBCustomized.Checked = Convert.ToBoolean(row["IsCustomized"]);
                    cbIsActive.Checked = Convert.ToBoolean(row["IsActive"]);

                    // Image Mapping logic based on our MySQL GROUP_CONCAT
                    // We expect columns Image1, Image2, Image3, Image4, Image5 to be added by the DAL
                    AssignImage(imageProduct1, row["Image1"]);
                    AssignImage(imageProduct2, row["Image2"]);
                    AssignImage(imageProduct3, row["Image3"]);
                    AssignImage(imageProduct4, row["Image4"]);
                    AssignImage(imageProduct5, row["Image5"]);

                    rblDefaultImage.SelectedIndex = Convert.ToInt32(row["DefaultImage"]);
                    hfDefaultImage.Value = (Convert.ToInt32(row["DefaultImage"]) + 1).ToString();

                    btnAddOrUpdate.Text = "Update";
                }
            }
        }

        // Helper to clean up the Substring/Index logic
        private void AssignImage(System.Web.UI.WebControls.Image imgCtrl, object val)
        {
            if (val != null && !string.IsNullOrEmpty(val.ToString()))
            {
                string rawPath = val.ToString();
                // Remove the ":0" or ":1" flag from the end if present
                if (rawPath.Contains(":"))
                {
                    rawPath = rawPath.Substring(0, rawPath.IndexOf(":"));
                }
                imgCtrl.ImageUrl = "../" + rawPath;
                imgCtrl.Width = 200;
                imgCtrl.Style.Remove("display");
            }
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            try
            {
               
                List<string> sizeList = new List<string>();
                foreach (ListItem item in listboxSize.Items)
                {
                    if (item.Selected)
                    {
                        sizeList.Add(item.Text);
                    }
                }
                string selectedSize = string.Join(",", sizeList);

                List<string> colorList = new List<string>();
                foreach (ListItem item in listboxColor.Items)
                {
                    if (item.Selected)
                    {
                        colorList.Add(item.Text);
                    }
                }
                string selectedColor = string.Join(",", colorList);
                bool isValid = false;
                bool isValidToExecute = false;
                List<string> list = new List<string>();
                bool isImageSaved = false;
                if (Request.QueryString["id"] == null)
                {
                    if (FileUploadImg1.HasFile && FileUploadImg2.HasFile && FileUploadImg3.HasFile && FileUploadImg4.HasFile && FileUploadImg5.HasFile)
                    {
                        list.Add(FileUploadImg1.FileName);
                        list.Add(FileUploadImg2.FileName);
                        list.Add(FileUploadImg3.FileName);
                        list.Add(FileUploadImg4.FileName);
                        list.Add(FileUploadImg5.FileName);
                        string[] fu = list.ToArray();

                        #region validate images
                        for (int i = 0; i <= fu.Length - 1; i++)
                        {
                            if (Utils.IsValidExtension(fu[i]))
                            {
                                isValid = true;
                            }
                            else
                            {
                                isValid = false;
                                break;
                            }
                        }
                        #endregion

                        #region After validate images procede for saving image and product
                        if (isValid)
                        {
                            imagepath = Utils.getImagesPath(fu);
                            for (int i = 0; i <= imagepath.Length - 1; i++)
                            {
                                for (int j = i; j <= rblDefaultImage.Items.Count - 1;)
                                {
                                    productImages.Add
                                    (
                                        new ProductImageObj()
                                        {
                                            ImageUrl = imagepath[i],
                                            IsDefault = Convert.ToBoolean(rblDefaultImage.Items[j].Selected)
                                        }
                                     );
                                    break;
                                }
                                #region save all images
                                if (i == 0)
                                {
                                    FileUploadImg1.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + imagepath[i].Replace("Images/Product/", ""));
                                    isImageSaved = true;
                                }
                                else if (i == 1)
                                {
                                    FileUploadImg2.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + imagepath[i].Replace("Images/Product/", ""));
                                    isImageSaved = true;
                                }
                                else if (i == 2)
                                {
                                    FileUploadImg3.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + imagepath[i].Replace("Images/Product/", ""));
                                    isImageSaved = true;
                                }
                                else if (i == 3)
                                {
                                    FileUploadImg4.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + imagepath[i].Replace("Images/Product/", ""));
                                    isImageSaved = true;
                                }
                                else if (i == 4)
                                {
                                    FileUploadImg5.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + imagepath[i].Replace("Images/Product/", ""));
                                    isImageSaved = true;
                                }
                                #endregion
                            }

                            #region save new product
                            if (isImageSaved)
                            {
                                selectedColor = Utils.getItemWithCommaSeparated(listboxColor);
                                selectedSize = Utils.getItemWithCommaSeparated(listboxSize);
                                productDAL = new ProductDAL();
                                productObj = new ProductObj()
                                {
                                    ProductID = Request.QueryString["id"] == null ? 0 : Convert.ToInt32(Request.QueryString["id"]),
                                    ProductName = txtProductName.Text,
                                    ShortDesc = txtShortDesc.Text,
                                    LongDesc = txtLongDesc.Text,
                                    AdditionalDesc = txtAdditionalDesc.Text,
                                    Price = Convert.ToDecimal(txtPrice.Text),
                                    Quantity = Convert.ToInt32(txtQty.Text),
                                    Size = selectedSize,
                                    Color = selectedColor,
                                    CompanyName = txtCompanyName.Text,
                                    CategoryID = Convert.ToInt32(ddlCategory.SelectedValue),
                                    SubCategoryID = Convert.ToInt32(ddlSubCategory.SelectedValue),
                                    IsCustomized = IsCBCustomized.Checked,
                                    IsActive = cbIsActive.Checked,
                                    ProductImages = productImages
                                };
                                int r = productDAL.AddUpdateProduct(productObj);
                                if (r > 0)
                                {
                                    ShowMessage("Product saved successfully", "alert alert-success");
                                }
                                else
                                {
                                    DeleteFile(imagepath);
                                    ShowMessage("Can't save record at this moment", "alert alert-danger");
                                }
                            }
                            else
                            {
                                DeleteFile(imagepath);
                            }

                            #endregion
                        }
                        else
                        {
                            ShowMessage("Please Select valid product images", "alert alert-danger");
                        }
                        #endregion
                    }
                    else
                    {
                        ShowMessage("Please Select all product images", "alert alert-danger");
                    }
                }
                else
                {
                    if (FileUploadImg1.HasFile && FileUploadImg2.HasFile && FileUploadImg3.HasFile && FileUploadImg4.HasFile && FileUploadImg5.HasFile)
                    {
                        list.Add(FileUploadImg1.FileName);
                        list.Add(FileUploadImg2.FileName);
                        list.Add(FileUploadImg3.FileName);
                        list.Add(FileUploadImg4.FileName);
                        list.Add(FileUploadImg5.FileName);
                        string[] fu = list.ToArray();
                        #region validate images
                        for (int i = 0; i <= fu.Length - 1; i++)
                        {
                            if (Utils.IsValidExtension(fu[i]))
                            {
                                isValid = true;
                            }
                            else
                            {
                                isValid = false;
                                break;
                            }
                        }
                        #endregion

                        #region After validate images procede for saving image and product
                        if (isValid)
                        {
                            imagepath = Utils.getImagesPath(fu);
                            for (int i = 0; i <= imagepath.Length - 1; i++)
                            {
                                for (int j = i; j <= rblDefaultImage.Items.Count - 1;)
                                {
                                    productImages.Add
                                    (
                                        new ProductImageObj()
                                        {
                                            ImageUrl = imagepath[i],
                                            IsDefault = Convert.ToBoolean(rblDefaultImage.Items[j].Selected)
                                        }
                                     );
                                    break;
                                }
                                #region save all images
                                if (i == 0)
                                {
                                    FileUploadImg1.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + imagepath[i].Replace("Images/Product/", ""));
                                    isImageSaved = true;
                                }
                                else if (i == 1)
                                {
                                    FileUploadImg2.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + imagepath[i].Replace("Images/Product/", ""));
                                    isImageSaved = true;
                                }
                                else if (i == 2)
                                {
                                    FileUploadImg3.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + imagepath[i].Replace("Images/Product/", ""));
                                    isImageSaved = true;
                                }
                                else if (i == 3)
                                {
                                    FileUploadImg4.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + imagepath[i].Replace("Images/Product/", ""));
                                    isImageSaved = true;
                                }
                                else if (i == 4)
                                {
                                    FileUploadImg5.PostedFile.SaveAs(Server.MapPath("~/Images/Product/") + imagepath[i].Replace("Images/Product/", ""));
                                    isImageSaved = true;
                                }
                                #endregion
                            }

                            if (isImageSaved)
                            {
                                isValidToExecute = true;
                            }
                            else
                            {
                                DeleteFile(imagepath);
                            }

                        }
                        else
                        {
                            ShowMessage("Please Select valid product images", "alert alert-danger");
                        }
                        #endregion
                    }
                    else if (FileUploadImg1.HasFile || FileUploadImg2.HasFile || FileUploadImg3.HasFile || FileUploadImg4.HasFile || FileUploadImg5.HasFile)
                    {
                        ShowMessage("Please Select all product images for Update ", "alert alert-danger");
                    }
                    else
                    {
                        //update product without images
                        if (Convert.ToInt32(hfDefaultImage.Value) != Convert.ToInt32(rblDefaultImage.SelectedValue))
                        {
                            defaultImgAfterEdit = Convert.ToInt32(rblDefaultImage.SelectedValue);
                        }
                        isValidToExecute = true;
                    }
                    #region Updating product
                    if (isValidToExecute)
                    {
                        selectedColor = Utils.getItemWithCommaSeparated(listboxColor);
                        selectedSize = Utils.getItemWithCommaSeparated(listboxSize);
                        productDAL = new ProductDAL();
                        productObj = new ProductObj()
                        {
                            ProductID = Convert.ToInt32(Request.QueryString["id"]),
                            ProductName = txtProductName.Text,
                            ShortDesc = txtShortDesc.Text,
                            LongDesc = txtLongDesc.Text,
                            AdditionalDesc = txtAdditionalDesc.Text,
                            Price = Convert.ToDecimal(txtPrice.Text),
                            Quantity = Convert.ToInt32(txtQty.Text),
                            Size = selectedSize,
                            Color = selectedColor,
                            CompanyName = txtCompanyName.Text,
                            CategoryID = Convert.ToInt32(ddlCategory.SelectedValue),
                            SubCategoryID = Convert.ToInt32(ddlSubCategory.SelectedValue),
                            IsCustomized = IsCBCustomized.Checked,
                            IsActive = cbIsActive.Checked,
                            ProductImages = productImages,
                            DefaultImagePosition = defaultImgAfterEdit
                        };
                        int r = productDAL.AddUpdateProduct(productObj);
                        if (r > 0)
                        {
                            ShowMessage("Product Updated successfully", "alert alert-success");
                        }
                        else
                        {
                            DeleteFile(imagepath);
                            ShowMessage("Can't update record at this moment", "alert alert-danger");
                        }
                    }
                    else
                    {
                        //DeleteFile(imagepath);
                        ShowMessage("Something went wrong", "alert alert-danger");
                    }

                    #endregion

                }

            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, "alert alert-danger");
            }
        }
 
        protected void btnClear_Click(object sender, EventArgs e)
        {
            clrControl();
        }
        private void ShowMessage(string message, string cssClass)
        {
            lblMsg.Visible = true;
            lblMsg.Text = message;
            lblMsg.CssClass = cssClass;
        }
        void DeleteFile(string[] filePath)
        {
            for (int i = 0; i < filePath.Length - 1; i++)
            {
                if (File.Exists(Server.MapPath("~/" + filePath[i])))
                {
                    File.Delete(Server.MapPath("~/" + filePath[i]));
                }
            }
        }
        void clrControl()
        {
            txtProductName.Text = txtShortDesc.Text = txtLongDesc.Text = txtAdditionalDesc.Text = txtPrice.Text = txtQty.Text = txtCompanyName.Text = string.Empty;
            listboxColor.ClearSelection();
            listboxSize.ClearSelection();
            ddlCategory.ClearSelection();
            ddlSubCategory.ClearSelection();
            rblDefaultImage.ClearSelection();
            IsCBCustomized.Checked = false;
            cbIsActive.Checked = false;
            hfDefaultImage.Value = "0";
        }
    }
}