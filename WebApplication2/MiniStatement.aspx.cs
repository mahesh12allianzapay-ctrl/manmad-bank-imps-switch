using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebApplication2
{
    public partial class MiniStatement1 : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Temporary Customer ID
                // Later this will come from Session after Login
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
                    SqlCommand cmd = new SqlCommand(
                        "SELECT AccountNumber FROM Accounts WHERE CustomerID=@CustomerID", con);

                    cmd.Parameters.AddWithValue("@CustomerID", lblCustomerID.Text);

                    object accountNo = cmd.ExecuteScalar();

                    if (accountNo != null)
                    {
                        lblAccountNumber.Text = accountNo.ToString();
                    }
                    else
                    {
                        lblAccountNumber.Text = "";
                    }

                    // Get Last 10 Transactions
                    SqlDataAdapter da = new SqlDataAdapter(
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
                          WHERE CustomerID=@CustomerID
                          ORDER BY TransactionDate DESC", con);

                    da.SelectCommand.Parameters.AddWithValue("@CustomerID", lblCustomerID.Text);

                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvStatement.DataSource = dt;
                    gvStatement.DataBind();
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "msg",
                        "alert('Error : " + ex.Message.Replace("'", "") + "');",
                        true);
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
                true);
        }
    }
}