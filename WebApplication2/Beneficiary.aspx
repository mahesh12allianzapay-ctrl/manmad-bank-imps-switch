<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Beneficiary.aspx.cs" Inherits="Connect.Beneficiary" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Beneficiary Management</title>

    <style>

        body {
            margin:0;
            padding:0;
            font-family:Segoe UI;
            background:#f4f6f9;
        }

        .container{
            width:1100px;
            margin:30px auto;
            background:#fff;
            padding:20px;
            border-radius:8px;
            box-shadow:0px 0px 10px #ccc;
        }

        h2{
            color:#003366;
            margin-bottom:20px;
        }

        table{
            width:100%;
        }

        td{
            padding:8px;
        }

        .textbox{
            width:280px;
            padding:8px;
        }

        .btn{
            background:#003366;
            color:white;
            padding:10px 20px;
            border:none;
            cursor:pointer;
            font-weight:bold;
        }

        .btn:hover{
            background:#005599;
        }

        .grid{
            margin-top:25px;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container">

<h2>Beneficiary Management</h2>

<table>

<tr>

<td><b>Customer ID</b></td>

<td>
<asp:Label ID="lblCustomerID"
runat="server"
Text="10001">
</asp:Label>
</td>

<td><b>Beneficiary Name</b></td>

<td>
<asp:TextBox
ID="txtBeneficiaryName"
runat="server"
CssClass="textbox">
</asp:TextBox>
</td>

</tr>

<tr>

<td><b>Account Number</b></td>

<td>
<asp:TextBox
ID="txtAccountNumber"
runat="server"
CssClass="textbox">
</asp:TextBox>
</td>

<td><b>Confirm Account</b></td>

<td>
<asp:TextBox
ID="txtConfirmAccount"
runat="server"
CssClass="textbox">
</asp:TextBox>
</td>

</tr>

<tr>

<td><b>IFSC Code</b></td>

<td>
<asp:TextBox
ID="txtIFSC"
runat="server"
CssClass="textbox">
</asp:TextBox>
</td>

<td><b>Bank Name</b></td>

<td>
<asp:TextBox
ID="txtBankName"
runat="server"
CssClass="textbox">
</asp:TextBox>
</td>

</tr>

<tr>

<td><b>Branch Name</b></td>

<td>
<asp:TextBox
ID="txtBranch"
runat="server"
CssClass="textbox">
</asp:TextBox>
</td>

<td><b>Nick Name</b></td>

<td>
<asp:TextBox
ID="txtNickName"
runat="server"
CssClass="textbox">
</asp:TextBox>
</td>

</tr>

<tr>

<td><b>Mobile Number</b></td>

<td>
<asp:TextBox
ID="txtMobile"
runat="server"
CssClass="textbox">
</asp:TextBox>
</td>

<td><b>Email ID</b></td>

<td>
<asp:TextBox
ID="txtEmail"
runat="server"
CssClass="textbox">
</asp:TextBox>
</td>

</tr>

<tr>

<td colspan="4" align="center">

<asp:Button
ID="btnAdd"
runat="server"
Text="Add Beneficiary"
CssClass="btn"
OnClick="btnAdd_Click"/>

</td>

</tr>

</table>

<br />

<asp:GridView
ID="gvBeneficiary"
runat="server"
AutoGenerateColumns="False"
Width="100%"
CssClass="grid"
BorderWidth="1"
GridLines="Both">

<Columns>

<asp:BoundField DataField="BeneficiaryID" HeaderText="ID" Visible="false" />

<asp:BoundField DataField="BeneficiaryName" HeaderText="Beneficiary Name" />

<asp:BoundField DataField="AccountNumber" HeaderText="Account Number" />

<asp:BoundField DataField="IFSCCode" HeaderText="IFSC Code" />

<asp:BoundField DataField="BankName" HeaderText="Bank Name" />

<asp:BoundField DataField="BranchName" HeaderText="Branch Name" />

<asp:BoundField DataField="NickName" HeaderText="Nick Name" />

<asp:BoundField DataField="MobileNumber" HeaderText="Mobile Number" />

<asp:BoundField DataField="EmailID" HeaderText="Email ID" />

<asp:BoundField DataField="Status" HeaderText="Status" />

</Columns>

</asp:GridView>

</div>

</form>

</body>
</html>