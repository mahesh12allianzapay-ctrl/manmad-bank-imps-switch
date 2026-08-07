using System;
using System.Configuration;
using System.Data.SqlClient;

namespace WebApplication2
{
    public partial class Login : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
                lblAttempts.Text = "";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblAttempts.Text = "";

            string customerId = txtUser.Text.Trim();
            string password = txtPassword.Text.Trim();

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = @"SELECT *
                                 FROM Users
                                 WHERE CustomerID=@CustomerID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CustomerID", customerId);

                SqlDataReader dr = cmd.ExecuteReader();

                if (!dr.Read())
                {
                    lblMessage.Text = "Invalid Customer ID.";
                    dr.Close();
                    return;
                }

                int id = Convert.ToInt32(dr["Id"]);
                string dbPassword = dr["Password"].ToString();
                string userName = dr["UserName"].ToString();
                string role = dr["Role"].ToString();

                bool isActive = Convert.ToBoolean(dr["IsActive"]);
                bool isLocked = Convert.ToBoolean(dr["IsLocked"]);
                int failedAttempts = Convert.ToInt32(dr["FailedLoginAttempts"]);

                dr.Close();

                // Check Active
                if (!isActive)
                {
                    lblMessage.Text = "Your account is inactive. Please contact the bank.";
                    return;
                }

                // Check Locked
                if (isLocked)
                {
                    lblMessage.Text = "Your account has been locked.";
                    return;
                }

                // Password Check
                if (password != dbPassword)
                {
                    failedAttempts++;

                    bool lockAccount = failedAttempts >= 3;

                    SqlCommand updateFail = new SqlCommand(
                        @"UPDATE Users
                          SET FailedLoginAttempts=@Attempts,
                              IsLocked=@Locked
                          WHERE Id=@Id", con);

                    updateFail.Parameters.AddWithValue("@Attempts", failedAttempts);
                    updateFail.Parameters.AddWithValue("@Locked", lockAccount);
                    updateFail.Parameters.AddWithValue("@Id", id);

                    updateFail.ExecuteNonQuery();

                    if (lockAccount)
                    {
                        lblMessage.Text = "Your account has been locked after 3 failed attempts.";
                    }
                    else
                    {
                        lblMessage.Text = "Invalid Password.";
                        lblAttempts.Text = "Attempt " + failedAttempts + " of 3";
                    }

                    return;
                }

                // Successful Login

                SqlCommand successCmd = new SqlCommand(
                    @"UPDATE Users
                      SET FailedLoginAttempts=0,
                          LastLogin=GETDATE()
                      WHERE Id=@Id", con);

                successCmd.Parameters.AddWithValue("@Id", id);

                successCmd.ExecuteNonQuery();

                Session["CustomerID"] = customerId;
                Session["UserName"] = userName;
                Session["Role"] = role;

                Response.Redirect("Dashboard.aspx");
            }
        }
    }
}