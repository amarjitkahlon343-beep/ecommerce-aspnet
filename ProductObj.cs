using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using static Ecomwebsite.Utilscs;

namespace Ecomwebsite.Admin
{
    public class ProductObj
    {
            public int ProductID { get; set; }
            public string ProductName { get; set; }
            public string ShortDesc { get; set; }
            public string LongDesc { get; set; }
            public string AdditionalDesc { get; set; }
            public int CategoryID { get; set; }
            public int SubCategoryID { get; set; }
            public int BrandID { get; set; }
            public decimal Price { get; set; }
            public decimal Discount { get; set; }
            public int Quantity { get; set; }
            public int MinOrderQuantity { get; set; }
            public int MaxOrderQuantity { get; set; }
            public string Size { get; set; }
            public string Color { get; set; }
            public decimal Weight { get; set; }
            public string Dimensions { get; set; }
            public string CompanyName { get; set; }
            public string WarrantyInfo { get; set; }
            public string ReturnPolicy { get; set; }
            public int Sold { get; set; }
            public bool IsCustomized { get; set; }
            public bool IsActive { get; set; }
            public bool IsFeatured { get; set; }
            public string StockStatus { get; set; }
            public DateTime CreatedDate { get; set; }
        public List<ProductImageObj> ProductImages { get; set; } = new List<ProductImageObj>();
        public int DefaultImagePosition { get; set; }

    }
    public class ProductImageObj
    {
        public int ImageID { get; set; }      // Maps to ImageID (Primary Key)
        public string ImageUrl { get; set; }  // Maps to ImageUrl (TEXT)
        public int ProductID { get; set; }    // Maps to ProductID (Foreign Key)
        public bool IsDefault { get; set; }   // Maps to IsDefault (BIT)
    }
    public class ProductDAL
    {
        MySqlConnection con;
        MySqlCommand cmd;
        MySqlDataAdapter da;
        DataTable dt;

        public int AddUpdateProduct(ProductObj products)
        {
            int result = 0;
            int productid = products.ProductID;
            string type = (productid == 0) ? "INSERT" : "UPDATE";

            using (con = new MySqlConnection(Utils.getConnection()))
            {
                con.Open();
                using (var transaction = con.BeginTransaction())
                {
                    try
                    {
                        #region Insert/Update Product
                        cmd = new MySqlCommand("sp_Product_Crud", con, transaction);
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("p_Action", type);
                        cmd.Parameters.AddWithValue("p_ProductID", productid);
                        cmd.Parameters.AddWithValue("p_ProductName", products.ProductName);
                        cmd.Parameters.AddWithValue("p_ShortDesc", products.ShortDesc);
                        cmd.Parameters.AddWithValue("p_LongDesc", products.LongDesc);
                        cmd.Parameters.AddWithValue("p_AdditionalDesc", products.AdditionalDesc);
                        cmd.Parameters.AddWithValue("p_Price", products.Price);
                        cmd.Parameters.AddWithValue("p_Quantity", products.Quantity);
                        cmd.Parameters.AddWithValue("p_Size", products.Size);
                        cmd.Parameters.AddWithValue("p_Color", products.Color);
                        cmd.Parameters.AddWithValue("p_CompanyName", products.CompanyName);
                        cmd.Parameters.AddWithValue("p_CategoryID", products.CategoryID);
                        cmd.Parameters.AddWithValue("p_SubCategoryID", products.SubCategoryID);
                        cmd.Parameters.AddWithValue("p_IsCustomized", products.IsCustomized);
                        cmd.Parameters.AddWithValue("p_IsActive", products.IsActive);
                        // Dummy values for image-specific params in the main crud
                        cmd.Parameters.AddWithValue("p_ImageUrl", DBNull.Value);
                        cmd.Parameters.AddWithValue("p_DefaultImage", false);
                        cmd.Parameters.AddWithValue("p_BrandID", products.BrandID);

                        if (type == "INSERT")
                        {
                            // ExecuteScalar returns the LAST_INSERT_ID() from our procedure
                            productid = Convert.ToInt32(cmd.ExecuteScalar());
                        }
                        else
                        {
                            cmd.ExecuteNonQuery();
                        }
                        #endregion

                        #region Product Images Logic
                        if (productid > 0)
                        {
                            // If updating, delete existing images first to refresh gallery
                            if (type == "UPDATE" && products.ProductImages?.Count > 0)
                            {
                                var delCmd = new MySqlCommand("sp_Product_Crud", con, transaction);
                                delCmd.CommandType = CommandType.StoredProcedure;
                                delCmd.Parameters.AddWithValue("p_Action", "DELETE_PROD_IMG");
                                delCmd.Parameters.AddWithValue("p_ProductID", productid);
                                FillNullParams(delCmd); // Helper to fill remaining SP params
                                delCmd.ExecuteNonQuery();
                            }

                            // Insert new images
                            if (products.ProductImages != null)
                            {
                                foreach (var image in products.ProductImages)
                                {
                                    var imgCmd = new MySqlCommand("sp_Product_Crud", con, transaction);
                                    imgCmd.CommandType = CommandType.StoredProcedure;
                                    imgCmd.Parameters.AddWithValue("p_Action", "INSERT_PROD_IMG");
                                    imgCmd.Parameters.AddWithValue("p_ImageUrl", image.ImageUrl);
                                    imgCmd.Parameters.AddWithValue("p_ProductID", productid);
                                    imgCmd.Parameters.AddWithValue("p_DefaultImage", image.IsDefault);
                                    FillNullParams(imgCmd);
                                    imgCmd.ExecuteNonQuery();
                                }
                            }
                        }
                        #endregion
                       
                        transaction.Commit();
                        result = 1;
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        throw ex;
                    }
                }
            }
            return result;
        }

        public DataTable ProductByIdWithImages(int productId)
        {
            try
            {
                DataTable dt = ProductById(productId);
                if (dt.Rows.Count == 0) return dt;

                // Prepare columns for your UI (Matches your original logic)
                dt.Columns.Add("Image1_Url");
                dt.Columns.Add("Image2_Url");
                dt.Columns.Add("Image3_Url");
                dt.Columns.Add("Image4_Url");
                dt.Columns.Add("DefaultImageIndex");

                string imageConcat = dt.Rows[0]["Image1"].ToString(); // From GROUP_CONCAT in SP
                if (!string.IsNullOrEmpty(imageConcat))
                {
                    string[] imgWithFlagArr = imageConcat.Split(';');
                    int defaultIdx = 0;

                    for (int i = 0; i < imgWithFlagArr.Length && i < 4; i++)
                    {
                        string[] parts = imgWithFlagArr[i].Split(':'); // Split "url:flag"
                        dt.Rows[0]["Image" + (i + 1) + "_Url"] = parts[0];

                        if (parts.Length > 1 && parts[1] == "1")
                        {
                            defaultIdx = i;
                        }
                    }
                    dt.Rows[0]["DefaultImageIndex"] = defaultIdx;
                }
                return dt;
            }
            catch (Exception ex) { throw ex; }
        }

        public DataTable ProductById(int pId)
        {
            try
            {
                using (MySqlConnection con = new MySqlConnection(Utils.getConnection()))
                {
                    con.Open();
                    using (MySqlCommand cmd = new MySqlCommand("sp_Product_Crud", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        // MySQL Parameter Naming (matches the p_ prefix in the SP)
                        cmd.Parameters.AddWithValue("p_Action", "GETBYID");
                        cmd.Parameters.AddWithValue("p_ProductID", pId);

                        // Fill other mandatory SP params with null to avoid "Parameter not found" error
                        string[] otherParams = { "p_ProductName", "p_ShortDesc", "p_LongDesc", "p_AdditionalDesc",
                                         "p_CategoryID", "p_SubCategoryID", "p_BrandID", "p_Price",
                                         "p_Quantity", "p_Size", "p_Color", "p_CompanyName",
                                         "p_ImageUrl", "p_DefaultImage", "p_IsCustomized", "p_IsActive" };
                        foreach (string p in otherParams) cmd.Parameters.AddWithValue(p, DBNull.Value);

                        DataTable dt = new DataTable();
                        using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                        return dt;
                    }
                }
            }
            catch (Exception )
            {
                // Log error here
                throw;
            }
        }

        // MySQL requires all parameters defined in the procedure to be passed
        private void FillNullParams(MySqlCommand command)
        {
            string[] allParams = { "p_Action", "p_ProductID", "p_ProductName", "p_ShortDesc", "p_LongDesc",
                               "p_AdditionalDesc", "p_CategoryID", "p_SubCategoryID", "p_BrandID",
                               "p_Price", "p_Quantity", "p_Size", "p_Color", "p_CompanyName",
                               "p_ImageUrl", "p_DefaultImage", "p_IsCustomized", "p_IsActive" };
            foreach (string p in allParams)
            {
                if (!command.Parameters.Contains(p))
                    command.Parameters.AddWithValue(p, DBNull.Value);
            }
        }
    }
}