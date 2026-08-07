<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="WebApplication2.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard - Manmad Bank</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Segoe UI';
        }

        body{
            background:#eef2f7;
        }

        .header{
            background:#0f4c81;
            color:white;
            padding:18px;
            text-align:center;
            font-size:28px;
            font-weight:bold;
        }

        .welcome{
            background:white;
            margin:20px;
            padding:20px;
            border-radius:10px;
            box-shadow:0 2px 10px rgba(0,0,0,.15);
        }

        .cards{
            display:flex;
            gap:20px;
            margin:20px;
        }

        .card{
            flex:1;
            background:white;
            padding:25px;
            border-radius:10px;
            text-align:center;
            box-shadow:0 2px 10px rgba(0,0,0,.15);
        }

        .card h3{
            color:#0f4c81;
            margin-bottom:15px;
        }

        .card span{
            font-size:26px;
            font-weight:bold;
        }

        .menu{
            margin:20px;
            display:flex;
            gap:15px;
            flex-wrap:wrap;
        }

        .menu a{
            background:#0f4c81;
            color:white;
            padding:12px 20px;
            text-decoration:none;
            border-radius:5px;
            font-weight:bold;
        }

        .menu a:hover{
            background:#08375f;
        }

        .grid{
            margin:20px;
            background:white;
            padding:20px;
            border-radius:10px;
            box-shadow:0 2px 10px rgba(0,0,0,.15);
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="header">
    MANMAD BANK - DASHBOARD
</div>

<div class="welcome">

<h2>
Welcome,
<asp:Label ID="lblCustomerName" runat="server"></asp:Label>
</h2>

<br />

<b>Customer ID :</b>
<asp:Label ID="lblCustomerID" runat="server"></asp:Label>

<br /><br />

<b>Account Number :</b>
<asp:Label ID="lblAccountNumber" runat="server"></asp:Label>

<br /><br />

<b>Account Type :</b>
<asp:Label ID="lblAccountType" runat="server"></asp:Label>

</div>

<div class="cards">

<div class="card">

<h3>Available Balance</h3>

₹

<asp:Label ID="lblBalance" runat="server"></asp:Label>

</div>

<div class="card">

<h3>Today's Transactions</h3>

<asp:Label ID="lblTodayTxn" runat="server"></asp:Label>

</div>

<div class="card">

<h3>Today's Transfer</h3>

₹

<asp:Label ID="lblTodayAmount" runat="server"></asp:Label>

</div>

</div>

<div class="menu">

<a href="IMPSTransaction.aspx">IMPS Transfer</a>

<a href="Beneficiary.aspx">Beneficiary</a>

<a href="BalanceEnquiry.aspx">Balance Enquiry</a>

<a href="MiniStatement.aspx">Mini Statement</a>

<a href="TransactionStatus.aspx">Transaction Status</a>

<a href="Reports.aspx">Reports</a>

<a href="ApiLogs.aspx" class="btn btn-info btn-lg">
    API Logs
</a>

<a href="Logout.aspx">Logout</a>

</div>

<div class="grid">

<h2>Recent Transactions</h2>

<asp:GridView
ID="gvTransactions"
runat="server"
Width="100%"
AutoGenerateColumns="true"
BorderWidth="1"
GridLines="Both">
</asp:GridView>

</div>

</form>

</body>
</html>