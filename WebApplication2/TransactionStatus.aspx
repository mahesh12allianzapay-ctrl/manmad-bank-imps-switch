
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="TransactionStatus.aspx.cs"
    Inherits="WebApplication2.TransactionStatus" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Transaction Status</title>

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
            width: 94%;
            max-width: 950px;
            margin: 35px auto;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .title {
            color: #17365d;
            font-size: 23px;
            font-weight: 600;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #eef2f7;
        }

        .search-section {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 25px;
        }

        .search-label {
            display: block;
            color: #17365d;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .search-row {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .textbox {
            width: 100%;
            max-width: 500px;
            padding: 11px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
        }

        .textbox:focus {
            border-color: #17365d;
        }

        .btn {
            background: #17365d;
            color: white;
            border: none;
            padding: 11px 25px;
            border-radius: 7px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .details-title {
            color: #17365d;
            font-size: 19px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .details {
            width: 100%;
            border-collapse: collapse;
        }

        .details td {
            padding: 13px 15px;
            border-bottom: 1px solid #e2e8f0;
        }

        .labelTitle {
            width: 35%;
            font-weight: 600;
            color: #475569;
            background: #f8fafc;
        }

        .value {
            color: #172033;
            font-weight: 500;
        }

        .amount {
            font-size: 18px;
            font-weight: 700;
        }

        .status {
            font-weight: 700;
        }

        @media (max-width: 700px) {

            .header {
                padding: 18px 20px;
            }

            .header h1 {
                font-size: 20px;
            }

            .container {
                width: 96%;
                margin: 20px auto;
            }

            .card {
                padding: 18px;
            }

            .search-row {
                flex-direction: column;
                align-items: stretch;
            }

            .textbox {
                max-width: none;
            }

            .btn {
                width: 100%;
            }

            .labelTitle {
                width: 40%;
            }
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="header">

        <h1>Transaction Status</h1>

        <span>Manmad Bank</span>

    </div>

    <div class="container">

        <div class="card">

            <div class="title">
                Search Transaction
            </div>

            <div class="search-section">

                <span class="search-label">
                    Transaction Reference No
                </span>

                <div class="search-row">

                    <asp:TextBox
                        ID="txtReferenceNo"
                        runat="server"
                        CssClass="textbox"
                        MaxLength="50"
                        placeholder="Enter transaction reference number">
                    </asp:TextBox>

                    <asp:Button
                        ID="btnSearch"
                        runat="server"
                        Text="Search"
                        CssClass="btn"
                        OnClick="btnSearch_Click" />

                </div>

            </div>

            <div class="details-title">
                Transaction Details
            </div>

            <table class="details">

                <tr>
                    <td class="labelTitle">Customer ID</td>
                    <td class="value">
                        <asp:Label
                            ID="lblCustomerID"
                            runat="server">
                        </asp:Label>
                    </td>
                </tr>

                <tr>
                    <td class="labelTitle">Beneficiary Name</td>
                    <td class="value">
                        <asp:Label
                            ID="lblBeneficiary"
                            runat="server">
                        </asp:Label>
                    </td>
                </tr>

                <tr>
                    <td class="labelTitle">Account Number</td>
                    <td class="value">
                        <asp:Label
                            ID="lblAccountNo"
                            runat="server">
                        </asp:Label>
                    </td>
                </tr>

                <tr>
                    <td class="labelTitle">IFSC Code</td>
                    <td class="value">
                        <asp:Label
                            ID="lblIFSC"
                            runat="server">
                        </asp:Label>
                    </td>
                </tr>

                <tr>
                    <td class="labelTitle">Amount</td>
                    <td class="value amount">
                        ₹
                        <asp:Label
                            ID="lblAmount"
                            runat="server">
                        </asp:Label>
                    </td>
                </tr>

                <tr>
                    <td class="labelTitle">Transaction Type</td>
                    <td class="value">
                        <asp:Label
                            ID="lblType"
                            runat="server">
                        </asp:Label>
                    </td>
                </tr>

                <tr>
                    <td class="labelTitle">Status</td>
                    <td class="value status">
                        <asp:Label
                            ID="lblStatus"
                            runat="server">
                        </asp:Label>
                    </td>
                </tr>

                <tr>
                    <td class="labelTitle">Transaction Date</td>
                    <td class="value">
                        <asp:Label
                            ID="lblDate"
                            runat="server">
                        </asp:Label>
                    </td>
                </tr>

                <tr>
                    <td class="labelTitle">Remarks</td>
                    <td class="value">
                        <asp:Label
                            ID="lblRemarks"
                            runat="server">
                        </asp:Label>
                    </td>
                </tr>

            </table>

        </div>

    </div>

</form>

</body>

</html>
```
