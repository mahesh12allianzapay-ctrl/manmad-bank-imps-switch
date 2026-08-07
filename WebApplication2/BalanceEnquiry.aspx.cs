using System;
using System.Configuration;
using System.Data.SqlClient;

namespace WebApplication2
{
    public partial class BalanceEnquiry : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Temporary Customer ID
                // Later replace with:
                // lblCustomerID.Text = Session["CustomerID"].ToString();

                lblCustomerID.Text = "10001";

                LoadBalance();
            }
        }

        private void LoadBalance()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    @"SELECT CustomerID,
                             AccountNumber,
                             CustomerName,
                             AccountType,
                             AvailableBalance,
                             LedgerBalance,
                             LastUpdated
                      FROM Accounts
                      WHERE CustomerID=@CustomerID", con);

                cmd.Parameters.AddWithValue("@CustomerID", lblCustomerID.Text);

                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblCustomerID.Text = dr["CustomerID"].ToString();
                    lblAccountNumber.Text = dr["AccountNumber"].ToString();
                    lblCustomerName.Text = dr["CustomerName"].ToString();
                    lblAccountType.Text = dr["AccountType"].ToString();

                    lblAvailableBalance.Text =
                        Convert.ToDecimal(dr["AvailableBalance"]).ToString("N2");

                    lblLedgerBalance.Text =
                        Convert.ToDecimal(dr["LedgerBalance"]).ToString("N2");

                    lblLastUpdated.Text =
                        Convert.ToDateTime(dr["LastUpdated"])
                        .ToString("dd-MMM-yyyy hh:mm:ss tt");
                }
                else
                {
                    ClearControls();

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "msg",
                        "alert('No account found.');",
                        true);
                }

                dr.Close();
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
                true);
        }
    }
}