<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication2.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Manmad Bank - Secure Internet Banking</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #071e35, #0f4c81, #09253f);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        /* MAIN CONTAINER */

        .login-wrapper {
            width: 100%;
            max-width: 1050px;
            min-height: 620px;
            display: flex;
            background: #ffffff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 25px 60px rgba(0,0,0,0.35);
        }

        /* LEFT BANK PANEL */

        .bank-panel {
            width: 45%;
            background: linear-gradient(150deg, #0b355c, #0f4c81);
            color: white;
            padding: 55px 45px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .bank-logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .bank-icon {
            width: 55px;
            height: 55px;
            border-radius: 12px;
            background: rgba(255,255,255,0.15);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
        }

        .bank-logo h1 {
            font-size: 27px;
            letter-spacing: 1px;
        }

        .bank-logo p {
            margin-top: 4px;
            font-size: 13px;
            opacity: 0.85;
        }

        .bank-content {
            margin-top: 30px;
        }

        .bank-content h2 {
            font-size: 34px;
            line-height: 1.2;
            margin-bottom: 18px;
        }

        .bank-content p {
            font-size: 15px;
            line-height: 1.7;
            opacity: 0.88;
        }

        .security-list {
            margin-top: 30px;
        }

        .security-item {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
            font-size: 14px;
        }

        .security-icon {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background: rgba(255,255,255,0.14);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .bank-footer {
            font-size: 12px;
            opacity: 0.7;
        }

        /* RIGHT LOGIN PANEL */

        .login-panel {
            width: 55%;
            padding: 55px 65px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-header {
            margin-bottom: 30px;
        }

        .login-header h2 {
            color: #172b3a;
            font-size: 30px;
            margin-bottom: 8px;
        }

        .login-header p {
            color: #777;
            font-size: 14px;
        }

        /* FORM */

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            color: #263746;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .input-container {
            position: relative;
            width: 100%;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 18px;
            color: #6d7d8a;
            z-index: 2;
        }

        .textbox {
            width: 100%;
            height: 50px;
            padding: 0 15px 0 45px;
            border: 1px solid #d6dce1;
            border-radius: 9px;
            background: #fafcfe;
            color: #263746;
            font-size: 15px;
            outline: none;
            transition: all 0.2s ease;
        }

        .textbox:focus {
            background: #ffffff;
            border-color: #0f4c81;
            box-shadow: 0 0 0 3px rgba(15,76,129,0.10);
        }

        /* PASSWORD */

        .password-input {
            padding-right: 52px !important;
        }

        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            border: none;
            background: transparent;
            cursor: pointer;
            width: 38px;
            height: 38px;
            border-radius: 6px;
            font-size: 18px;
            color: #536573;
        }

        .password-toggle:hover {
            background: #edf4fa;
        }

        /* REMEMBER */

        .remember-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 22px;
        }

        .remember-checkbox {
            color: #536573;
            font-size: 13px;
        }

        .remember-checkbox input {
            margin-right: 6px;
        }

        /* LOGIN BUTTON */

        .login-btn {
            width: 100%;
            height: 52px;
            border: none;
            border-radius: 9px;
            background: linear-gradient(135deg, #0f4c81, #0b3a64);
            color: white;
            font-size: 16px;
            font-weight: 700;
            letter-spacing: 0.3px;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 7px 18px rgba(15,76,129,0.25);
        }

        .login-btn:hover {
            background: linear-gradient(135deg, #0b416f, #072f50);
            transform: translateY(-1px);
        }

        .login-btn:active {
            transform: translateY(0);
        }

        /* VALIDATION */

        .validator {
            display: block;
            margin-top: 6px;
            font-size: 12px;
        }

        /* MESSAGE */

        .message-box {
            margin-top: 18px;
            min-height: 25px;
            text-align: center;
        }

        .message {
            font-size: 13px;
            font-weight: 600;
        }

        .attempts {
            display: block;
            margin-top: 5px;
            color: #d97706;
            font-size: 12px;
            font-weight: 600;
        }

        /* LINKS */

        .links {
            display: flex;
            justify-content: center;
            gap: 12px;
            margin-top: 23px;
            font-size: 13px;
        }

        .links a {
            color: #0f4c81;
            text-decoration: none;
            font-weight: 600;
        }

        .links a:hover {
            text-decoration: underline;
        }

        .separator {
            color: #bbb;
        }

        /* SECURITY NOTICE */

        .security-notice {
            margin-top: 25px;
            padding: 13px 15px;
            border-radius: 9px;
            background: #f0f7fd;
            border: 1px solid #d8e9f7;
            color: #496171;
            font-size: 12px;
            line-height: 1.6;
        }

        .security-notice strong {
            color: #0f4c81;
        }

        /* RESPONSIVE */

        @media (max-width: 850px) {

            .login-wrapper {
                max-width: 500px;
            }

            .bank-panel {
                display: none;
            }

            .login-panel {
                width: 100%;
                padding: 45px 35px;
            }
        }

        @media (max-width: 450px) {

            body {
                padding: 10px;
            }

            .login-wrapper {
                border-radius: 14px;
            }

            .login-panel {
                padding: 35px 25px;
            }

            .login-header h2 {
                font-size: 26px;
            }

            .links {
                flex-direction: column;
                align-items: center;
                gap: 7px;
            }

            .separator {
                display: none;
            }
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="login-wrapper">

        <!-- LEFT SIDE -->

        <div class="bank-panel">

            <div>

                <div class="bank-logo">

                    <div class="bank-icon">
                        🏦
                    </div>

                    <div>
                        <h1>Manmad Bank</h1>
                        <p>Secure Internet Banking</p>
                    </div>

                </div>

                <div class="bank-content">

                    <h2>
                        Banking made<br />
                        simple & secure.
                    </h2>

                    <p>
                        Access your banking services securely and
                        manage your transactions with confidence.
                    </p>

                    <div class="security-list">

                        <div class="security-item">

                            <div class="security-icon">
                                🔒
                            </div>

                            <span>
                                Secure authentication
                            </span>

                        </div>

                        <div class="security-item">

                            <div class="security-icon">
                                🛡
                            </div>

                            <span>
                                Role-based access control
                            </span>

                        </div>

                        <div class="security-item">

                            <div class="security-icon">
                                🔐
                            </div>

                            <span>
                                Protected banking sessions
                            </span>

                        </div>

                    </div>

                </div>

            </div>

            <div class="bank-footer">

                © 2026 Manmad Bank. All Rights Reserved.

            </div>

        </div>


        <!-- RIGHT SIDE -->

        <div class="login-panel">

            <div class="login-header">

                <h2>Welcome Back</h2>

                <p>
                    Sign in to access your secure banking account.
                </p>

            </div>


            <!-- CUSTOMER ID -->

            <div class="form-group">

                <label class="form-label">
                    Customer ID
                </label>

                <div class="input-container">

                    <span class="input-icon">
                        👤
                    </span>

                    <asp:TextBox
                        ID="txtUser"
                        runat="server"
                        CssClass="textbox"
                        MaxLength="20"
                        placeholder="Enter Customer ID">
                    </asp:TextBox>

                </div>

                <asp:RequiredFieldValidator
                    ID="rfvUser"
                    runat="server"
                    ControlToValidate="txtUser"
                    ErrorMessage="Customer ID is required."
                    Display="Dynamic"
                    ForeColor="Red"
                    CssClass="validator">
                </asp:RequiredFieldValidator>

            </div>


            <!-- PASSWORD -->

            <div class="form-group">

                <label class="form-label">
                    Password
                </label>

                <div class="input-container">

                    <span class="input-icon">
                        🔒
                    </span>

                    <asp:TextBox
                        ID="txtPassword"
                        runat="server"
                        CssClass="textbox password-input"
                        TextMode="Password"
                        MaxLength="30"
                        placeholder="Enter Password">
                    </asp:TextBox>

                    <button
                        type="button"
                        class="password-toggle"
                        onclick="togglePassword()"
                        aria-label="Show password">

                        👁

                    </button>

                </div>

                <asp:RequiredFieldValidator
                    ID="rfvPassword"
                    runat="server"
                    ControlToValidate="txtPassword"
                    ErrorMessage="Password is required."
                    Display="Dynamic"
                    ForeColor="Red"
                    CssClass="validator">
                </asp:RequiredFieldValidator>

            </div>


            <!-- REMEMBER -->

            <div class="remember-row">

                <asp:CheckBox
                    ID="chkRemember"
                    runat="server"
                    Text=" Remember Customer ID"
                    CssClass="remember-checkbox" />

            </div>


            <!-- LOGIN BUTTON -->

            <div>

                <asp:Button
                    ID="btnLogin"
                    runat="server"
                    Text="🔐  Secure Login"
                    CssClass="login-btn"
                    OnClick="btnLogin_Click" />

            </div>


            <!-- LOGIN MESSAGE -->

            <div class="message-box">

                <asp:Label
                    ID="lblMessage"
                    runat="server"
                    CssClass="message"
                    ForeColor="Red"
                    Font-Bold="true">
                </asp:Label>

                <asp:Label
                    ID="lblAttempts"
                    runat="server"
                    CssClass="attempts"
                    Font-Bold="true">
                </asp:Label>

            </div>


            <!-- LINKS -->

            <div class="links">

                <asp:HyperLink
                    ID="lnkForgot"
                    runat="server"
                    NavigateUrl="ForgotPassword.aspx">
                    Forgot Password?
                </asp:HyperLink>

                <span class="separator">|</span>

                <asp:HyperLink
                    ID="lnkRegister"
                    runat="server"
                    NavigateUrl="Register.aspx">
                    New User Registration
                </asp:HyperLink>

            </div>


            <!-- SECURITY NOTICE -->

            <div class="security-notice">

                🔒 <strong>Security Notice</strong>

                <br />

                Never share your Customer ID, Password or OTP
                with anyone.

                <br />

                Always log out after completing your banking session.

            </div>

        </div>

    </div>

</form>


<!-- SHOW / HIDE PASSWORD -->

<script type="text/javascript">

    function togglePassword() {

        var passwordBox =
            document.getElementById('<%= txtPassword.ClientID %>');

        var toggleButton =
            document.querySelector('.password-toggle');

        if (passwordBox.type === "password") {

            passwordBox.type = "text";

            toggleButton.innerHTML = "🙈";

            toggleButton.setAttribute(
                "aria-label",
                "Hide password"
            );

        }
        else {

            passwordBox.type = "password";

            toggleButton.innerHTML = "👁";

            toggleButton.setAttribute(
                "aria-label",
                "Show password"
            );
        }
    }

</script>

</body>

</html>