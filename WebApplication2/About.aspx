
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WebApplication2.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Manmad Bank | Internet Banking</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <style>

        /* =====================================================
           STANDARD BANKING COLOUR SYSTEM
           Background : #F3F6F9
           Primary    : #1E3A5F
           Accent     : #2F80ED
           White      : #FFFFFF
        ===================================================== */


        /* =====================================================
           RESET
        ===================================================== */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Segoe UI", Tahoma, Arial, sans-serif;
        }


        /* =====================================================
           BODY
        ===================================================== */

        body {

            min-height: 100vh;

            background: #F3F6F9;

            display: flex;

            align-items: center;

            justify-content: center;

            padding: 25px;

            color: #1F2937;
        }


        /* =====================================================
           MAIN LOGIN CARD
        ===================================================== */

        .login-wrapper {

            width: 100%;

            max-width: 1050px;

            min-height: 620px;

            display: flex;

            background: #FFFFFF;

            border-radius: 16px;

            overflow: hidden;

            border: 1px solid #E1E7ED;

            box-shadow:
                0 15px 45px rgba(30,58,95,0.12);
        }


        /* =====================================================
           LEFT BANK PANEL
        ===================================================== */

        .bank-panel {

            width: 43%;

            background: #1E3A5F;

            color: #FFFFFF;

            padding: 50px 45px;

            display: flex;

            flex-direction: column;

            justify-content: space-between;

            position: relative;

            overflow: hidden;
        }


        /* subtle background design */

        .bank-panel::before {

            content: "";

            position: absolute;

            width: 300px;

            height: 300px;

            border-radius: 50%;

            background: rgba(255,255,255,0.035);

            top: -120px;

            right: -120px;
        }


        .bank-panel::after {

            content: "";

            position: absolute;

            width: 220px;

            height: 220px;

            border-radius: 50%;

            border: 1px solid rgba(255,255,255,0.05);

            bottom: -100px;

            left: -80px;
        }


        /* =====================================================
           LOGO
        ===================================================== */

        .bank-logo {

            position: relative;

            z-index: 2;

            display: flex;

            align-items: center;

            gap: 14px;
        }


        .bank-icon {

            width: 54px;

            height: 54px;

            border-radius: 12px;

            background: #FFFFFF;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 25px;

            box-shadow:
                0 6px 15px rgba(0,0,0,0.12);
        }


        .bank-logo h1 {

            font-size: 25px;

            font-weight: 700;

            letter-spacing: -0.3px;
        }


        .bank-logo p {

            margin-top: 4px;

            color: #C9D7E5;

            font-size: 11px;

            letter-spacing: 0.7px;
        }


        /* =====================================================
           BANK CONTENT
        ===================================================== */

        .bank-content {

            position: relative;

            z-index: 2;

            margin-top: 40px;
        }


        .bank-content .tag {

            display: inline-block;

            padding: 6px 10px;

            background: rgba(255,255,255,0.09);

            border: 1px solid rgba(255,255,255,0.12);

            border-radius: 20px;

            color: #DCE8F3;

            font-size: 10px;

            font-weight: 600;

            letter-spacing: 0.6px;

            text-transform: uppercase;

            margin-bottom: 18px;
        }


        .bank-content h2 {

            font-size: 36px;

            line-height: 1.15;

            font-weight: 600;

            letter-spacing: -0.8px;

            margin-bottom: 18px;
        }


        .bank-content p {

            max-width: 380px;

            color: #C8D5E2;

            font-size: 14px;

            line-height: 1.8;
        }


        /* =====================================================
           SECURITY ITEMS
        ===================================================== */

        .security-list {

            margin-top: 30px;

            display: flex;

            flex-direction: column;

            gap: 13px;
        }


        .security-item {

            display: flex;

            align-items: center;

            gap: 12px;

            color: #E4ECF3;

            font-size: 12px;
        }


        .security-icon {

            width: 34px;

            height: 34px;

            border-radius: 9px;

            display: flex;

            align-items: center;

            justify-content: center;

            background: rgba(255,255,255,0.08);

            border: 1px solid rgba(255,255,255,0.08);

            font-size: 14px;
        }


        /* =====================================================
           FOOTER
        ===================================================== */

        .bank-footer {

            position: relative;

            z-index: 2;

            color: #9FB2C5;

            font-size: 10px;
        }


        /* =====================================================
           RIGHT LOGIN PANEL
        ===================================================== */

        .login-panel {

            width: 57%;

            background: #FFFFFF;

            padding: 55px 70px;

            display: flex;

            flex-direction: column;

            justify-content: center;
        }


        /* =====================================================
           LOGIN HEADER
        ===================================================== */

        .login-header {

            margin-bottom: 30px;
        }


        .login-label {

            color: #2F80ED;

            font-size: 11px;

            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: 0.8px;

            margin-bottom: 9px;
        }


        .login-header h2 {

            color: #1E293B;

            font-size: 30px;

            font-weight: 700;

            letter-spacing: -0.5px;

            margin-bottom: 8px;
        }


        .login-header p {

            color: #64748B;

            font-size: 13px;

            line-height: 1.6;
        }


        /* =====================================================
           FORM
        ===================================================== */

        .form-group {

            margin-bottom: 20px;
        }


        .form-label {

            display: block;

            color: #334155;

            font-size: 12px;

            font-weight: 700;

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

            z-index: 2;

            color: #94A3B8;

            font-size: 16px;

            pointer-events: none;
        }


        .textbox {

            width: 100%;

            height: 52px;

            padding: 0 50px 0 45px;

            background: #F8FAFC;

            border: 1px solid #D9E2EC;

            border-radius: 9px;

            color: #1E293B;

            font-size: 14px;

            outline: none;

            transition: all 0.2s ease;
        }


        .textbox::placeholder {

            color: #94A3B8;
        }


        .textbox:hover {

            border-color: #B8C6D4;

            background: #FFFFFF;
        }


        .textbox:focus {

            border-color: #2F80ED;

            background: #FFFFFF;

            box-shadow:
                0 0 0 3px rgba(47,128,237,0.10);
        }


        /* =====================================================
           PASSWORD
        ===================================================== */

        .password-input {

            padding-right: 52px !important;
        }


        .password-toggle {

            position: absolute;

            right: 7px;

            top: 50%;

            transform: translateY(-50%);

            width: 38px;

            height: 38px;

            border: none;

            border-radius: 7px;

            background: transparent;

            color: #64748B;

            cursor: pointer;

            font-size: 16px;

            transition: all 0.2s ease;
        }


        .password-toggle:hover {

            background: #EEF4FA;

            color: #1E3A5F;
        }


        /* =====================================================
           VALIDATORS
        ===================================================== */

        .validator {

            display: block;

            margin-top: 6px;

            font-size: 11px;
        }


        /* =====================================================
           REMEMBER
        ===================================================== */

        .remember-row {

            display: flex;

            align-items: center;

            margin-bottom: 20px;
        }


        .remember-checkbox {

            color: #64748B;

            font-size: 12px;
        }


        .remember-checkbox input {

            margin-right: 6px;

            accent-color: #2F80ED;
        }


        /* =====================================================
           LOGIN BUTTON
        ===================================================== */

        .login-btn {

            width: 100%;

            height: 52px;

            border: none;

            border-radius: 9px;

            background: #1E3A5F;

            color: #FFFFFF;

            font-size: 14px;

            font-weight: 700;

            letter-spacing: 0.2px;

            cursor: pointer;

            box-shadow:
                0 6px 16px rgba(30,58,95,0.18);

            transition: all 0.2s ease;
        }


        .login-btn:hover {

            background: #162F4D;

            transform: translateY(-1px);

            box-shadow:
                0 9px 20px rgba(30,58,95,0.22);
        }


        .login-btn:active {

            transform: translateY(0);
        }


        /* =====================================================
           MESSAGE
        ===================================================== */

        .message-box {

            min-height: 24px;

            margin-top: 15px;

            text-align: center;
        }


        .message {

            font-size: 12px;

            font-weight: 600;
        }


        .attempts {

            display: block;

            margin-top: 4px;

            color: #B7791F;

            font-size: 11px;

            font-weight: 600;
        }


        /* =====================================================
           LINKS
        ===================================================== */

        .links {

            display: flex;

            align-items: center;

            justify-content: center;

            gap: 11px;

            margin-top: 19px;

            font-size: 12px;
        }


        .links a {

            color: #2F80ED;

            text-decoration: none;

            font-weight: 600;

            transition: 0.2s;
        }


        .links a:hover {

            color: #1E3A5F;

            text-decoration: underline;
        }


        .separator {

            color: #CBD5E1;
        }


        /* =====================================================
           SECURITY NOTICE
        ===================================================== */

        .security-notice {

            margin-top: 22px;

            padding: 13px 15px;

            border-radius: 9px;

            background: #F8FAFC;

            border: 1px solid #E2E8F0;

            color: #64748B;

            font-size: 10.5px;

            line-height: 1.65;
        }


        .security-notice strong {

            color: #334155;

            font-size: 11px;
        }


        /* =====================================================
           SECURE CONNECTION
        ===================================================== */

        .secure-connection {

            display: flex;

            align-items: center;

            justify-content: center;

            gap: 7px;

            margin-top: 14px;

            color: #94A3B8;

            font-size: 10px;
        }


        .secure-dot {

            width: 6px;

            height: 6px;

            border-radius: 50%;

            background: #16A34A;

            box-shadow:
                0 0 0 3px rgba(22,163,74,0.10);
        }


        /* =====================================================
           TABLET
        ===================================================== */

        @media (max-width: 850px) {

            .login-wrapper {

                max-width: 550px;
            }


            .bank-panel {

                display: none;
            }


            .login-panel {

                width: 100%;

                padding: 50px;
            }
        }


        /* =====================================================
           MOBILE
        ===================================================== */

        @media (max-width: 500px) {

            body {

                padding: 12px;
            }


            .login-wrapper {

                min-height: auto;

                border-radius: 14px;
            }


            .login-panel {

                padding: 35px 24px;
            }


            .login-header h2 {

                font-size: 26px;
            }


            .links {

                flex-direction: column;

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


    <!-- =====================================================
         MAIN LOGIN CONTAINER
    ===================================================== -->

    <div class="login-wrapper">


        <!-- =================================================
             LEFT BANK INFORMATION
        ================================================== -->

        <div class="bank-panel">


            <div>


                <!-- BANK LOGO -->

                <div class="bank-logo">


                    <div class="bank-icon">

                        🏦

                    </div>


                    <div>

                        <h1>
                            Manmad Bank
                        </h1>

                        <p>
                            Secure Internet Banking
                        </p>

                    </div>


                </div>



                <!-- BANK CONTENT -->

                <div class="bank-content">


                    <div class="tag">

                        Trusted Banking

                    </div>


                    <h2>

                        Banking made<br />
                        simple & secure.

                    </h2>


                    <p>

                        Access your banking services securely,
                        manage transactions and monitor your
                        account from one convenient place.

                    </p>



                    <!-- SECURITY FEATURES -->

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

                                ⚡

                            </div>

                            <span>
                                Fast transaction processing
                            </span>

                        </div>


                        <div class="security-item">

                            <div class="security-icon">

                                ✓

                            </div>

                            <span>
                                Protected banking sessions
                            </span>

                        </div>


                    </div>

                </div>

            </div>



            <!-- FOOTER -->

            <div class="bank-footer">

                © 2026 Manmad Bank. All Rights Reserved.

            </div>


        </div>



        <!-- =================================================
             RIGHT LOGIN FORM
        ================================================== -->

        <div class="login-panel">


            <!-- LOGIN HEADER -->

            <div class="login-header">


                <div class="login-label">

                    Secure Internet Banking

                </div>


                <h2>

                    Welcome Back

                </h2>


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



            <!-- REMEMBER CUSTOMER ID -->

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


                <span class="separator">

                    |

                </span>


                <asp:HyperLink
                    ID="lnkRegister"
                    runat="server"
                    NavigateUrl="Register.aspx">

                    New User Registration

                </asp:HyperLink>


            </div>



            <!-- SECURITY NOTICE -->

            <div class="security-notice">


                🔒

                <strong>

                    Security Notice

                </strong>


                <br />


                Never share your Customer ID, Password or OTP
                with anyone.


                <br />


                Always log out after completing your banking session.


            </div>



            <!-- SECURE CONNECTION -->

            <div class="secure-connection">


                <span class="secure-dot"></span>


                Secure banking connection


            </div>


        </div>


    </div>

</form>



<!-- =====================================================
     SHOW / HIDE PASSWORD
====================================================== -->

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

