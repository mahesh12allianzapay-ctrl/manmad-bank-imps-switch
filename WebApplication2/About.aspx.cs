using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebApplication2
{
    public partial class Login : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager
            .ConnectionStrings["BankDB"]
            .ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
                lblAttempts.Text = "";

                LoadRememberedCustomer();
            }
        }


        // ============================================================
        // LOGIN
        // ============================================================

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblAttempts.Text = "";

            Page.Validate();

            if (!Page.IsValid)
            {
                return;
            }


            string customerId = txtUser.Text.Trim();
            string password = txtPassword.Text;


            if (string.IsNullOrWhiteSpace(customerId) ||
                string.IsNullOrWhiteSpace(password))
            {
                lblMessage.Text =
                    "Please enter your Customer ID and Password.";

                return;
            }


            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();


                string query = @"
                    SELECT
                        Id,
                        CustomerID,
                        UserName,
                        Password,
                        Role,
                        IsActive,
                        IsLocked,
                        FailedLoginAttempts,
                        ForcePasswordChange
                    FROM Users
                    WHERE CustomerID = @CustomerID";


                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@CustomerID",
                        SqlDbType.VarChar,
                        50
                    ).Value = customerId;


                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        // =================================================
                        // USER NOT FOUND
                        // =================================================

                        if (!dr.Read())
                        {
                            lblMessage.Text =
                                "Invalid Customer ID or Password.";

                            return;
                        }


                        int id =
                            Convert.ToInt32(dr["Id"]);


                        string dbPassword =
                            dr["Password"].ToString();


                        string userName =
                            dr["UserName"].ToString();


                        string role =
                            dr["Role"].ToString().Trim();


                        bool isActive =
                            Convert.ToBoolean(
                                dr["IsActive"]
                            );


                        bool isLocked =
                            Convert.ToBoolean(
                                dr["IsLocked"]
                            );


                        int failedAttempts =
                            Convert.ToInt32(
                                dr["FailedLoginAttempts"]
                            );


                        bool forcePasswordChange =
                            Convert.ToBoolean(
                                dr["ForcePasswordChange"]
                            );


                        // =================================================
                        // ACCOUNT ACTIVE CHECK
                        // =================================================

                        if (!isActive)
                        {
                            lblMessage.Text =
                                "Your account is currently inactive. " +
                                "Please contact the bank.";

                            return;
                        }


                        // =================================================
                        // ACCOUNT LOCK CHECK
                        // =================================================

                        if (isLocked)
                        {
                            lblMessage.Text =
                                "Your account is locked due to multiple " +
                                "failed login attempts.";

                            lblAttempts.Text =
                                "Please contact the administrator to unlock your account.";

                            return;
                        }


                        // =================================================
                        // PASSWORD CHECK
                        // =================================================

                        if (password != dbPassword)
                        {
                            failedAttempts++;

                            bool lockAccount =
                                failedAttempts >= 3;


                            dr.Close();


                            using (SqlCommand updateFail =
                                new SqlCommand(
                                    @"
                                    UPDATE Users
                                    SET
                                        FailedLoginAttempts = @Attempts,
                                        IsLocked = @Locked
                                    WHERE Id = @Id",
                                    con))
                            {
                                updateFail.Parameters.Add(
                                    "@Attempts",
                                    SqlDbType.Int
                                ).Value = failedAttempts;


                                updateFail.Parameters.Add(
                                    "@Locked",
                                    SqlDbType.Bit
                                ).Value = lockAccount;


                                updateFail.Parameters.Add(
                                    "@Id",
                                    SqlDbType.Int
                                ).Value = id;


                                updateFail.ExecuteNonQuery();
                            }


                            // =============================================
                            // ACCOUNT LOCKED
                            // =============================================

                            if (lockAccount)
                            {
                                lblMessage.Text =
                                    "Your account has been locked after " +
                                    "3 failed login attempts.";

                                lblAttempts.Text =
                                    "Please contact the administrator.";
                            }
                            else
                            {
                                int remaining =
                                    3 - failedAttempts;


                                lblMessage.Text =
                                    "Invalid Customer ID or Password.";


                                lblAttempts.Text =
                                    "Remaining attempts: " +
                                    remaining;
                            }


                            return;
                        }


                        // =================================================
                        // SUCCESSFUL LOGIN
                        // =================================================

                        dr.Close();


                        using (SqlCommand successCmd =
                            new SqlCommand(
                                @"
                                UPDATE Users
                                SET
                                    FailedLoginAttempts = 0,
                                    IsLocked = 0,
                                    LastLogin = GETDATE()
                                WHERE Id = @Id",
                                con))
                        {
                            successCmd.Parameters.Add(
                                "@Id",
                                SqlDbType.Int
                            ).Value = id;


                            successCmd.ExecuteNonQuery();
                        }


                        // =================================================
                        // REMEMBER CUSTOMER ID
                        // =================================================

                        SaveRememberedCustomer(customerId);


                        // =================================================
                        // CLEAR OLD SESSION
                        // =================================================

                        Session.Clear();


                        // =================================================
                        // CREATE SESSION
                        // =================================================

                        Session["UserId"] = id;

                        Session["CustomerID"] =
                            customerId;

                        Session["UserName"] =
                            userName;

                        Session["Role"] =
                            role;


                        // =================================================
                        // FORCE PASSWORD CHANGE
                        // =================================================

                        if (forcePasswordChange)
                        {
                            Session["ForcePasswordChange"] =
                                true;
                        }
                        else
                        {
                            Session["ForcePasswordChange"] =
                                false;
                        }


                        // =================================================
                        // REDIRECT TO DASHBOARD
                        // =================================================

                        Response.Redirect(
                            "Dashboard.aspx",
                            false
                        );

                        Context.ApplicationInstance
                            .CompleteRequest();
                    }
                }
            }
        }


        // ============================================================
        // REMEMBER CUSTOMER ID
        // ============================================================

        private void SaveRememberedCustomer(string customerId)
        {
            if (chkRemember.Checked)
            {
                Response.Cookies["ManmadBankCustomerID"].Value =
                    customerId;

                Response.Cookies["ManmadBankCustomerID"].Expires =
                    DateTime.Now.AddDays(30);
            }
            else
            {
                if (Request.Cookies["ManmadBankCustomerID"] != null)
                {
                    Response.Cookies["ManmadBankCustomerID"].Expires =
                        DateTime.Now.AddDays(-1);
                }
            }
        }


        // ============================================================
        // LOAD REMEMBERED CUSTOMER ID
        // ============================================================

        private void LoadRememberedCustomer()
        {
            if (Request.Cookies["ManmadBankCustomerID"] != null)
            {
                string savedCustomerId =
                    Request.Cookies["ManmadBankCustomerID"].Value;


                if (!string.IsNullOrEmpty(savedCustomerId))
                {
                    txtUser.Text =
                        savedCustomerId;

                    chkRemember.Checked =
                        true;
                }
            }
        }
    }
}