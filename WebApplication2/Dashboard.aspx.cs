using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebApplication2
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CustomerID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadDashboard();
            }
        }

        private void LoadDashboard()
        {
            string customerId = Session["CustomerID"].ToString();

            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();

                // Account Details
                string query = @"SELECT CustomerName,
                                        AccountNumber,
                                        AccountType,
                                        AvailableBalance
                                 FROM Accounts
                                 WHERE CustomerID=@CustomerID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CustomerID", customerId);

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblCustomerID.Text = customerId;
                    lblCustomerName.Text = dr["CustomerName"].ToString();
                    lblAccountNumber.Text = dr["AccountNumber"].ToString();
                    lblAccountType.Text = dr["AccountType"].ToString();
                    lblBalance.Text = Convert.ToDecimal(dr["AvailableBalance"]).ToString("N2");
                }

                dr.Close();

                // Today's Transactions
                string countQuery = @"SELECT COUNT(*)
                                      FROM IMPSTransactions
                                      WHERE CustomerID=@CustomerID
                                      AND CAST(TransactionDate AS DATE)=CAST(GETDATE() AS DATE)";

                SqlCommand cmdCount = new SqlCommand(countQuery, con);
                cmdCount.Parameters.AddWithValue("@CustomerID", customerId);

                lblTodayTxn.Text = cmdCount.ExecuteScalar().ToString();

                // Today's Amount
                string amountQuery = @"SELECT ISNULL(SUM(Amount),0)
                                       FROM IMPSTransactions
                                       WHERE CustomerID=@CustomerID
                                       AND CAST(TransactionDate AS DATE)=CAST(GETDATE() AS DATE)";

                SqlCommand cmdAmount = new SqlCommand(amountQuery, con);
                cmdAmount.Parameters.AddWithValue("@CustomerID", customerId);

                lblTodayAmount.Text = Convert.ToDecimal(cmdAmount.ExecuteScalar()).ToString("N2");

                // Recent Transactions
                string gridQuery = @"SELECT TOP 10
                                        TransactionID,
                                        BeneficiaryName,
                                        Amount,
                                        Status,
                                        TransactionDate
                                     FROM IMPSTransactions
                                     WHERE CustomerID=@CustomerID
                                     ORDER BY TransactionDate DESC";

                SqlDataAdapter da = new SqlDataAdapter(gridQuery, con);
                da.SelectCommand.Parameters.AddWithValue("@CustomerID", customerId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvTransactions.DataSource = dt;
                gvTransactions.DataBind();
            }
        }
    }
}