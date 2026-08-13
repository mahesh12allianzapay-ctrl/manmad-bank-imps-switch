
using System;
using System.Configuration;
using System.Data.SqlClient;

namespace WebApplication2
{
    public partial class BalanceEnquiry : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Temporary Customer ID
                // Later replace this with Session["CustomerID"]

                lblCustomerID.Text = "10001";

                LoadBalance();
            }
        }

        private void LoadBalance()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                        CustomerID,
                        AccountNumber,
                        CustomerName,
                        AccountType,
                        AvailableBalance,
                        LedgerBalance
                    FROM Accounts
                    WHERE CustomerID = @CustomerID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue(
                        "@CustomerID",
                        lblCustomerID.Text.Trim()
                    );

                    try
                    {
                        con.Open();

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                lblCustomerID.Text =
                                    dr["CustomerID"].ToString();

                                lblAccountNumber.Text =
                                    dr["AccountNumber"].ToString();

                                lblCustomerName.Text =
                                    dr["CustomerName"].ToString();

                                lblAccountType.Text =
                                    dr["AccountType"].ToString();

                                // Available Balance
                                if (dr["AvailableBalance"] != DBNull.Value)
                                {
                                    lblAvailableBalance.Text =
                                        Convert.ToDecimal(
                                            dr["AvailableBalance"]
                                        ).ToString("N2");
                                }
                                else
                                {
                                    lblAvailableBalance.Text = "0.00";
                                }

                                // Ledger Balance
                                if (dr["LedgerBalance"] != DBNull.Value)
                                {
                                    lblLedgerBalance.Text =
                                        Convert.ToDecimal(
                                            dr["LedgerBalance"]
                                        ).ToString("N2");
                                }
                                else
                                {
                                    lblLedgerBalance.Text = "0.00";
                                }

                                // LastUpdated column is not required
                                lblLastUpdated.Text =
                                    DateTime.Now.ToString(
                                        "dd-MMM-yyyy hh:mm:ss tt"
                                    );
                            }
                            else
                            {
                                ClearControls();

                                ClientScript.RegisterStartupScript(
                                    this.GetType(),
                                    "msg",
                                    "alert('No account found for Customer ID 10001.');",
                                    true
                                );
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ClearControls();

                        string message = ex.Message
                            .Replace("\\", "\\\\")
                            .Replace("'", "\\'")
                            .Replace("\r", "")
                            .Replace("\n", " ");

                        ClientScript.RegisterStartupScript(
                            this.GetType(),
                            "error",
                            "alert('Database error: " + message + "');",
                            true
                        );
                    }
                }
            }
        }

        private void ClearControls()
        {
            lblCustomerID.Text = "";
            lblAccountNumber.Text = "";
            lblCustomerName.Text = "";
            lblAccountType.Text = "";
            lblAvailableBalance.Text = "";
            lblLedgerBalance.Text = "";
            lblLastUpdated.Text = "";
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadBalance();

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "msg",
                "alert('Balance refreshed successfully.');",
                true
            );
        }
    }
}

