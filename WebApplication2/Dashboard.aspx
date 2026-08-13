<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="WebApplication2.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Banking Dashboard - IMPS</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0" />

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        body {
            background: #f4f7fb;
            color: #1f2937;
        }

        /* =========================
           MAIN CONTAINER
           ========================= */

        .page-container {
            min-height: 100vh;
        }

        /* =========================
           HEADER
           ========================= */

        .header {
            background: linear-gradient(135deg, #063b6d, #0f5b96);
            color: white;
            padding: 18px 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }

        .bank-title {
            font-size: 24px;
            font-weight: 700;
        }

        .bank-subtitle {
            font-size: 13px;
            opacity: 0.85;
            margin-top: 4px;
        }

        .secure-text {
            font-size: 13px;
            text-align: right;
        }

        /* =========================
           NAVIGATION
           ========================= */

        .navigation {
            background: #ffffff;
            padding: 12px 35px;
            border-bottom: 1px solid #e1e7ef;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .navigation a {
            text-decoration: none;
            color: #24415d;
            padding: 9px 15px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            transition: 0.2s;
        }

        .navigation a:hover {
            background: #eaf2f9;
            color: #0f4c81;
        }

        .navigation .active {
            background: #0f4c81;
            color: white;
        }

        .navigation .logout {
            margin-left: auto;
            background: #b42318;
            color: white;
        }

        .navigation .logout:hover {
            background: #8f1d14;
        }

        /* =========================
           CONTENT
           ========================= */

        .content {
            max-width: 1400px;
            margin: auto;
            padding: 25px 30px 40px 30px;
        }

        /* =========================
           WELCOME
           ========================= */

        .welcome-panel {
            background: white;
            border-radius: 10px;
            padding: 22px 25px;
            margin-bottom: 22px;
            border: 1px solid #e4eaf1;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .welcome-panel h2 {
            color: #0f4c81;
            font-size: 22px;
            margin-bottom: 7px;
        }

        .welcome-panel p {
            color: #64748b;
            font-size: 14px;
        }

        /* =========================
           ACCOUNT DETAILS
           ========================= */

        .account-panel {
            background: white;
            border-radius: 10px;
            padding: 22px 25px;
            margin-bottom: 22px;
            border: 1px solid #e4eaf1;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .section-title {
            color: #163b5c;
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 18px;
        }

        .account-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
        }

        .account-item {
            background: #f7faff;
            border: 1px solid #e2eaf3;
            border-radius: 8px;
            padding: 15px;
        }

        .account-label {
            display: block;
            font-size: 12px;
            color: #64748b;
            margin-bottom: 7px;
            text-transform: uppercase;
            letter-spacing: 0.4px;
        }

        .account-value {
            display: block;
            font-size: 16px;
            font-weight: 700;
            color: #173f61;
            word-break: break-word;
        }

        .balance-item {
            background: #eef7f1;
            border-color: #cce5d4;
        }

        .balance-value {
            color: #137333;
            font-size: 20px;
        }

        /* =========================
           SUMMARY CARDS
           ========================= */

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 15px;
            margin-bottom: 22px;
        }

        .summary-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            border: 1px solid #e4eaf1;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
        }

        .summary-card::before {
            content: "";
            position: absolute;
            left: 0;
            top: 0;
            width: 4px;
            height: 100%;
            background: #0f4c81;
        }

        .summary-label {
            color: #64748b;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .summary-value {
            color: #173f61;
            font-size: 25px;
            font-weight: 700;
        }

        .summary-amount {
            font-size: 21px;
        }

        .success-card::before {
            background: #18864b;
        }

        .success-card .summary-value {
            color: #18864b;
        }

        .pending-card::before {
            background: #d97706;
        }

        .pending-card .summary-value {
            color: #d97706;
        }

        .failed-card::before {
            background: #c62828;
        }

        .failed-card .summary-value {
            color: #c62828;
        }

        /* =========================
           TRANSACTION SECTION
           ========================= */

        .transaction-panel {
            background: white;
            border-radius: 10px;
            padding: 22px 25px;
            border: 1px solid #e4eaf1;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .transaction-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }

        .transaction-note {
            color: #64748b;
            font-size: 13px;
        }

        /* =========================
           GRIDVIEW
           ========================= */

        .transaction-grid {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        .transaction-grid th {
            background: #0f4c81;
            color: white;
            padding: 13px 12px;
            text-align: left;
            font-weight: 600;
            border: 1px solid #0f4c81;
        }

        .transaction-grid td {
            padding: 12px;
            border-bottom: 1px solid #e5eaf0;
            color: #374151;
        }

        .transaction-grid tr:nth-child(even) {
            background: #f8fafc;
        }

        .transaction-grid tr:hover {
            background: #eef5fb;
        }

        /* =========================
           FOOTER
           ========================= */

        .footer {
            text-align: center;
            padding: 20px;
            color: #64748b;
            font-size: 12px;
            margin-top: 20px;
        }

        /* =========================
           RESPONSIVE
           ========================= */

        @media (max-width: 1100px) {

            .account-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .summary-grid {
                grid-template-columns: repeat(3, 1fr);
            }

        }

        @media (max-width: 700px) {

            .header {
                padding: 15px 20px;
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .secure-text {
                text-align: left;
            }

            .navigation {
                padding: 10px 15px;
            }

            .navigation .logout {
                margin-left: 0;
            }

            .content {
                padding: 15px;
            }

            .account-grid {
                grid-template-columns: 1fr;
            }

            .summary-grid {
                grid-template-columns: 1fr;
            }

            .transaction-panel {
                overflow-x: auto;
            }

            .transaction-grid {
                min-width: 650px;
            }

        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="page-container">

    <!-- =========================
         HEADER
         ========================= -->

    <header class="header">

        <div>
            <div class="bank-title">
                MANMAD BANK
            </div>

            <div class="bank-subtitle">
                IMPS Banking Portal
            </div>
        </div>

        <div class="secure-text">
            Secure Banking Session
            <br />
            IMPS Transaction Services
        </div>

    </header>


    <!-- =========================
         NAVIGATION
         ========================= -->

    <nav class="navigation">

        <a href="Dashboard.aspx"
           class="active">
            Dashboard
        </a>

        <a href="IMPSTransaction.aspx">
            IMPS Transfer
        </a>

        <a href="Beneficiary.aspx">
            Beneficiary
        </a>

        <a href="BalanceEnquiry.aspx">
            Balance Enquiry
        </a>

        <a href="MiniStatement.aspx">
            Mini Statement
        </a>

        <a href="TransactionStatus.aspx">
            Transaction Status
        </a>

        <a href="Reports.aspx">
            Reports
        </a>

        <a href="Login.aspx"
           class="logout">
            Logout
        </a>

    </nav>


    <!-- =========================
         MAIN CONTENT
         ========================= -->

    <main class="content">


        <!-- WELCOME -->

        <section class="welcome-panel">

            <h2>
                Welcome to Manmad Bank
            </h2>

            <p>
                Manage your account and monitor your IMPS transactions securely.
            </p>

        </section>


        <!-- ACCOUNT INFORMATION -->

        <section class="account-panel">

            <div class="section-title">
                Account Information
            </div>

            <div class="account-grid">

                <div class="account-item">

                    <span class="account-label">
                        Customer ID
                    </span>

                    <asp:Label
                        ID="lblCustomerID"
                        runat="server"
                        CssClass="account-value">
                    </asp:Label>

                </div>


                <div class="account-item">

                    <span class="account-label">
                        Customer Name
                    </span>

                    <asp:Label
                        ID="lblCustomerName"
                        runat="server"
                        CssClass="account-value">
                    </asp:Label>

                </div>


                <div class="account-item">

                    <span class="account-label">
                        Account Number
                    </span>

                    <asp:Label
                        ID="lblAccountNumber"
                        runat="server"
                        CssClass="account-value">
                    </asp:Label>

                </div>


                <div class="account-item">

                    <span class="account-label">
                        Account Type
                    </span>

                    <asp:Label
                        ID="lblAccountType"
                        runat="server"
                        CssClass="account-value">
                    </asp:Label>

                </div>


                <div class="account-item balance-item">

                    <span class="account-label">
                        Available Balance
                    </span>

                    <span class="account-value balance-value">

                        ₹

                        <asp:Label
                            ID="lblBalance"
                            runat="server">
                        </asp:Label>

                    </span>

                </div>

            </div>

        </section>


        <!-- =========================
             TRANSACTION SUMMARY
             ========================= -->

        <section class="summary-grid">


            <!-- TODAY TRANSACTIONS -->

            <div class="summary-card">

                <div class="summary-label">
                    Today's IMPS Transactions
                </div>

                <asp:Label
                    ID="lblTodayTxn"
                    runat="server"
                    CssClass="summary-value">
                </asp:Label>

            </div>


            <!-- TODAY AMOUNT -->

            <div class="summary-card">

                <div class="summary-label">
                    Today's Transfer Amount
                </div>

                <div class="summary-value summary-amount">

                    ₹

                    <asp:Label
                        ID="lblTodayAmount"
                        runat="server">
                    </asp:Label>

                </div>

            </div>


            <!-- SUCCESS -->

            <div class="summary-card success-card">

                <div class="summary-label">
                    Successful
                </div>

                <asp:Label
                    ID="lblSuccessTxn"
                    runat="server"
                    CssClass="summary-value">
                </asp:Label>

            </div>


            <!-- PENDING -->

            <div class="summary-card pending-card">

                <div class="summary-label">
                    Pending
                </div>

                <asp:Label
                    ID="lblPendingTxn"
                    runat="server"
                    CssClass="summary-value">
                </asp:Label>

            </div>


            <!-- FAILED -->

            <div class="summary-card failed-card">

                <div class="summary-label">
                    Failed
                </div>

                <asp:Label
                    ID="lblFailedTxn"
                    runat="server"
                    CssClass="summary-value">
                </asp:Label>

            </div>


        </section>


        <!-- =========================
             RECENT TRANSACTIONS
             ========================= -->

        <section class="transaction-panel">

            <div class="transaction-header">

                <div class="section-title">
                    Recent IMPS Transactions
                </div>

                <div class="transaction-note">
                    Latest 10 transactions
                </div>

            </div>


            <asp:GridView
                ID="gvTransactions"
                runat="server"
                AutoGenerateColumns="true"
                CssClass="transaction-grid"
                GridLines="None"
                Width="100%"
                EmptyDataText="No IMPS transactions found.">

            </asp:GridView>


        </section>


    </main>


    <!-- =========================
         FOOTER
         ========================= -->

    <footer class="footer">

        © 2026 Manmad Bank |
        Secure IMPS Banking Portal

    </footer>


</div>

</form>

</body>

</html>