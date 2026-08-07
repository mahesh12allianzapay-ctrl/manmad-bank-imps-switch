<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="WebApplication2.ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password - Manmad Bank</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;
        }

        body{

            background:linear-gradient(135deg,#0f4c81,#0d1b2a);
            height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;

        }

        .container{

            width:500px;
            background:#fff;
            border-radius:15px;
            padding:40px;
            box-shadow:0 15px 40px rgba(0,0,0,.3);

        }

        h2{

            text-align:center;
            color:#0f4c81;
            margin-bottom:10px;

        }

        .subtitle{

            text-align:center;
            color:#777;
            margin-bottom:30px;

        }

        .form-group{

            margin-bottom:18px;

        }

        label{

            display:block;
            margin-bottom:8px;
            font-weight:600;
            color:#333;

        }

        .textbox{

            width:100%;
            padding:12px;
            border:1px solid #ccc;
            border-radius:8px;
            font-size:15px;

        }

        .textbox:focus{

            outline:none;
            border-color:#0f4c81;
            box-shadow:0 0 5px rgba(15,76,129,.4);

        }

        .btn{

            width:100%;
            padding:13px;
            background:#0f4c81;
            color:white;
            border:none;
            border-radius:8px;
            font-size:16px;
            font-weight:bold;
            cursor:pointer;

        }

        .btn:hover{

            background:#08375f;

        }

        .message{

            text-align:center;
            margin-top:15px;
            font-weight:bold;
            color:red;

        }

        .panel{

            margin-top:20px;

        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container">

    <h2>Forgot Password</h2>

    <div class="subtitle">
        Verify your identity to reset your password.
    </div>

    <asp:Label
        ID="lblMessage"
        runat="server"
        CssClass="message">
    </asp:Label>

    <!-- ========================= -->
    <!-- PANEL 1 : VERIFY CUSTOMER -->
    <!-- ========================= -->

    <asp:Panel
        ID="pnlVerifyCustomer"
        runat="server"
        CssClass="panel">

        <div class="form-group">

            <label>Customer ID</label>

            <asp:TextBox
                ID="txtCustomerID"
                runat="server"
                CssClass="textbox"
                placeholder="Enter Customer ID">
            </asp:TextBox>

        </div>

        <div class="form-group">

            <label>Registered Email</label>

            <asp:TextBox
                ID="txtEmail"
                runat="server"
                CssClass="textbox"
                TextMode="Email"
                placeholder="Enter Registered Email">
            </asp:TextBox>

        </div>

        <div class="form-group">

            <asp:Button
                ID="btnVerifyCustomer"
                runat="server"
                Text="Verify Customer"
                CssClass="btn"
                OnClick="btnVerifyCustomer_Click" />

        </div>

    </asp:Panel>

     <!-- ========================= -->
    <!-- PANEL 2 : VERIFY OTP -->
    <!-- ========================= -->

    <asp:Panel
        ID="pnlOTP"
        runat="server"
        CssClass="panel"
        Visible="false">

        <div class="form-group">

            <label>Enter OTP</label>

            <asp:TextBox
                ID="txtOTP"
                runat="server"
                CssClass="textbox"
                MaxLength="6"
                placeholder="Enter 6 Digit OTP">
            </asp:TextBox>

        </div>

        <div class="form-group">

            <asp:Button
                ID="btnVerifyOTP"
                runat="server"
                Text="Verify OTP"
                CssClass="btn"
                OnClick="btnVerifyOTP_Click" />

        </div>

    </asp:Panel>


    <asp:Panel
        ID="pnlResetPassword"
        runat="server"
        CssClass="panel"
        Visible="false">

        <div class="form-group">

            <label>New Password</label>

            <asp:TextBox
                ID="txtNewPassword"
                runat="server"
                CssClass="textbox"
                TextMode="Password"
                placeholder="Enter New Password">
            </asp:TextBox>

        </div>

        <div class="form-group">

            <label>Confirm Password</label>

            <asp:TextBox
                ID="txtConfirmPassword"
                runat="server"
                CssClass="textbox"
                TextMode="Password"
                placeholder="Confirm New Password">
            </asp:TextBox>

        </div>

        <div class="form-group">

            <asp:Button
                ID="btnResetPassword"
                runat="server"
                Text="Reset Password"
                CssClass="btn"
                OnClick="btnResetPassword_Click" />

        </div>

    </asp:Panel>


    <div style="text-align:center;margin-top:25px;">

        <asp:HyperLink
            ID="lnkLogin"
            runat="server"
            NavigateUrl="Login.aspx"
            Font-Bold="true">
            ← Back to Login
        </asp:HyperLink>

    </div>

</div>

</form>

</body>
</html>