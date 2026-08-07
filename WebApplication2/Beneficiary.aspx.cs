using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Connect
{
    public partial class Beneficiary : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Temporary Customer ID
                // Later we will get it from Session after login
                lblCustomerID.Text = "10001";

                LoadBeneficiaries();
            }
        }

        private void LoadBeneficiaries()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT * FROM Beneficiaries WHERE CustomerID=@CustomerID ORDER BY BeneficiaryID DESC",
                    con);

                da.SelectCommand.Parameters.AddWithValue("@CustomerID", lblCustomerID.Text);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvBeneficiary.DataSource = dt;
                gvBeneficiary.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (txtBeneficiaryName.Text.Trim() == "")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "msg", "alert('Enter Beneficiary Name');", true);
                return;
            }

            if (txtAccountNumber.Text.Trim() == "")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "msg", "alert('Enter Account Number');", true);
                return;
            }

            if (txtAccountNumber.Text != txtConfirmAccount.Text)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "msg", "alert('Account Number and Confirm Account Number do not match');", true);
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(@"
INSERT INTO Beneficiaries
(
CustomerID,
BeneficiaryName,
AccountNumber,
IFSCCode,
BankName,
BranchName,
NickName,
MobileNumber,
EmailID
)
VALUES
(
@CustomerID,
@BeneficiaryName,
@AccountNumber,
@IFSCCode,
@BankName,
@BranchName,
@NickName,
@MobileNumber,
@EmailID
)", con);

                cmd.Parameters.AddWithValue("@CustomerID", lblCustomerID.Text);
                cmd.Parameters.AddWithValue("@BeneficiaryName", txtBeneficiaryName.Text.Trim());
                cmd.Parameters.AddWithValue("@AccountNumber", txtAccountNumber.Text.Trim());
                cmd.Parameters.AddWithValue("@IFSCCode", txtIFSC.Text.Trim());
                cmd.Parameters.AddWithValue("@BankName", txtBankName.Text.Trim());
                cmd.Parameters.AddWithValue("@BranchName", txtBranch.Text.Trim());
                cmd.Parameters.AddWithValue("@NickName", txtNickName.Text.Trim());
                cmd.Parameters.AddWithValue("@MobileNumber", txtMobile.Text.Trim());
                cmd.Parameters.AddWithValue("@EmailID", txtEmail.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            ClearControls();

            LoadBeneficiaries();

            ClientScript.RegisterStartupScript(this.GetType(), "msg", "alert('Beneficiary Added Successfully');", true);
        }

        private void ClearControls()
        {
            txtBeneficiaryName.Text = "";
            txtAccountNumber.Text = "";
            txtConfirmAccount.Text = "";
            txtIFSC.Text = "";
            txtBankName.Text = "";
            txtBranch.Text = "";
            txtNickName.Text = "";
            txtMobile.Text = "";
            txtEmail.Text = "";

            txtBeneficiaryName.Focus();
        }
    }
}