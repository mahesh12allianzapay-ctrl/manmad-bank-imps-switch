<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MiniStatement.aspx.cs" Inherits="WebApplication2.MiniStatement1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mini Statement</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI';
            background: #f4f6f9;
        }

        .container {
            width: 1100px;
            margin: 30px auto;
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px #cccccc;
        }

        h2 {
            text-align: center;
            color: #003366;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            margin-bottom: 15px;
        }

        td {
            padding: 8px;
        }

        .title {
            font-weight: bold;
            color: #003366;
        }

        .btn {
            background: #003366;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }

        .btn:hover {
            background: #005599;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
        }

        .grid th {
            background: #003366;
            color: white;
            padding: 10px;
        }

        .grid td {
            padding: 8px;
            border: 1px solid #cccccc;
            text-align: center;
        }

        .grid tr:nth-child(even) {
            background: #f9f9f9;
        }
    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container">

    <h2>Mini Statement</h2>

    <table>

        <tr>

            <td class="title">Customer ID</td>

            <td>
                <asp:Label ID="lblCustomerID" runat="server"></asp:Label>
            </td>

            <td class="title">Account Number</td>

            <td>
                <asp:Label ID="lblAccountNumber" runat="server"></asp:Label>
            </td>

        </tr>

        <tr>

            <td colspan="4" style="text-align:center">

                <asp:Button
                    ID="btnRefresh"
                    runat="server"
                    Text="Refresh Statement"
                    CssClass="btn"
                    OnClick="btnRefresh_Click" />

            </td>

        </tr>

    </table>

    <asp:GridView
        ID="gvStatement"
        runat="server"
        CssClass="grid"
        AutoGenerateColumns="False"
        Width="100%"
        GridLines="Both">

        <Columns>

            <asp:BoundField DataField="TransactionDate"
                HeaderText="Transaction Date"
                DataFormatString="{0:dd-MMM-yyyy HH:mm}" />

            <asp:BoundField DataField="TransactionRefNo"
                HeaderText="Reference No" />

            <asp:BoundField DataField="TransactionType"
                HeaderText="Transaction Type" />

            <asp:BoundField DataField="BeneficiaryName"
                HeaderText="Beneficiary Name" />

            <asp:BoundField DataField="DebitAmount"
                HeaderText="Debit Amount"
                DataFormatString="{0:N2}" />

            <asp:BoundField DataField="CreditAmount"
                HeaderText="Credit Amount"
                DataFormatString="{0:N2}" />

            <asp:BoundField DataField="Balance"
                HeaderText="Balance"
                DataFormatString="{0:N2}" />

            <asp:BoundField DataField="Status"
                HeaderText="Status" />

        </Columns>

    </asp:GridView>

</div>

</form>

</body>
</html>