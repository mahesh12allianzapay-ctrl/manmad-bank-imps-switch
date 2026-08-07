<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="WebApplication2.Reports" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Transaction Reports</title>

    <style>

        body{
            margin:0;
            background:#f4f6f9;
            font-family:Segoe UI;
        }

        .container{
            width:1200px;
            margin:30px auto;
            background:#fff;
            padding:25px;
            border-radius:8px;
            box-shadow:0px 0px 10px #ccc;
        }

        h2{
            text-align:center;
            color:#003366;
        }

        table{
            width:100%;
        }

        td{
            padding:8px;
        }

        .btn{
            background:#003366;
            color:white;
            border:none;
            padding:10px 18px;
            cursor:pointer;
            border-radius:4px;
            margin-right:5px;
        }

        .btn:hover{
            background:#005599;
        }

        .grid{
            margin-top:20px;
        }

        .summary{
            margin-top:20px;
            font-weight:bold;
            color:#003366;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container">

<h2>Transaction Reports</h2>

<table>

<tr>

<td><b>Customer ID</b></td>

<td>
<asp:Label ID="lblCustomerID" runat="server"></asp:Label>
</td>

<td><b>From Date</b></td>

<td>
<asp:TextBox ID="txtFromDate" runat="server" TextMode="Date"></asp:TextBox>
</td>

<td><b>To Date</b></td>

<td>
<asp:TextBox ID="txtToDate" runat="server" TextMode="Date"></asp:TextBox>
</td>

</tr>

<tr>

<td><b>Status</b></td>

<td>

<asp:DropDownList ID="ddlStatus" runat="server">

<asp:ListItem>All</asp:ListItem>
<asp:ListItem>Success</asp:ListItem>
<asp:ListItem>Pending</asp:ListItem>
<asp:ListItem>Failed</asp:ListItem>

</asp:DropDownList>

</td>

<td colspan="4">

<asp:Button
ID="btnSearch"
runat="server"
Text="Search"
CssClass="btn"
OnClick="btnSearch_Click"/>

<asp:Button
ID="btnPrint"
runat="server"
Text="Print"
CssClass="btn"/>

<asp:Button
ID="btnPDF"
runat="server"
Text="Export PDF"
CssClass="btn"/>

<asp:Button
ID="btnExcel"
runat="server"
Text="Export Excel"
CssClass="btn"/>

<asp:Button
ID="btnCSV"
runat="server"
Text="Download CSV"
CssClass="btn"/>

<asp:Button
ID="btnEmail"
runat="server"
Text="Email Statement"
CssClass="btn"/>

</td>

</tr>

</table>

<br/>

<asp:GridView
ID="gvReports"
runat="server"
AutoGenerateColumns="False"
Width="100%"
CssClass="grid">

<Columns>

<asp:BoundField DataField="TransactionDate" HeaderText="Date"/>

<asp:BoundField DataField="TransactionRefNo" HeaderText="Reference"/>

<asp:BoundField DataField="TransactionType" HeaderText="Type"/>

<asp:BoundField DataField="BeneficiaryName" HeaderText="Beneficiary"/>

<asp:BoundField DataField="DebitAmount" HeaderText="Debit"/>

<asp:BoundField DataField="CreditAmount" HeaderText="Credit"/>

<asp:BoundField DataField="Balance" HeaderText="Balance"/>

<asp:BoundField DataField="Status" HeaderText="Status"/>

</Columns>

</asp:GridView>

<br/>

<div class="summary">

Total Debit :
<asp:Label ID="lblTotalDebit" runat="server"></asp:Label>

&nbsp;&nbsp;&nbsp;

Total Credit :
<asp:Label ID="lblTotalCredit" runat="server"></asp:Label>

&nbsp;&nbsp;&nbsp;

Closing Balance :
<asp:Label ID="lblClosingBalance" runat="server"></asp:Label>

</div>

</div>

</form>

</body>
</html>