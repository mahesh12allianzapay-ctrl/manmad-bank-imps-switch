```aspx
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="MiniStatement.aspx.cs"
    Inherits="WebApplication2.MiniStatement1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Mini Statement</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        body {
            background: #eef2f7;
            min-height: 100vh;
        }

        .header {
            background: #17365d;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 24px;
            font-weight: 600;
        }

        .header span {
            font-size: 14px;
            opacity: 0.9;
        }

        .container {
            width: 94%;
            max-width: 1200px;
            margin: 35px auto;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .title {
            color: #17365d;
            font-size: 23px;
            font-weight: 600;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #eef2f7;
        }

        .account-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 25px;
        }

        .info-box {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 15px;
        }

        .info-label {
            display: block;
            color: #64748b;
            font-size: 13px;
            margin-bottom: 6px;
        }

        .info-value {
            display: block;
            color: #172033;
            font-size: 17px;
            font-weight: 600;
        }

        .button-area {
            text-align: right;
            margin-bottom: 20px;
        }

        .btn {
            background: #17365d;
            color: white;
            padding: 11px 22px;
            border: none;
            border-radius: 7px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .grid-container {
            width: 100%;
            overflow-x: auto;
        }

        .grid {
            width: 100%;
            min-width: 900px;
            border-collapse: collapse;
            background: white;
        }

        .grid th {
            background: #17365d;
            color: white;
            padding: 12px 10px;
            border: 1px solid #17365d;
            font-size: 14px;
            white-space: nowrap;
        }

        .grid td {
            padding: 10px;
            border: 1px solid #d9dee5;
            text-align: center;
            font-size: 13px;
            color: #334155;
            white-space: nowrap;
        }

        .grid tr:nth-child(even) {
            background: #f8fafc;
        }

        .grid tr:hover {
            background: #eef4fb;
        }

        @media (max-width: 700px) {

            .header {
                padding: 18px 20px;
            }

            .header h1 {
                font-size: 20px;
            }

            .container {
                width: 96%;
                margin: 20px auto;
            }

            .card {
                padding: 18px;
            }

            .account-info {
                grid-template-columns: 1fr;
            }

            .button-area {
                text-align: center;
            }

            .btn {
                width: 100%;
            }
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="header">

        <h1>Mini Statement</h1>

        <span>Manmad Bank</span>

    </div>

    <div class="container">

        <div class="card">

            <div class="title">
                Account Statement
            </div>

            <div class="account-info">

                <div class="info-box">

                    <span class="info-label">
                        Customer ID
                    </span>

                    <asp:Label
                        ID="lblCustomerID"
                        runat="server"
                        CssClass="info-value">
                    </asp:Label>

                </div>

                <div class="info-box">

                    <span class="info-label">
                        Account Number
                    </span>

                    <asp:Label
                        ID="lblAccountNumber"
                        runat="server"
                        CssClass="info-value">
                    </asp:Label>

                </div>

            </div>

            <div class="button-area">

                <asp:Button
                    ID="btnRefresh"
                    runat="server"
                    Text="Refresh Statement"
                    CssClass="btn"
                    OnClick="btnRefresh_Click" />

            </div>

            <div class="grid-container">

                <asp:GridView
                    ID="gvStatement"
                    runat="server"
                    CssClass="grid"
                    AutoGenerateColumns="False"
                    Width="100%"
                    GridLines="Both"
                    EmptyDataText="No transactions found.">

                    <Columns>

                        <asp:BoundField
                            DataField="TransactionDate"
                            HeaderText="Transaction Date"
                            DataFormatString="{0:dd-MMM-yyyy HH:mm}" />

                        <asp:BoundField
                            DataField="TransactionRefNo"
                            HeaderText="Reference No" />

                        <asp:BoundField
                            DataField="TransactionType"
                            HeaderText="Transaction Type" />

                        <asp:BoundField
                            DataField="BeneficiaryName"
                            HeaderText="Beneficiary Name" />

                        <asp:BoundField
                            DataField="DebitAmount"
                            HeaderText="Debit Amount"
                            DataFormatString="{0:N2}" />

                        <asp:BoundField
                            DataField="CreditAmount"
                            HeaderText="Credit Amount"
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

            </div>

        </div>

    </div>

</form>

</body>
</html>
```
