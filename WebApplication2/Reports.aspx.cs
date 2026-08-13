using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace WebApplication2
{
    public partial class Reports : System.Web.UI.Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get Customer ID from Login Session
                if (Session["CustomerID"] != null)
                {
                    lblCustomerID.Text = Session["CustomerID"].ToString();
                }
                else
                {
                    // Temporary testing Customer ID
                    lblCustomerID.Text = "10001";
                }

                txtFromDate.Text =
                    DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd");

                txtToDate.Text =
                    DateTime.Now.ToString("yyyy-MM-dd");

                ddlStatus.SelectedValue = "All";

                LoadReport();
            }
        }

        // =========================================================
        // LOAD REPORT
        // =========================================================

        private void LoadReport()
        {
            try
            {
                DataTable dt = GetReportData();

                gvReports.DataSource = dt;
                gvReports.DataBind();

                CalculateTotals(dt);
            }
            catch (Exception ex)
            {
                gvReports.DataSource = null;
                gvReports.DataBind();

                lblTotalDebit.Text = "0.00";
                lblTotalCredit.Text = "0.00";
                lblClosingBalance.Text = "0.00";

                ShowMessage(
                    "Error loading report: " + ex.Message);
            }
        }

        // =========================================================
        // GET REPORT DATA
        // =========================================================

        private DataTable GetReportData()
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
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
                    AND CAST(TransactionDate AS DATE)
                        BETWEEN @FromDate AND @ToDate";

                if (ddlStatus.SelectedValue != "All")
                {
                    query += " AND Status = @Status";
                }

                query += " ORDER BY TransactionDate DESC";

                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(
                        "@CustomerID",
                        SqlDbType.VarChar,
                        50).Value =
                        lblCustomerID.Text.Trim();

                    DateTime fromDate;
                    DateTime toDate;

                    if (!DateTime.TryParse(
                        txtFromDate.Text,
                        out fromDate))
                    {
                        fromDate =
                            DateTime.Now.AddMonths(-1);
                    }

                    if (!DateTime.TryParse(
                        txtToDate.Text,
                        out toDate))
                    {
                        toDate = DateTime.Now;
                    }

                    cmd.Parameters.Add(
                        "@FromDate",
                        SqlDbType.Date).Value =
                        fromDate.Date;

                    cmd.Parameters.Add(
                        "@ToDate",
                        SqlDbType.Date).Value =
                        toDate.Date;

                    if (ddlStatus.SelectedValue != "All")
                    {
                        cmd.Parameters.Add(
                            "@Status",
                            SqlDbType.VarChar,
                            20).Value =
                            ddlStatus.SelectedValue;
                    }

                    using (SqlDataAdapter da =
                        new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            return dt;
        }

        // =========================================================
        // CALCULATE TOTALS
        // =========================================================

        private void CalculateTotals(DataTable dt)
        {
            decimal totalDebit = 0;
            decimal totalCredit = 0;
            decimal closingBalance = 0;

            foreach (DataRow row in dt.Rows)
            {
                if (row["DebitAmount"] != DBNull.Value)
                {
                    totalDebit +=
                        Convert.ToDecimal(
                            row["DebitAmount"]);
                }

                if (row["CreditAmount"] != DBNull.Value)
                {
                    totalCredit +=
                        Convert.ToDecimal(
                            row["CreditAmount"]);
                }
            }

            // Query is ordered DESC,
            // so first row is the latest transaction.
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Balance"] != DBNull.Value)
                {
                    closingBalance =
                        Convert.ToDecimal(
                            dt.Rows[0]["Balance"]);
                }
            }

            lblTotalDebit.Text =
                totalDebit.ToString("N2");

            lblTotalCredit.Text =
                totalCredit.ToString("N2");

            lblClosingBalance.Text =
                closingBalance.ToString("N2");
        }

        // =========================================================
        // SEARCH BUTTON
        // =========================================================

        protected void btnSearch_Click(
            object sender,
            EventArgs e)
        {
            DateTime fromDate;
            DateTime toDate;

            if (!DateTime.TryParse(
                txtFromDate.Text,
                out fromDate))
            {
                ShowMessage(
                    "Please select a valid From Date.");

                return;
            }

            if (!DateTime.TryParse(
                txtToDate.Text,
                out toDate))
            {
                ShowMessage(
                    "Please select a valid To Date.");

                return;
            }

            if (fromDate.Date > toDate.Date)
            {
                ShowMessage(
                    "From Date cannot be greater than To Date.");

                return;
            }

            LoadReport();
        }

        // =========================================================
        // PRINT
        // =========================================================

        protected void btnPrint_Click(
            object sender,
            EventArgs e)
        {
            ClientScript.RegisterStartupScript(
                this.GetType(),
                "print",
                "window.print();",
                true);
        }

        // =========================================================
        // PDF
        // =========================================================

        protected void btnPDF_Click(
            object sender,
            EventArgs e)
        {
            try
            {
                DataTable dt = GetReportData();

                if (dt.Rows.Count == 0)
                {
                    ShowMessage(
                        "No transactions available for PDF export.");

                    return;
                }

                using (MemoryStream ms =
                    new MemoryStream())
                {
                    Document document =
                        new Document(
                            PageSize.A4,
                            20,
                            20,
                            30,
                            30);

                    PdfWriter.GetInstance(
                        document,
                        ms);

                    document.Open();

                    Paragraph title =
                        new Paragraph(
                            "Transaction Report",
                            FontFactory.GetFont(
                                FontFactory.HELVETICA_BOLD,
                                16));

                    title.Alignment =
                        Element.ALIGN_CENTER;

                    document.Add(title);

                    document.Add(
                        new Paragraph(
                            "Customer ID: " +
                            lblCustomerID.Text));

                    document.Add(
                        new Paragraph(
                            "From Date: " +
                            txtFromDate.Text));

                    document.Add(
                        new Paragraph(
                            "To Date: " +
                            txtToDate.Text));

                    document.Add(
                        new Paragraph(" "));

                    PdfPTable table =
                        new PdfPTable(8);

                    table.WidthPercentage = 100;

                    string[] headers =
                    {
                        "Date",
                        "Reference",
                        "Type",
                        "Beneficiary",
                        "Debit",
                        "Credit",
                        "Balance",
                        "Status"
                    };

                    foreach (string header in headers)
                    {
                        PdfPCell cell =
                            new PdfPCell(
                                new Phrase(header));

                        cell.HorizontalAlignment =
                            Element.ALIGN_CENTER;

                        table.AddCell(cell);
                    }

                    foreach (DataRow row in dt.Rows)
                    {
                        table.AddCell(
                            Convert.ToDateTime(
                                row["TransactionDate"])
                            .ToString(
                                "dd-MM-yyyy HH:mm"));

                        table.AddCell(
                            Convert.ToString(
                                row["TransactionRefNo"]));

                        table.AddCell(
                            Convert.ToString(
                                row["TransactionType"]));

                        table.AddCell(
                            Convert.ToString(
                                row["BeneficiaryName"]));

                        table.AddCell(
                            GetDecimalValue(
                                row["DebitAmount"]));

                        table.AddCell(
                            GetDecimalValue(
                                row["CreditAmount"]));

                        table.AddCell(
                            GetDecimalValue(
                                row["Balance"]));

                        table.AddCell(
                            Convert.ToString(
                                row["Status"]));
                    }

                    document.Add(table);

                    document.Add(
                        new Paragraph(" "));

                    document.Add(
                        new Paragraph(
                            "Total Debit: " +
                            lblTotalDebit.Text));

                    document.Add(
                        new Paragraph(
                            "Total Credit: " +
                            lblTotalCredit.Text));

                    document.Add(
                        new Paragraph(
                            "Closing Balance: " +
                            lblClosingBalance.Text));

                    document.Close();

                    Response.Clear();

                    Response.ContentType =
                        "application/pdf";

                    Response.AddHeader(
                        "Content-Disposition",
                        "attachment;filename=TransactionReport.pdf");

                    Response.BinaryWrite(
                        ms.ToArray());

                    Response.End();
                }
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "PDF export error: " +
                    ex.Message);
            }
        }

        // =========================================================
        // EXCEL
        // =========================================================

        protected void btnExcel_Click(
            object sender,
            EventArgs e)
        {
            try
            {
                DataTable dt = GetReportData();

                if (dt.Rows.Count == 0)
                {
                    ShowMessage(
                        "No transactions available for Excel export.");

                    return;
                }

                Response.Clear();
                Response.Buffer = true;

                Response.AddHeader(
                    "content-disposition",
                    "attachment;filename=TransactionReport.xls");

                Response.Charset = "";

                Response.ContentType =
                    "application/vnd.ms-excel";

                StringWriter sw =
                    new StringWriter();

                HtmlTextWriter hw =
                    new HtmlTextWriter(sw);

                gvReports.RenderControl(hw);

                Response.Output.Write(
                    sw.ToString());

                Response.Flush();
                Response.End();
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Excel export error: " +
                    ex.Message);
            }
        }

        // =========================================================
        // CSV
        // =========================================================

        protected void btnCSV_Click(
            object sender,
            EventArgs e)
        {
            try
            {
                DataTable dt = GetReportData();

                if (dt.Rows.Count == 0)
                {
                    ShowMessage(
                        "No transactions available for CSV download.");

                    return;
                }

                Response.Clear();
                Response.Buffer = true;

                Response.AddHeader(
                    "content-disposition",
                    "attachment;filename=TransactionReport.csv");

                Response.ContentType =
                    "text/csv";

                StringWriter sw =
                    new StringWriter();

                sw.WriteLine(
                    "Date,Reference,Type,Beneficiary,Debit,Credit,Balance,Status");

                foreach (DataRow row in dt.Rows)
                {
                    sw.WriteLine(
                        "\"" +
                        row["TransactionDate"] +
                        "\"," +

                        "\"" +
                        row["TransactionRefNo"] +
                        "\"," +

                        "\"" +
                        row["TransactionType"] +
                        "\"," +

                        "\"" +
                        row["BeneficiaryName"] +
                        "\"," +

                        "\"" +
                        row["DebitAmount"] +
                        "\"," +

                        "\"" +
                        row["CreditAmount"] +
                        "\"," +

                        "\"" +
                        row["Balance"] +
                        "\"," +

                        "\"" +
                        row["Status"] +
                        "\"");
                }

                Response.Write(
                    sw.ToString());

                Response.Flush();
                Response.End();
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "CSV export error: " +
                    ex.Message);
            }
        }

        // =========================================================
        // EMAIL
        // =========================================================

        protected void btnEmail_Click(
            object sender,
            EventArgs e)
        {
            ShowMessage(
                "Email Statement feature will be implemented next.");
        }

        // =========================================================
        // DECIMAL FORMAT
        // =========================================================

        private string GetDecimalValue(
            object value)
        {
            if (value == DBNull.Value ||
                value == null)
            {
                return "0.00";
            }

            return Convert.ToDecimal(value)
                .ToString("N2");
        }

        // =========================================================
        // MESSAGE
        // =========================================================

        private void ShowMessage(
            string message)
        {
            string safeMessage =
                message.Replace(
                    "\\",
                    "\\\\")
                .Replace(
                    "'",
                    "\\'")
                .Replace(
                    "\r",
                    "")
                .Replace(
                    "\n",
                    "\\n");

            ClientScript.RegisterStartupScript(
                this.GetType(),
                Guid.NewGuid().ToString(),
                "alert('" +
                safeMessage +
                "');",
                true);
        }

        // =========================================================
        // REQUIRED FOR EXCEL EXPORT
        // =========================================================

        public override void VerifyRenderingInServerForm(
            Control control)
        {
            // Required for GridView export
        }
    }
}