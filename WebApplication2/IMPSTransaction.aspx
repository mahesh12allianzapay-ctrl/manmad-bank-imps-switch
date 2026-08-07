<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IMPSTransaction.aspx.cs" Inherits="WebApplication2.IMPSTransaction" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IMPS Transaction - Manmad Bank</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;
        }

        body{
            background:#f2f5f9;
        }

        .header{
            background:#0f4c81;
            color:white;
            padding:20px;
            text-align:center;
            font-size:28px;
            font-weight:bold;
        }

        .container{
            width:600px;
            margin:40px auto;
            background:white;
            padding:30px;
            border-radius:10px;
            box-shadow:0 5px 20px rgba(0,0,0,.2);
        }

        h2{
            color:#0f4c81;
            margin-bottom:25px;
            text-align:center;
        }

        .row{
            margin-bottom:18px;
        }

        .row label{
            display:block;
            margin-bottom:8px;
            font-weight:bold;
        }

        .textbox{
            width:100%;
            padding:12px;
            border:1px solid #ccc;
            border-radius:6px;
            font-size:15px;
        }

        .btn{
            width:100%;
            padding:15px;
            background:#0f4c81;
            color:white;
            border:none;
            border-radius:6px;
            font-size:18px;
            cursor:pointer;
        }

        .btn:hover{
            background:#08375f;
        }

        .message{
            color:green;
            font-weight:bold;
            text-align:center;
            margin-top:15px;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="header">
    MANMAD BANK
</div>

<div class="container">

<h2>IMPS Money Transfer</h2>

<div class="row">
<label>Customer ID</label>

<asp:TextBox
ID="txtCustomerID"
runat="server"
CssClass="textbox"
ReadOnly="true">
</asp:TextBox>

</div>

<div class="row">
<label>Beneficiary Name</label>

<asp:TextBox
ID="txtBeneficiary"
runat="server"
CssClass="textbox">
</asp:TextBox>

</div>

<div class="row">
<label>Account Number</label>

<asp:TextBox
ID="txtAccount"
runat="server"
CssClass="textbox">
</asp:TextBox>

</div>

<div class="row">
<label>Confirm Account Number</label>

<asp:TextBox
ID="txtConfirmAccount"
runat="server"
CssClass="textbox">
</asp:TextBox>

</div>

<div class="row">
<label>IFSC Code</label>

<asp:TextBox
ID="txtIFSC"
runat="server"
CssClass="textbox">
</asp:TextBox>

</div>

<div class="row">
<label>Amount</label>

<asp:TextBox
ID="txtAmount"
runat="server"
CssClass="textbox">
</asp:TextBox>

</div>

<div class="row">
<label>Remarks</label>

<asp:TextBox
ID="txtRemarks"
runat="server"
CssClass="textbox">
</asp:TextBox>

</div>

<div class="row">

<asp:Button
ID="btnTransfer"
runat="server"
Text="Transfer Money"
CssClass="btn"
OnClick="btnTransfer_Click"/>

</div>

<asp:Label
ID="lblMessage"
runat="server"
CssClass="message">
</asp:Label>

</div>

</form>

</body>
</html>