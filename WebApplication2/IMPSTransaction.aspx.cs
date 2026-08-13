using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace WebApplication2
{
    public partial class IMPSTransaction : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ============================================================
            // SESSION CHECK
            // ============================================================

            if (Session["CustomerID"] == null)
            {
                Response.Redirect("Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // ============================================================
            // ROLE-BASED AUTHORIZATION
            // ============================================================

            if (!HasPageAccess("IMPSTransaction"))
            {
                Response.Redirect("Dashboard.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // ============================================================
            // FIRST PAGE LOAD
            // ============================================================

            if (!IsPostBack)
            {
                txtCustomerID.Text =
                    Session["CustomerID"].ToString();

                lblMessage.Text = "";
            }
        }

        // ============================================================
        // ROLE PERMISSION CHECK
        // ============================================================

        private bool HasPageAccess(string pageName)
        {
            if (Session["Role"] == null)
            {
                return false;
            }

            string role =
                Session["Role"].ToString().Trim();

            using (SqlConnection con =
                   new SqlConnection(cs))
            {
                string query = @"
                    SELECT CanAccess
                    FROM RolePermissions
                    WHERE Role = @Role
                      AND PageName = @PageName";

                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@Role",
                        SqlDbType.VarChar,
                        50
                    ).Value = role;

                    cmd.Parameters.Add(
                        "@PageName",
                        SqlDbType.VarChar,
                        100
                    ).Value = pageName;

                    con.Open();

                    object result =
                        cmd.ExecuteScalar();

                    if (result == null ||
                        result == DBNull.Value)
                    {
                        return false;
                    }

                    return Convert.ToBoolean(result);
                }
            }
        }

        // ============================================================
        // IMPS TRANSFER
        // ============================================================

        protected void btnTransfer_Click(
            object sender,
            EventArgs e)
        {
            lblMessage.Text = "";

            // ------------------------------------------------------------
            // SESSION CHECK AGAIN
            // ------------------------------------------------------------

            if (Session["CustomerID"] == null)
            {
                Response.Redirect("Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // ------------------------------------------------------------
            // ROLE CHECK AGAIN
            // ------------------------------------------------------------

            if (!HasPageAccess("IMPSTransaction"))
            {
                Response.Redirect("Dashboard.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            string customerId =
                Session["CustomerID"].ToString().Trim();

            string beneficiaryName =
                txtBeneficiary.Text.Trim();

            string accountNumber =
                txtAccount.Text.Trim();

            string confirmAccount =
                txtConfirmAccount.Text.Trim();

            string ifscCode =
                txtIFSC.Text.Trim().ToUpper();

            string amountText =
                txtAmount.Text.Trim();

            string remarks =
                txtRemarks.Text.Trim();

            // ============================================================
            // VALIDATION
            // ============================================================

            // Beneficiary Name
            if (string.IsNullOrWhiteSpace(beneficiaryName))
            {
                ShowMessage("Please enter beneficiary name.");
                return;
            }

            if (beneficiaryName.Length > 100)
            {
                ShowMessage(
                    "Beneficiary name cannot exceed 100 characters."
                );
                return;
            }

            // Account Number
            if (string.IsNullOrWhiteSpace(accountNumber))
            {
                ShowMessage("Please enter beneficiary account number.");
                return;
            }

            if (!Regex.IsMatch(
                accountNumber,
                @"^[0-9]{9,20}$"))
            {
                ShowMessage(
                    "Account number must contain 9 to 20 digits."
                );
                return;
            }

            // Confirm Account
            if (string.IsNullOrWhiteSpace(confirmAccount))
            {
                ShowMessage(
                    "Please confirm beneficiary account number."
                );
                return;
            }

            if (accountNumber != confirmAccount)
            {
                ShowMessage(
                    "Account number and confirm account number do not match."
                );
                return;
            }

            // IFSC
            if (string.IsNullOrWhiteSpace(ifscCode))
            {
                ShowMessage("Please enter IFSC code.");
                return;
            }

            if (!Regex.IsMatch(
                ifscCode,
                @"^[A-Z]{4}0[A-Z0-9]{6}$"))
            {
                ShowMessage(
                    "Please enter a valid 11-character IFSC code."
                );
                return;
            }

            // Amount
            decimal amount;

            if (!decimal.TryParse(
                amountText,
                out amount))
            {
                ShowMessage(
                    "Please enter a valid amount."
                );
                return;
            }

            if (amount <= 0)
            {
                ShowMessage(
                    "Amount must be greater than zero."
                );
                return;
            }

            if (amount > 200000)
            {
                ShowMessage(
                    "IMPS transfer amount cannot exceed ₹2,00,000."
                );
                return;
            }

            // Remarks
            if (remarks.Length > 250)
            {
                ShowMessage(
                    "Remarks cannot exceed 250 characters."
                );
                return;
            }

            // ============================================================
            // INSERT TRANSACTION
            // ============================================================

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    string query = @"
            INSERT INTO IMPSTransactions
            (
                CustomerID,
                BeneficiaryName,
                AccountNumber,
                IFSCCode,
                Amount,
                Remarks,
                TransactionDate
            )
            VALUES
            (
                @CustomerID,
                @BeneficiaryName,
                @AccountNumber,
                @IFSCCode,
                @Amount,
                @Remarks,
                GETDATE()
            );

            SELECT CAST(SCOPE_IDENTITY() AS INT);
        ";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.Add("@CustomerID", SqlDbType.VarChar, 50)
                            .Value = customerId;

                        cmd.Parameters.Add("@BeneficiaryName", SqlDbType.VarChar, 100)
                            .Value = beneficiaryName;

                        cmd.Parameters.Add("@AccountNumber", SqlDbType.VarChar, 25)
                            .Value = accountNumber;

                        cmd.Parameters.Add("@IFSCCode", SqlDbType.VarChar, 20)
                            .Value = ifscCode;

                        SqlParameter amountParameter =
                            cmd.Parameters.Add("@Amount", SqlDbType.Decimal);

                        amountParameter.Precision = 18;
                        amountParameter.Scale = 2;
                        amountParameter.Value = amount;

                        cmd.Parameters.Add("@Remarks", SqlDbType.VarChar, 250)
                            .Value = string.IsNullOrEmpty(remarks)
                                ? (object)DBNull.Value
                                : remarks;

                        int transactionId =
                            Convert.ToInt32(cmd.ExecuteScalar());

                        lblMessage.Text =
                            "IMPS transaction created successfully. " +
                            "Transaction ID: " + transactionId;

                        ClearForm();
                    }
                }
            }
            catch (SqlException ex)
            {
                ShowMessage("Database error: " + ex.Message);
            }
            catch (Exception ex)
            {
                ShowMessage("Unable to process transaction: " + ex.Message);
            }
        }

        // ============================================================
        // TRANSACTION ID
        // ============================================================

        private string GenerateTransactionId()
        {
            return "IMPS" +
                   DateTime.Now.ToString("yyyyMMddHHmmssfff");
        }

        // ============================================================
        // CLEAR FORM
        // ============================================================

        private void ClearForm()
        {
            txtBeneficiary.Text = "";
            txtAccount.Text = "";
            txtConfirmAccount.Text = "";
            txtIFSC.Text = "";
            txtAmount.Text = "";
            txtRemarks.Text = "";

            txtCustomerID.Text =
                Session["CustomerID"].ToString();
        }

        // ============================================================
        // MESSAGE
        // ============================================================

        private void ShowMessage(string message)
        {
            lblMessage.Text = message;
        }
    }
}