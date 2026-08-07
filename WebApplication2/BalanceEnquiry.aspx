<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BalanceEnquiry.aspx.cs" Inherits="WebApplication2.BalanceEnquiry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Balance Enquiry</title>

    <style>

        body {
            margin: 0;
            padding: 0;
            background: #f4f6f9;
            font-family: "Segoe UI";
        }

        .container {
            width: 850px;
            margin: 40px auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 10px #cccccc;
        }

        h2 {
            text-align: center;
            color: #003366;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
        }

        td {
            padding: 10px;
        }

        .title {
            width: 220px;
            font-weight: bold;
            color: #003366;
        }

        .value {
            color: #222222;
        }

        .balance {
            font-size: 22px;
            color: green;
            font-weight: bold;
        }

        .btn {
            background: #003366;
            color: white;
            border: none;
            padding: 10px 25px;
            font-size: 15px;
            cursor: pointer;
            border-radius: 4px;
        }

        .btn:hover {
            background: #005599;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container">

<h2>Balance Enquiry</h2>

<table>

<tr>
    <td class="title">Customer ID</td>
    <td class="value">
        <asp:Label ID="lblCustomerID" runat="server"></asp:Label>
    </td>
</tr>

<tr>
    <td class="title">Account Number</td>
    <td class="value">
        <asp:Label ID="lblAccountNumber" runat="server"></asp:Label>
    </td>
</tr>

<tr>
    <td class="title">Customer Name</td>
    <td class="value">
        <asp:Label ID="lblCustomerName" runat="server"></asp:Label>
    </td>
</tr>

<tr>
    <td class="title">Account Type</td>
    <td class="value">
        <asp:Label ID="lblAccountType" runat="server"></asp:Label>
    </td>
</tr>

<tr>
    <td class="title">Available Balance</td>
    <td class="balance">
        ₹ <asp:Label ID="lblAvailableBalance" runat="server"></asp:Label>
    </td>
</tr>

<tr>
    <td class="title">Ledger Balance</td>
    <td class="value">
        ₹ <asp:Label ID="lblLedgerBalance" runat="server"></asp:Label>
    </td>
</tr>

<tr>
    <td class="title">Last Updated</td>
    <td class="value">
        <asp:Label ID="lblLastUpdated" runat="server"></asp:Label>
    </td>
</tr>

<tr>
    <td colspan="2" style="text-align:center">

        <asp:Button
            ID="btnRefresh"
            runat="server"
            Text="Refresh Balance"
            CssClass="btn"
            OnClick="btnRefresh_Click" />

    </td>
</tr>

</table>

</div>

</form>

</body>
</html>