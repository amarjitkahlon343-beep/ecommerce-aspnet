using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

namespace Ecomwebsite
{
    public class DBconnect
    {
        private MySqlConnection con;

        // ✅ CONSTRUCTOR
        public DBconnect()
        {
            con = new MySqlConnection(
                ConfigurationManager.ConnectionStrings["cs"].ConnectionString
            );
        }

        public MySqlConnection GetCon()
        {
            return con;
        }

        public void OpenCon()
        {
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
        }

        public void CloseCon()
        {
            if (con.State == ConnectionState.Open)
            { con.Close(); }
        }

        public DataTable Load_Data(MySqlCommand cmd)
        {
            DataTable dt = new DataTable();
            try
            {
                MySqlConnection con = GetCon(); // Get the connection
                if (con.State == ConnectionState.Closed)
                {
                    con.Open(); // Open it!
                }
                cmd.Connection = con; // Assign it to the command

                using (MySqlDataAdapter da = new MySqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                // This will now catch and show you the real error
                System.Diagnostics.Debug.WriteLine("Error in Load_Data: " + ex.Message);
                throw ex;
            }
            finally
            {
                CloseCon();
            }
            return dt;
        }
        public bool InsertUpdateData(MySqlCommand cmd)
        {
            try
            {
                if (cmd.Connection.State == ConnectionState.Closed)
                    cmd.Connection.Open();

                int result = cmd.ExecuteNonQuery();

                // Use a using statement or finally block for closing connections 
                // to prevent leaks if an error occurs.
                cmd.Connection.Close();

                // If it's an INSERT, result should be 1. 
                // If it's 0, the SQL executed but nothing happened.
                return result > 0;
            }
            catch (MySqlException ex)
            {
                // LOG THIS ERROR: This will tell you if it's a 
                // Foreign Key violation, Data too long, or Null constraint.
                System.Diagnostics.Debug.WriteLine("MySQL Error: " + ex.Message);

                if (cmd.Connection.State == ConnectionState.Open)
                    cmd.Connection.Close();

                throw; // Re-throw so your InsertBookFine catch block can catch it
            }
        }
        public bool Execute_Query(MySqlCommand cmd)
        {
            try
            {
                // Ensure the command uses the connection from this class
                cmd.Connection = con;
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                int result = cmd.ExecuteNonQuery();
                con.Close();

                return result > 0; // Returns true if at least one row was affected
            }
            catch (Exception ex)
            {
                // Log the error or handle it as needed
                if (con.State == ConnectionState.Open) con.Close();
                return false;
            }
        }
    }
}