```aspx
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="BalanceEnquiry.aspx.cs"
    Inherits="WebApplication2.BalanceEnquiry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Balance Enquiry</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        body {
            background: #eef2f7;
            min-height: 100vh;
        }

        .header {
            background: #17365d;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 24px;
            font-weight: 600;
        }

        .header span {
            font-size: 14px;
            opacity: 0.9;
        }

        .container {
            width: 90%;
            max-width: 900px;
            margin: 40px auto;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .card-title {
            font-size: 22px;
            color: #17365d;
            margin-bottom: 25px;
            font-weight: 600;
            border-bottom: 2px solid #eef2f7;
            padding-bottom: 15px;
        }

        .details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .detail-box {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 16px;
        }

        .label {
            display: block;
            color: #64748b;
            font-size: 13px;
            margin-bottom: 6px;
        }

        .value {
            display: block;
            color: #172033;
            font-size: 17px;
            font-weight: 600;
        }

        .balance-box {
            background: #17365d;
            color: white;
            border-radius: 10px;
            padding: 22px;
            margin-top: 25px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .balance-item .label {
            color: #dbeafe;
        }

        .balance-item .value {
            color: white;
            font-size: 24px;
        }

        .last-updated {
            margin-top: 20px;
            padding: 12px;
            background: #f1f5f9;
            border-radius: 8px;
            text-align: center;
            color: #64748b;
            font-size: 14px;
        }

        .button-area {
            text-align: center;
            margin-top: 25px;
        }

        .refresh-btn {
            background: #17365d;
            color: white;
            border: none;
            padding: 12px 28px;
            border-radius: 7px;
            font-size: 15px;
            cursor: pointer;
        }

        .refresh-btn:hover {
            opacity: 0.9;
        }

        @media (max-width: 650px) {
            .details,
            .balance-box {
                grid-template-columns: 1fr;
            }

            .header {
                padding: 18px 20px;
            }

            .container {
                width: 94%;
            }

            .card {
                padding: 20px;
            }
        }
    </style>
</head>

<body>

<form id="form1" runat="server">

    <div class="header">
        <h1>Bank Balance Enquiry</h1>
        <span>Manmad Bank</span>
    </div>

    <div class="container">

        <div class="card">

            <div class="card-title">
                Account Details
            </div>

            <div class="details">

                <div class="detail-box">
                    <span class="label">Customer ID</span>
                    <asp:Label
                        ID="lblCustomerID"
                        runat="server"
                        CssClass="value">
                    </asp:Label>
                </div>

                <div class="detail-box">
                    <span class="label">Account Number</span>
                    <asp:Label
                        ID="lblAccountNumber"
                        runat="server"
                        CssClass="value">
                    </asp:Label>
                </div>

                <div class="detail-box">
                    <span class="label">Customer Name</span>
                    <asp:Label
                        ID="lblCustomerName"
                        runat="server"
                        CssClass="value">
                    </asp:Label>
                </div>

                <div class="detail-box">
                    <span class="label">Account Type</span>
                    <asp:Label
                        ID="lblAccountType"
                        runat="server"
                        CssClass="value">
                    </asp:Label>
                </div>

            </div>

            <div class="balance-box">

                <div class="balance-item">
                    <span class="label">Available Balance</span>

                    <asp:Label
                        ID="lblAvailableBalance"
                        runat="server"
                        CssClass="value">
                    </asp:Label>
                </div>

                <div class="balance-item">
                    <span class="label">Ledger Balance</span>

                    <asp:Label
                        ID="lblLedgerBalance"
                        runat="server"
                        CssClass="value">
                    </asp:Label>
                </div>

            </div>

            <div class="last-updated">

                Last Updated:
                
                <asp:Label
                    ID="lblLastUpdated"
                    runat="server">
                </asp:Label>

            </div>

            <div class="button-area">

                <asp:Button
                    ID="btnRefresh"
                    runat="server"
                    Text="Refresh Balance"
                    CssClass="refresh-btn"
                    OnClick="btnRefresh_Click" />

            </div>

        </div>

    </div>

</form>

</body>
</html>
```
