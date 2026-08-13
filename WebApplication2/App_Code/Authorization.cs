using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace WebApplication2
{
    public static class AuthorizationHelper
    {
        private static readonly string cs =
            ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        public static bool HasAccess(string pageName)
        {
            // Check session
            if (HttpContext.Current == null ||
                HttpContext.Current.Session == null)
            {
                return false;
            }

            // Check role
            if (HttpContext.Current.Session["Role"] == null)
            {
                return false;
            }

            string role =
                HttpContext.Current.Session["Role"].ToString().Trim();

            if (string.IsNullOrEmpty(role))
            {
                return false;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT CanAccess
                    FROM RolePermissions
                    WHERE Role = @Role
                      AND PageName = @PageName";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Role", role);
                    cmd.Parameters.AddWithValue("@PageName", pageName);

                    con.Open();

                    object result = cmd.ExecuteScalar();

                    if (result == null || result == DBNull.Value)
                    {
                        return false;
                    }

                    return Convert.ToBoolean(result);
                }
            }
        }
    }
}