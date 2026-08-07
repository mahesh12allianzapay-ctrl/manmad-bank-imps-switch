using System;
using System.Configuration;
using System.Data.SqlClient;

namespace WebApplication2
{
	public partial class IMPSTransaction : System.Web.UI.Page
	{
		string conStr = ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				if (Session["CustomerID"] != null)
				{
					txtCustomerID.Text = Session["CustomerID"].ToString();
				}
				else
				{
					Response.Redirect("Login.aspx");
				}
			}
		}

		protected void btnTransfer_Click(object sender, EventArgs e)
		{
			// Check account numbers
			if (txtAccount.Text.Trim() != txtConfirmAccount.Text.Trim())
			{
				lblMessage.ForeColor = System.Drawing.Color.Red;
				lblMessage.Text = "Account numbers do not match.";
				return;
			}

			using (SqlConnection con = new SqlConnection(conStr))
			{
				string query = @"INSERT INTO IMPSTransactions
                                (CustomerID, BeneficiaryName, AccountNumber, IFSCCode, Amount, Remarks)
                                VALUES
                                (@CustomerID, @BeneficiaryName, @AccountNumber, @IFSCCode, @Amount, @Remarks)";

				SqlCommand cmd = new SqlCommand(query, con);

				cmd.Parameters.AddWithValue("@CustomerID", txtCustomerID.Text.Trim());
				cmd.Parameters.AddWithValue("@BeneficiaryName", txtBeneficiary.Text.Trim());
				cmd.Parameters.AddWithValue("@AccountNumber", txtAccount.Text.Trim());
				cmd.Parameters.AddWithValue("@IFSCCode", txtIFSC.Text.Trim());
				cmd.Parameters.AddWithValue("@Amount", Convert.ToDecimal(txtAmount.Text.Trim()));
				cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());

				con.Open();
				cmd.ExecuteNonQuery();

				lblMessage.ForeColor = System.Drawing.Color.Green;
				lblMessage.Text = "IMPS Transaction Successful.";

				// Clear form
				txtBeneficiary.Text = "";
				txtAccount.Text = "";
				txtConfirmAccount.Text = "";
				txtIFSC.Text = "";
				txtAmount.Text = "";
				txtRemarks.Text = "";
			}
		}
	}
}