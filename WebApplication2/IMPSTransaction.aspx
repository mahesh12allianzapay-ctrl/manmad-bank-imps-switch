<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IMPSTransaction.aspx.cs" Inherits="WebApplication2.IMPSTransaction" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IMPS Fund Transfer</title>

```
<meta name="viewport" content="width=device-width, initial-scale=1" />

<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: "Segoe UI", Arial, sans-serif;
    }

    body {
        background: #f4f7fb;
        color: #1f2937;
    }

    .top-header {
        background: #0b3a66;
        color: #ffffff;
        padding: 18px 35px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .bank-title {
        font-size: 24px;
        font-weight: 600;
    }

    .module-title {
        font-size: 14px;
        opacity: 0.9;
    }

    .page-container {
        max-width: 900px;
        margin: 35px auto;
        padding: 0 20px;
    }

    .breadcrumb {
        font-size: 13px;
        color: #6b7280;
        margin-bottom: 15px;
    }

    .card {
        background: #ffffff;
        border: 1px solid #e5e7eb;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
        overflow: hidden;
    }

    .card-header {
        background: #f8fafc;
        border-bottom: 1px solid #e5e7eb;
        padding: 22px 28px;
    }

    .card-header h2 {
        color: #0b3a66;
        font-size: 22px;
        margin-bottom: 5px;
    }

    .card-header p {
        color: #6b7280;
        font-size: 13px;
    }

    .form-body {
        padding: 28px;
    }

    .section-title {
        color: #0b3a66;
        font-size: 16px;
        font-weight: 600;
        margin-bottom: 18px;
        padding-bottom: 8px;
        border-bottom: 1px solid #e5e7eb;
    }

    .form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
    }

    .form-group.full-width {
        grid-column: 1 / -1;
    }

    .form-label {
        font-size: 13px;
        font-weight: 600;
        color: #374151;
        margin-bottom: 7px;
    }

    .required {
        color: #dc2626;
    }

    .textbox {
        width: 100%;
        height: 44px;
        padding: 10px 12px;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        background: #ffffff;
        color: #111827;
        font-size: 14px;
        outline: none;
        transition: border-color 0.2s, box-shadow 0.2s;
    }

    .textbox:focus {
        border-color: #0b5ea8;
        box-shadow: 0 0 0 3px rgba(11, 94, 168, 0.10);
    }

    .textbox[readonly] {
        background: #f1f5f9;
        color: #475569;
    }

    .help-text {
        margin-top: 5px;
        font-size: 11px;
        color: #64748b;
    }

    .amount-box {
        font-weight: 600;
    }

    .action-area {
        margin-top: 28px;
        padding-top: 22px;
        border-top: 1px solid #e5e7eb;
        display: flex;
        justify-content: flex-end;
        align-items: center;
        gap: 15px;
    }

    .btn {
        min-width: 190px;
        height: 46px;
        padding: 0 22px;
        background: #0b5ea8;
        color: #ffffff;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.2s;
    }

    .btn:hover {
        background: #084b86;
    }

    .btn:disabled {
        background: #94a3b8;
        cursor: not-allowed;
    }

    .message {
        display: block;
        flex: 1;
        font-size: 13px;
        font-weight: 600;
    }

    .security-note {
        margin-top: 18px;
        padding: 12px 15px;
        background: #eff6ff;
        border: 1px solid #dbeafe;
        border-radius: 6px;
        color: #1e40af;
        font-size: 12px;
    }

    .footer {
        text-align: center;
        color: #94a3b8;
        font-size: 11px;
        margin-top: 20px;
    }

    @media (max-width: 700px) {
        .top-header {
            padding: 16px 20px;
        }

        .bank-title {
            font-size: 20px;
        }

        .module-title {
            display: none;
        }

        .page-container {
            margin-top: 20px;
        }

        .form-grid {
            grid-template-columns: 1fr;
        }

        .form-group.full-width {
            grid-column: auto;
        }

        .form-body {
            padding: 20px;
        }

        .action-area {
            flex-direction: column;
            align-items: stretch;
        }

        .btn {
            width: 100%;
        }
    }
</style>
```

</head>

<body>

```
<form id="form1" runat="server">

    <div class="top-header">
        <div class="bank-title">Manmad Bank</div>
        <div class="module-title">Secure Banking | IMPS Fund Transfer</div>
    </div>

    <div class="page-container">

        <div class="breadcrumb">
            Dashboard &nbsp;/&nbsp; Fund Transfer &nbsp;/&nbsp; IMPS
        </div>

        <div class="card">

            <div class="card-header">
                <h2>IMPS Fund Transfer</h2>
                <p>Transfer funds securely to a registered beneficiary.</p>
            </div>

            <div class="form-body">

                <div class="section-title">
                    Transfer Details
                </div>

                <div class="form-grid">

                    <div class="form-group">
                        <label class="form-label">
                            Customer ID
                        </label>

                        <asp:TextBox
                            ID="txtCustomerID"
                            runat="server"
                            CssClass="textbox"
                            ReadOnly="true">
                        </asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            Beneficiary Name <span class="required">*</span>
                        </label>

                        <asp:TextBox
                            ID="txtBeneficiary"
                            runat="server"
                            CssClass="textbox"
                            MaxLength="100">
                        </asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            Beneficiary Account Number <span class="required">*</span>
                        </label>

                        <asp:TextBox
                            ID="txtAccount"
                            runat="server"
                            CssClass="textbox"
                            MaxLength="20">
                        </asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            Confirm Account Number <span class="required">*</span>
                        </label>

                        <asp:TextBox
                            ID="txtConfirmAccount"
                            runat="server"
                            CssClass="textbox"
                            MaxLength="20">
                        </asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            IFSC Code <span class="required">*</span>
                        </label>

                        <asp:TextBox
                            ID="txtIFSC"
                            runat="server"
                            CssClass="textbox"
                            MaxLength="11">
                        </asp:TextBox>

                        <span class="help-text">
                            Enter the 11-character beneficiary bank IFSC code.
                        </span>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            Amount (INR) <span class="required">*</span>
                        </label>

                        <asp:TextBox
                            ID="txtAmount"
                            runat="server"
                            CssClass="textbox amount-box"
                            MaxLength="15">
                        </asp:TextBox>
                    </div>

                    <div class="form-group full-width">
                        <label class="form-label">
                            Remarks
                        </label>

                        <asp:TextBox
                            ID="txtRemarks"
                            runat="server"
                            CssClass="textbox"
                            MaxLength="250">
                        </asp:TextBox>
                    </div>

                </div>

                <div class="security-note">
                    <strong>Security Notice:</strong>
                    Please verify the beneficiary account number and IFSC code
                    before submitting the transfer. The transaction will be
                    created with <strong>Pending</strong> status for processing.
                </div>

                <div class="action-area">

                    <asp:Label
                        ID="lblMessage"
                        runat="server"
                        CssClass="message">
                    </asp:Label>

                    <asp:Button
                        ID="btnTransfer"
                        runat="server"
                        Text="Submit IMPS Transfer"
                        CssClass="btn"
                        OnClick="btnTransfer_Click"
                        UseSubmitBehavior="false" />

                </div>

            </div>

        </div>

        <div class="footer">
            Manmad Bank &nbsp;|&nbsp; Secure Banking System
        </div>

    </div>

</form>
```

</body>
</html>
