<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TransactionStatus.aspx.cs" Inherits="Connect.TransactionStatus" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Transaction Status</title>

    <style>

        body{
            margin:0;
            padding:0;
            font-family:Segoe UI;
            background:#f4f6f9;
        }

        .container{
            width:900px;
            margin:30px auto;
            background:#fff;
            padding:25px;
            border-radius:8px;
            box-shadow:0px 0px 10px #ccc;
        }

        h2{
            color:#003366;
            margin-bottom:25px;
        }

        table{
            width:100%;
        }

        td{
            padding:8px;
        }

        .textbox{
            width:300px;
            padding:8px;
        }

        .btn{
            background:#003366;
            color:white;
            border:none;
            padding:10px 20px;
            cursor:pointer;
            font-weight:bold;
        }

        .btn:hover{
            background:#005599;
        }

        .labelTitle{
            font-weight:bold;
            color:#003366;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container">

<h2>Transaction Status</h2>

<table>

<tr>

<td class="labelTitle">
Transaction Reference No
</td>

<td>

<asp:TextBox
ID="txtReferenceNo"
runat="server"
CssClass="textbox">
</asp:TextBox>

</td>

<td>

<asp:Button
ID="btnSearch"
runat="server"
Text="Search"
CssClass="btn"
OnClick="btnSearch_Click" />

</td>

</tr>

</table>

<hr />

<h3>Transaction Details</h3>

<table border="0">

<tr>

<td class="labelTitle">Customer ID</td>

<td>
<asp:Label ID="lblCustomerID" runat="server"></asp:Label>
</td>

</tr>

<tr>

<td class="labelTitle">Beneficiary Name</td>

<td>
<asp:Label ID="lblBeneficiary" runat="server"></asp:Label>
</td>

</tr>

<tr>

<td class="labelTitle">Account Number</td>

<td>
<asp:Label ID="lblAccountNo" runat="server"></asp:Label>
</td>

</tr>

<tr>

<td class="labelTitle">IFSC Code</td>

<td>
<asp:Label ID="lblIFSC" runat="server"></asp:Label>
</td>

</tr>

<tr>

<td class="labelTitle">Amount</td>

<td>
<asp:Label ID="lblAmount" runat="server"></asp:Label>
</td>

</tr>

<tr>

<td class="labelTitle">Transaction Type</td>

<td>
<asp:Label ID="lblType" runat="server"></asp:Label>
</td>

</tr>

<tr>

<td class="labelTitle">Status</td>

<td>
<asp:Label ID="lblStatus" runat="server"></asp:Label>
</td>

</tr>

<tr>

<td class="labelTitle">Transaction Date</td>

<td>
<asp:Label ID="lblDate" runat="server"></asp:Label>
</td>

</tr>

<tr>

<td class="labelTitle">Remarks</td>

<td>
<asp:Label ID="lblRemarks" runat="server"></asp:Label>
</td>

</tr>

</table>

</div>

</form>

</body>

</html>