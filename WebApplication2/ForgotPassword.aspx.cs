using System;
using System.Configuration;
using System.Data.SqlClient;

namespace WebApplication2
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlVerifyCustomer.Visible = true;
                pnlOTP.Visible = false;
                pnlResetPassword.Visible = false;

                lblMessage.Text = "";
            }
        }

        protected void btnVerifyCustomer_Click(object sender, EventArgs e)
        {
            string customerId = txtCustomerID.Text.Trim();
            string email = txtEmail.Text.Trim();

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = @"SELECT *
                                 FROM Users
                                 WHERE CustomerID=@CustomerID
                                 AND Email=@Email
                                 AND IsActive=1";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@CustomerID", customerId);
                cmd.Parameters.AddWithValue("@Email", email);

                SqlDataReader dr = cmd.ExecuteReader();

                if (!dr.Read())
                {
                    lblMessage.Text = "Invalid Customer ID or Email.";
                    dr.Close();
                    return;
                }

                dr.Close();

                Random random = new Random();

                string otp = random.Next(100000, 999999).ToString();

                DateTime expiry = DateTime.Now.AddMinutes(10);

                SqlCommand insertOTP = new SqlCommand(
                @"INSERT INTO PasswordResetOTP
                (
                    CustomerID,
                    OTP,
                    ExpiryTime,
                    IsUsed
                )
                VALUES
                (
                    @CustomerID,
                    @OTP,
                    @ExpiryTime,
                    0
                )", con);

                insertOTP.Parameters.AddWithValue("@CustomerID", customerId);
                insertOTP.Parameters.AddWithValue("@OTP", otp);
                insertOTP.Parameters.AddWithValue("@ExpiryTime", expiry);

                insertOTP.ExecuteNonQuery();

                Session["ResetCustomerID"] = customerId;

                pnlVerifyCustomer.Visible = false;
                pnlOTP.Visible = true;

                // For Development Only
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "OTP Generated Successfully. OTP : " + otp;
            }
        }
        protected void btnVerifyOTP_Click(object sender, EventArgs e)
        {
            string customerId = Session["ResetCustomerID"].ToString();
            string otp = txtOTP.Text.Trim();

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = @"SELECT *
                                 FROM PasswordResetOTP
                                 WHERE CustomerID=@CustomerID
                                 AND OTP=@OTP
                                 AND IsUsed=0
                                 AND ExpiryTime>=GETDATE()";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@CustomerID", customerId);
                cmd.Parameters.AddWithValue("@OTP", otp);

                SqlDataReader dr = cmd.ExecuteReader();

                if (!dr.Read())
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Invalid or Expired OTP.";
                    dr.Close();
                    return;
                }

                dr.Close();

                pnlOTP.Visible = false;
                pnlResetPassword.Visible = true;

                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "OTP Verified Successfully.";
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            string customerId = Session["ResetCustomerID"].ToString();

            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (newPassword != confirmPassword)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Passwords do not match.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand updatePassword = new SqlCommand(
                @"UPDATE Users
                  SET Password=@Password,
                      PasswordChangedOn=GETDATE(),
                      ForcePasswordChange=0,
                      FailedLoginAttempts=0,
                      IsLocked=0
                  WHERE CustomerID=@CustomerID", con);

                updatePassword.Parameters.AddWithValue("@Password", newPassword);
                updatePassword.Parameters.AddWithValue("@CustomerID", customerId);

                updatePassword.ExecuteNonQuery();

                SqlCommand updateOTP = new SqlCommand(
                @"UPDATE PasswordResetOTP
                  SET IsUsed=1
                  WHERE CustomerID=@CustomerID
                  AND IsUsed=0", con);

                updateOTP.Parameters.AddWithValue("@CustomerID", customerId);

                updateOTP.ExecuteNonQuery();

                Session.Remove("ResetCustomerID");

                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Password changed successfully. Redirecting to Login...";

                Response.AddHeader("REFRESH", "3;URL=Login.aspx");
            }
        }
    }
}