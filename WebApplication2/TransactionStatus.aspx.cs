using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Connect
{
    public partial class TransactionStatus : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                @"SELECT * FROM Transactions
                  WHERE TransactionRefNo=@RefNo", con);

                cmd.Parameters.AddWithValue("@RefNo", txtReferenceNo.Text.Trim());

                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblCustomerID.Text = dr["CustomerID"].ToString();
                    lblBeneficiary.Text = dr["BeneficiaryName"].ToString();
                    lblAccountNo.Text = dr["BeneficiaryAccountNo"].ToString();
                    lblIFSC.Text = dr["IFSCCode"].ToString();
                    lblAmount.Text = dr["Amount"].ToString();
                    lblType.Text = dr["TransactionType"].ToString();
                    lblStatus.Text = dr["Status"].ToString();
                    lblDate.Text = Convert.ToDateTime(dr["TransactionDate"]).ToString("dd-MMM-yyyy HH:mm");
                    lblRemarks.Text = dr["Remarks"].ToString();
                }
                else
                {
                    ClearLabels();

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "msg",
                        "alert('Transaction not found');",
                        true);
                }

                dr.Close();
            }
        }

        private void ClearLabels()
        {
            lblCustomerID.Text = "";
            lblBeneficiary.Text = "";
            lblAccountNo.Text = "";
            lblIFSC.Text = "";
            lblAmount.Text = "";
            lblType.Text = "";
            lblStatus.Text = "";
            lblDate.Text = "";
            lblRemarks.Text = "";
        }
    }
}