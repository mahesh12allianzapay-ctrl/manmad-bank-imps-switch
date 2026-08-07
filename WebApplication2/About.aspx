<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication2.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manmad Bank - Secure Internet Banking</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg,#0f4c81,#0d1b2a);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-box {
            width: 420px;
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 15px 40px rgba(0,0,0,.3);
        }

        .logo {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo h1 {
            color: #0f4c81;
            font-size: 30px;
        }

        .logo p {
            color: gray;
            margin-top: 8px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
        }

        .textbox {
            width: 100%;
            padding: 13px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
        }

        .textbox:focus {
            outline: none;
            border-color: #0f4c81;
            box-shadow: 0 0 5px rgba(15,76,129,.4);
        }

        .login-btn {
            width: 100%;
            padding: 14px;
            background: #0f4c81;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
        }

        .login-btn:hover {
            background: #08375f;
        }

        .message {
            margin-top: 15px;
            text-align: center;
            min-height: 25px;
        }

        .links {
            margin-top: 20px;
            text-align: center;
        }

        .links a {
            color: #0f4c81;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }

        .links a:hover {
            text-decoration: underline;
        }

        .security {
            margin-top: 25px;
            background: #eef6ff;
            border-left: 5px solid #0f4c81;
            padding: 12px;
            border-radius: 8px;
            font-size: 13px;
            color: #444;
        }

        .footer {
            margin-top: 20px;
            text-align: center;
            color: gray;
            font-size: 12px;
        }
    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="login-box">

    <div class="logo">
        <h1>Manmad Bank</h1>
        <p>Secure Internet Banking</p>
    </div>

    <div class="form-group">

        <label>Customer ID</label>

        <asp:TextBox
            ID="txtUser"
            runat="server"
            CssClass="textbox"
            MaxLength="20"
            placeholder="Enter Customer ID">
        </asp:TextBox>

        <asp:RequiredFieldValidator
            ID="rfvUser"
            runat="server"
            ControlToValidate="txtUser"
            ErrorMessage="Customer ID is required."
            Display="Dynamic"
            ForeColor="Red">
        </asp:RequiredFieldValidator>

    </div>

    <div class="form-group">

        <label>Password</label>

        <asp:TextBox
            ID="txtPassword"
            runat="server"
            CssClass="textbox"  
            TextMode="Password"
            MaxLength="30"
            placeholder="Enter Password">
        </asp:TextBox>

        <asp:RequiredFieldValidator
            ID="rfvPassword"
            runat="server"
            ControlToValidate="txtPassword"
            ErrorMessage="Password is required."
            Display="Dynamic"
            ForeColor="Red">
        </asp:RequiredFieldValidator>

    </div>

    <div class="form-group">

        <asp:CheckBox
            ID="chkRemember"
            runat="server"
            Text=" Remember Customer ID" />

    </div>

    <div class="form-group">

        <asp:Button
            ID="btnLogin"
            runat="server"
            Text="Secure Login"
            CssClass="login-btn"
            OnClick="btnLogin_Click" />

    </div>

    <div class="message">

        <asp:Label
            ID="lblMessage"
            runat="server"
            ForeColor="Red"
            Font-Bold="true">
        </asp:Label>

        <br />

        <asp:Label
            ID="lblAttempts"
            runat="server"
            ForeColor="DarkOrange"
            Font-Bold="true">
        </asp:Label>

    </div>

    <div class="links">

        <asp:HyperLink
            ID="lnkForgot"
            runat="server"
            NavigateUrl="ForgotPassword.aspx">
            Forgot Password?
        </asp:HyperLink>

        <br /><br />

        <asp:HyperLink
            ID="lnkRegister"
            runat="server"
            NavigateUrl="Register.aspx">
            New User Registration
        </asp:HyperLink>

    </div>

    <div class="security">
        🔒 Your connection is protected with industry-standard encryption.
        <br /><br />
        Never share your Password or OTP with anyone.
    </div>

    <div class="footer">
        © 2026 Manmad Bank. All Rights Reserved.
    </div>

</div>

</form>

</body>
</html>