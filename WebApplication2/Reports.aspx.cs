using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace WebApplication2
{
    public partial class Reports : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Temporary Customer ID
                // Later replace with Session["CustomerID"]
                lblCustomerID.Text = "10001";

                txtFromDate.Text = DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd");
                txtToDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

                LoadReport();
            }
        }

        private void LoadReport()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT
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
                                 AND CAST(TransactionDate AS DATE)
                                 BETWEEN @FromDate AND @ToDate";

                if (ddlStatus.SelectedValue != "All")
                {
                    query += " AND Status=@Status";
                }

                query += " ORDER BY TransactionDate DESC";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@CustomerID", lblCustomerID.Text);
                cmd.Parameters.AddWithValue("@FromDate", txtFromDate.Text);
                cmd.Parameters.AddWithValue("@ToDate", txtToDate.Text);

                if (ddlStatus.SelectedValue != "All")
                {
                    cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();

                da.Fill(dt);

                gvReports.DataSource = dt;
                gvReports.DataBind();

                CalculateTotals(dt);
            }
        }

        private void CalculateTotals(DataTable dt)
        {
            decimal totalDebit = 0;
            decimal totalCredit = 0;
            decimal closingBalance = 0;

            foreach (DataRow row in dt.Rows)
            {
                if (row["DebitAmount"] != DBNull.Value)
                    totalDebit += Convert.ToDecimal(row["DebitAmount"]);

                if (row["CreditAmount"] != DBNull.Value)
                    totalCredit += Convert.ToDecimal(row["CreditAmount"]);

                if (row["Balance"] != DBNull.Value)
                    closingBalance = Convert.ToDecimal(row["Balance"]);
            }

            lblTotalDebit.Text = totalDebit.ToString("N2");
            lblTotalCredit.Text = totalCredit.ToString("N2");
            lblClosingBalance.Text = closingBalance.ToString("N2");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadReport();
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(
                this.GetType(),
                "print",
                "window.print();",
                true);
        }

        protected void btnPDF_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(
                this.GetType(),
                "pdf",
                "alert('Export PDF feature will be implemented next.');",
                true);
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(
                this.GetType(),
                "excel",
                "alert('Export Excel feature will be implemented next.');",
                true);
        }

        protected void btnCSV_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(
                this.GetType(),
                "csv",
                "alert('Download CSV feature will be implemented next.');",
                true);
        }

        protected void btnEmail_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(
                this.GetType(),
                "email",
                "alert('Email Statement feature will be implemented next.');",
                true);
        }
    }
}