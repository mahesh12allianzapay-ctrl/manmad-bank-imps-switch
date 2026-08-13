using System;
using System.Configuration;
using System.Data.SqlClient;

namespace WebApplication2
{
    public partial class TransactionStatus : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Nothing required on first page load
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string referenceNo = txtReferenceNo.Text.Trim();

            if (string.IsNullOrEmpty(referenceNo))
            {
                ClearLabels();
                ShowMessage("Please enter Transaction Reference No.");
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                        CustomerID,
                        BeneficiaryName,
                        AccountNumber,
                        DebitAmount,
                        CreditAmount,
                        TransactionType,
                        Status,
                        TransactionDate,
                        Remarks
                    FROM Transactions
                    WHERE TransactionRefNo = @RefNo";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@RefNo", referenceNo);

                    try
                    {
                        con.Open();

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                // Customer ID
                                lblCustomerID.Text =
                                    GetValue(dr, "CustomerID");

                                // Beneficiary Name
                                lblBeneficiary.Text =
                                    GetValue(dr, "BeneficiaryName");

                                // Account Number
                                lblAccountNo.Text =
                                    GetValue(dr, "AccountNumber");

                                // IFSC is not present in Transactions table
                                lblIFSC.Text = "N/A";

                                // Calculate transaction amount
                                decimal debitAmount = 0;
                                decimal creditAmount = 0;

                                if (dr["DebitAmount"] != DBNull.Value)
                                {
                                    debitAmount =
                                        Convert.ToDecimal(
                                            dr["DebitAmount"]);
                                }

                                if (dr["CreditAmount"] != DBNull.Value)
                                {
                                    creditAmount =
                                        Convert.ToDecimal(
                                            dr["CreditAmount"]);
                                }

                                decimal amount;

                                if (debitAmount > 0)
                                {
                                    amount = debitAmount;
                                }
                                else
                                {
                                    amount = creditAmount;
                                }

                                lblAmount.Text =
                                    "₹ " + amount.ToString("N2");

                                // Transaction Type
                                lblType.Text =
                                    GetValue(
                                        dr,
                                        "TransactionType");

                                // Status
                                lblStatus.Text =
                                    GetValue(
                                        dr,
                                        "Status");

                                // Transaction Date
                                if (dr["TransactionDate"] != DBNull.Value)
                                {
                                    lblDate.Text =
                                        Convert.ToDateTime(
                                            dr["TransactionDate"])
                                        .ToString(
                                            "dd-MMM-yyyy HH:mm");
                                }
                                else
                                {
                                    lblDate.Text = "";
                                }

                                // Remarks
                                lblRemarks.Text =
                                    GetValue(
                                        dr,
                                        "Remarks");
                            }
                            else
                            {
                                ClearLabels();

                                ShowMessage(
                                    "Transaction not found.");
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ClearLabels();

                        ShowMessage(
                            "Database error: " +
                            ex.Message);
                    }
                }
            }
        }

        private string GetValue(
            SqlDataReader dr,
            string columnName)
        {
            if (dr[columnName] == DBNull.Value)
            {
                return "";
            }

            return dr[columnName].ToString();
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

        private void ShowMessage(string message)
        {
            string safeMessage = message
                .Replace("\\", "\\\\")
                .Replace("'", "\\'")
                .Replace("\r", "")
                .Replace("\n", " ");

            ClientScript.RegisterStartupScript(
                this.GetType(),
                Guid.NewGuid().ToString(),
                "alert('" + safeMessage + "');",
                true);
        }
    }
}