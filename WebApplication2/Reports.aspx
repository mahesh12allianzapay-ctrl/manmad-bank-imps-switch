<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="WebApplication2.Reports" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Transaction Reports</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            background: #f4f6f9;
            font-family: "Segoe UI", Arial, sans-serif;
            color: #333;
        }

        .container {
            width: 1200px;
            max-width: 95%;
            margin: 30px auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px #ccc;
        }

        h2 {
            text-align: center;
            color: #003366;
            margin-top: 0;
            margin-bottom: 25px;
        }

        .filter-table {
            width: 100%;
            border-collapse: collapse;
        }

        .filter-table td {
            padding: 8px;
            vertical-align: middle;
        }

        .label {
            font-weight: bold;
            color: #333;
            white-space: nowrap;
        }

        input[type="text"],
        input[type="date"],
        select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        .btn {
            background: #003366;
            color: white;
            border: none;
            padding: 10px 18px;
            cursor: pointer;
            border-radius: 4px;
            margin-right: 5px;
            margin-bottom: 5px;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        .btn:hover {
            background: #005599;
        }

        .grid {
            margin-top: 20px;
            width: 100%;
            border-collapse: collapse;
        }

        .grid th {
            background: #003366;
            color: white;
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        .grid td {
            padding: 9px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .grid tr:nth-child(even) {
            background: #f8f9fa;
        }

        .grid tr:hover {
            background: #eaf2f8;
        }

        .summary {
            margin-top: 20px;
            padding: 15px;
            background: #f1f5f9;
            border-radius: 5px;
            font-weight: bold;
            color: #003366;
            border: 1px solid #d9e2ec;
        }

        .summary-item {
            display: inline-block;
            margin-right: 35px;
        }

        .summary-value {
            color: #111;
        }

        .customer-box {
            font-weight: bold;
            color: #003366;
        }

        @media print {

            body {
                background: white;
            }

            .container {
                width: 100%;
                max-width: 100%;
                margin: 0;
                box-shadow: none;
                padding: 10px;
            }

            .btn,
            .filter-table {
                display: none;
            }

            h2 {
                margin-bottom: 15px;
            }

            .summary {
                border: 1px solid #000;
            }

            .grid {
                margin-top: 10px;
            }
        }

    </style>

</head>

<body>

    <form id="form1" runat="server">

        <div class="container">

            <h2>Transaction Reports</h2>

            <!-- FILTER SECTION -->

            <table class="filter-table">

                <tr>

                    <td class="label">
                        Customer ID
                    </td>

                    <td class="customer-box">

                        <asp:Label
                            ID="lblCustomerID"
                            runat="server">
                        </asp:Label>

                    </td>

                    <td class="label">
                        From Date
                    </td>

                    <td>

                        <asp:TextBox
                            ID="txtFromDate"
                            runat="server"
                            TextMode="Date">
                        </asp:TextBox>

                    </td>

                    <td class="label">
                        To Date
                    </td>

                    <td>

                        <asp:TextBox
                            ID="txtToDate"
                            runat="server"
                            TextMode="Date">
                        </asp:TextBox>

                    </td>

                </tr>

                <tr>

                    <td class="label">
                        Status
                    </td>

                    <td>

                        <asp:DropDownList
                            ID="ddlStatus"
                            runat="server">

                            <asp:ListItem
                                Text="All"
                                Value="All">
                            </asp:ListItem>

                            <asp:ListItem
                                Text="Success"
                                Value="Success">
                            </asp:ListItem>

                            <asp:ListItem
                                Text="Pending"
                                Value="Pending">
                            </asp:ListItem>

                            <asp:ListItem
                                Text="Failed"
                                Value="Failed">
                            </asp:ListItem>

                        </asp:DropDownList>

                    </td>

                    <td colspan="4">

                        <!-- SEARCH -->

                        <asp:Button
                            ID="btnSearch"
                            runat="server"
                            Text="Search"
                            CssClass="btn"
                            OnClick="btnSearch_Click" />

                        <!-- PRINT -->

                        <asp:Button
                            ID="btnPrint"
                            runat="server"
                            Text="Print"
                            CssClass="btn"
                            OnClick="btnPrint_Click" />

                        <!-- PDF -->

                        <asp:Button
                            ID="btnPDF"
                            runat="server"
                            Text="Export PDF"
                            CssClass="btn"
                            OnClick="btnPDF_Click" />

                        <!-- EXCEL -->

                        <asp:Button
                            ID="btnExcel"
                            runat="server"
                            Text="Export Excel"
                            CssClass="btn"
                            OnClick="btnExcel_Click" />

                        <!-- CSV -->

                        <asp:Button
                            ID="btnCSV"
                            runat="server"
                            Text="Download CSV"
                            CssClass="btn"
                            OnClick="btnCSV_Click" />

                        <!-- EMAIL -->

                        <asp:Button
                            ID="btnEmail"
                            runat="server"
                            Text="Email Statement"
                            CssClass="btn"
                            OnClick="btnEmail_Click" />

                    </td>

                </tr>

            </table>

            <br />

            <!-- REPORT GRID -->

            <asp:GridView
                ID="gvReports"
                runat="server"
                AutoGenerateColumns="False"
                Width="100%"
                CssClass="grid"
                EmptyDataText="No transactions found.">

                <Columns>

                    <asp:BoundField
                        DataField="TransactionDate"
                        HeaderText="Date"
                        DataFormatString="{0:dd-MM-yyyy HH:mm}" />

                    <asp:BoundField
                        DataField="TransactionRefNo"
                        HeaderText="Reference" />

                    <asp:BoundField
                        DataField="TransactionType"
                        HeaderText="Type" />

                    <asp:BoundField
                        DataField="BeneficiaryName"
                        HeaderText="Beneficiary" />

                    <asp:BoundField
                        DataField="DebitAmount"
                        HeaderText="Debit"
                        DataFormatString="{0:N2}" />

                    <asp:BoundField
                        DataField="CreditAmount"
                        HeaderText="Credit"
                        DataFormatString="{0:N2}" />

                    <asp:BoundField
                        DataField="Balance"
                        HeaderText="Balance"
                        DataFormatString="{0:N2}" />

                    <asp:BoundField
                        DataField="Status"
                        HeaderText="Status" />

                </Columns>

            </asp:GridView>

            <br />

            <!-- SUMMARY -->

            <div class="summary">

                <span class="summary-item">

                    Total Debit:

                    <asp:Label
                        ID="lblTotalDebit"
                        runat="server"
                        CssClass="summary-value">
                    </asp:Label>

                </span>

                <span class="summary-item">

                    Total Credit:

                    <asp:Label
                        ID="lblTotalCredit"
                        runat="server"
                        CssClass="summary-value">
                    </asp:Label>

                </span>

                <span class="summary-item">

                    Closing Balance:

                    <asp:Label
                        ID="lblClosingBalance"
                        runat="server"
                        CssClass="summary-value">
                    </asp:Label>

                </span>

            </div>

        </div>

    </form>

</body>

</html>