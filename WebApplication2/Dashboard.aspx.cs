using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebApplication2
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private readonly string conStr =
            ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ============================================================
            // SESSION VALIDATION
            // ============================================================

            if (Session["CustomerID"] == null)
            {
                Response.Redirect("Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // ============================================================
            // LOAD DASHBOARD
            // ============================================================

            if (!IsPostBack)
            {
                LoadDashboard();
            }
        }

        // ============================================================
        // LOAD DASHBOARD
        // ============================================================

        private void LoadDashboard()
        {
            string customerId = Session["CustomerID"].ToString().Trim();

            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();

                    LoadAccountDetails(con, customerId);

                    LoadTransactionSummary(con, customerId);

                    LoadRecentTransactions(con, customerId);
                }
            }
            catch (Exception)
            {
                // Do not show database details to the customer.

                lblCustomerName.Text = "Unable to load";
                lblAccountNumber.Text = "Unable to load";
                lblAccountType.Text = "Unable to load";
                lblBalance.Text = "0.00";

                lblTodayTxn.Text = "0";
                lblTodayAmount.Text = "0.00";
                lblSuccessTxn.Text = "0";
                lblPendingTxn.Text = "0";
                lblFailedTxn.Text = "0";

                gvTransactions.DataSource = null;
                gvTransactions.DataBind();
            }
        }

        // ============================================================
        // ACCOUNT DETAILS
        // ============================================================

        private void LoadAccountDetails(
            SqlConnection con,
            string customerId)
        {
            const string query = @"
                SELECT TOP 1
                    CustomerID,
                    CustomerName,
                    AccountNumber,
                    AccountType,
                    Balance
                FROM Accounts
                WHERE CustomerID = @CustomerID;";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@CustomerID", SqlDbType.VarChar, 50)
                    .Value = customerId;

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        lblCustomerID.Text =
                            dr["CustomerID"].ToString();

                        lblCustomerName.Text =
                            dr["CustomerName"].ToString();

                        string accountNumber =
                            dr["AccountNumber"].ToString();

                        lblAccountNumber.Text =
                            MaskAccountNumber(accountNumber);

                        lblAccountType.Text =
                            dr["AccountType"].ToString();

                        if (dr["Balance"] != DBNull.Value)
                        {
                            decimal balance =
                                Convert.ToDecimal(dr["Balance"]);

                            lblBalance.Text =
                                balance.ToString("N2");
                        }
                        else
                        {
                            lblBalance.Text = "0.00";
                        }
                    }
                    else
                    {
                        lblCustomerID.Text = customerId;
                        lblCustomerName.Text = "Customer";
                        lblAccountNumber.Text = "Not Available";
                        lblAccountType.Text = "Not Available";
                        lblBalance.Text = "0.00";
                    }
                }
            }
        }

        // ============================================================
        // TRANSACTION SUMMARY
        // ============================================================

        private void LoadTransactionSummary(
            SqlConnection con,
            string customerId)
        {
            const string query = @"
                SELECT
                    COUNT(*) AS TodayTxn,

                    ISNULL(SUM(Amount), 0) AS TodayAmount,

                    ISNULL(
                        SUM(
                            CASE
                                WHEN UPPER(Status) = 'SUCCESS'
                                THEN 1
                                ELSE 0
                            END
                        ), 0
                    ) AS SuccessTxn,

                    ISNULL(
                        SUM(
                            CASE
                                WHEN UPPER(Status) = 'PENDING'
                                THEN 1
                                ELSE 0
                            END
                        ), 0
                    ) AS PendingTxn,

                    ISNULL(
                        SUM(
                            CASE
                                WHEN UPPER(Status) = 'FAILED'
                                  OR UPPER(Status) = 'FAILURE'
                                THEN 1
                                ELSE 0
                            END
                        ), 0
                    ) AS FailedTxn

                FROM IMPSTransactions

                WHERE CustomerID = @CustomerID
                  AND TransactionDate >= CONVERT(date, GETDATE())
                  AND TransactionDate <
                      DATEADD(day, 1, CONVERT(date, GETDATE()));";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@CustomerID", SqlDbType.VarChar, 50)
                    .Value = customerId;

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        lblTodayTxn.Text =
                            Convert.ToInt32(dr["TodayTxn"]).ToString();

                        lblTodayAmount.Text =
                            Convert.ToDecimal(
                                dr["TodayAmount"]
                            ).ToString("N2");

                        lblSuccessTxn.Text =
                            Convert.ToInt32(
                                dr["SuccessTxn"]
                            ).ToString();

                        lblPendingTxn.Text =
                            Convert.ToInt32(
                                dr["PendingTxn"]
                            ).ToString();

                        lblFailedTxn.Text =
                            Convert.ToInt32(
                                dr["FailedTxn"]
                            ).ToString();
                    }
                    else
                    {
                        lblTodayTxn.Text = "0";
                        lblTodayAmount.Text = "0.00";
                        lblSuccessTxn.Text = "0";
                        lblPendingTxn.Text = "0";
                        lblFailedTxn.Text = "0";
                    }
                }
            }
        }

        // ============================================================
        // RECENT TRANSACTIONS
        // ============================================================

        private void LoadRecentTransactions(
            SqlConnection con,
            string customerId)
        {
            const string query = @"
                SELECT TOP 10
                    TransactionID,
                    BeneficiaryName,
                    Amount,
                    Status,
                    TransactionDate
                FROM IMPSTransactions
                WHERE CustomerID = @CustomerID
                ORDER BY TransactionDate DESC;";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@CustomerID", SqlDbType.VarChar, 50)
                    .Value = customerId;

                using (SqlDataAdapter da =
                    new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();

                    da.Fill(dt);

                    gvTransactions.DataSource = dt;
                    gvTransactions.DataBind();
                }
            }
        }

        // ============================================================
        // MASK ACCOUNT NUMBER
        // ============================================================

        private string MaskAccountNumber(string accountNumber)
        {
            if (string.IsNullOrWhiteSpace(accountNumber))
            {
                return "Not Available";
            }

            accountNumber = accountNumber.Trim();

            if (accountNumber.Length <= 4)
            {
                return accountNumber;
            }

            string lastFour =
                accountNumber.Substring(
                    accountNumber.Length - 4
                );

            return new string(
                '*',
                accountNumber.Length - 4
            ) + lastFour;
        }
    }
}