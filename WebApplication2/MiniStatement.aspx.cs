
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebApplication2
{
    public partial class MiniStatement1 : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Temporary Customer ID
                // Later replace with Session["CustomerID"]

                lblCustomerID.Text = "10001";

                LoadStatement();
            }
        }

        private void LoadStatement()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                try
                {
                    con.Open();

                    // Get Account Number
                    using (SqlCommand cmd = new SqlCommand(
                        @"SELECT AccountNumber
                          FROM Accounts
                          WHERE CustomerID = @CustomerID", con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@CustomerID",
                            lblCustomerID.Text.Trim()
                        );

                        object accountNo = cmd.ExecuteScalar();

                        if (accountNo != null && accountNo != DBNull.Value)
                        {
                            lblAccountNumber.Text =
                                accountNo.ToString();
                        }
                        else
                        {
                            lblAccountNumber.Text = "";
                        }
                    }

                    // Get last 10 transactions
                    using (SqlDataAdapter da = new SqlDataAdapter(
                        @"SELECT TOP 10
                            TransactionDate,
                            TransactionRefNo,
                            TransactionType,
                            BeneficiaryName,
                            DebitAmount,
                            CreditAmount,
                            Balance,
                            Status
                          FROM Transactions
                          WHERE CustomerID = @CustomerID
                          ORDER BY TransactionDate DESC", con))
                    {
                        da.SelectCommand.Parameters.AddWithValue(
                            "@CustomerID",
                            lblCustomerID.Text.Trim()
                        );

                        DataTable dt = new DataTable();

                        da.Fill(dt);

                        gvStatement.DataSource = dt;
                        gvStatement.DataBind();
                    }
                }
                catch (Exception ex)
                {
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

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadStatement();

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "msg",
                "alert('Mini Statement refreshed successfully.');",
                true
            );
        }
    }
}
