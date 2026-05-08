using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace Ecomwebsite
{
    public class Utilscs
    {
        DBconnect db = new DBconnect();
        MySqlCommand cmd;
        MySqlDataAdapter sda;
        MySqlDataReader sdr;
        DataTable dt;
        public class Utils
        {
            private readonly string _connectionString;

            public Utils()
            {
                // Matches the name "cm" in your web.config
                _connectionString = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            }

            // Static method to get connection string
            public static string getConnection()
            {
                return ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            }

            // Validate image file extension
            public static bool IsValidExtension(string fileName)
            {
                string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".webp" };
                string fileExtension = Path.GetExtension(fileName).ToLower();
                return allowedExtensions.Contains(fileExtension);
            }

            // Uniquely Generate ID
            public static string getUniqueID()
            {
                return Guid.NewGuid().ToString();
            }

            // Return Image URL
            public static string getImageUrl(object url)
            {
                if (url == null || url == DBNull.Value || string.IsNullOrEmpty(url.ToString()))
                {
                    return "../Images/No_Image.png";
                }
                return string.Format("../{0}", url);
            }

            // Generic method for MySQL Stored Procedures
            public DataTable ExecuteStoredProcedure(string procedureName, List<MySqlParameter> parameters)
            {
                DataTable dt = new DataTable();
                using (MySqlConnection con = new MySqlConnection(_connectionString))
                {
                    using (MySqlCommand cmd = new MySqlCommand(procedureName, con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        // 1. Add parameters safely
                        if (parameters != null)
                        {
                            cmd.Parameters.Clear(); // Clear any existing parameters to avoid duplicates
                            foreach (MySqlParameter param in parameters)
                            {
                                // Ensure the value isn't null to prevent DBNull errors
                                if (param.Value == null) param.Value = DBNull.Value;
                                cmd.Parameters.Add(param);
                            }
                        }

                        try
                        {
                            // 2. Explicitly open the connection
                            if (con.State == ConnectionState.Closed) con.Open();

                            using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                            {
                                sda.Fill(dt);
                            }
                        }
                        catch (Exception ex)
                        {
                            // Rethrow the error with more context
                            throw new Exception("Error executing procedure: " + procedureName + ". " + ex.Message);
                        }
                        finally
                        {
                            // 3. Always close the connection
                            if (con.State == ConnectionState.Open) con.Close();
                        }
                    }
                }
                return dt;
            }

            // Category CRUD
            public DataTable ExecuteCategoryCommand(string action, object categoryId)
            {
                using (MySqlConnection con = new MySqlConnection(Utils.getConnection()))
                {
                    using (MySqlCommand cmd = new MySqlCommand("sp_Category_Crud", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Action", action);
                        cmd.Parameters.AddWithValue("@CategoryID", categoryId);

                        using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            return dt;
                        }
                    }
                }
            }

            // Get Image Path by Category ID
            public string GetCurrentCategoryImage(int categoryID)
            {
                string currentImagePath = string.Empty;
                using (MySqlConnection con = new MySqlConnection(Utils.getConnection()))
                {
                    using (MySqlCommand cmd = new MySqlCommand("sp_Category_Crud", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Action", "GETBYID");
                        cmd.Parameters.AddWithValue("@CategoryID", categoryID);

                        con.Open();
                        using (MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                currentImagePath = reader["CategoryImageUrl"].ToString();
                            }
                        }
                    }
                }
                return currentImagePath;
            }

            // Generate array of paths for multiple images
            public static string[] getImagesPath(string[] images)
            {
                List<string> list = new List<string>();
                foreach (string img in images)
                {
                    string extension = Path.GetExtension(img);
                    list.Add("Images/Product/" + getUniqueID() + extension);
                }
                return list.ToArray();
            }

            // Get ListBox items as comma-separated string
            public static string getItemWithCommaSeparated(ListBox listBox)
            {
                var selectedTexts = listBox.GetSelectedIndices()
                                           .Select(i => listBox.Items[i].Text);
                return string.Join(",", selectedTexts);
            }
        }
    }
}
