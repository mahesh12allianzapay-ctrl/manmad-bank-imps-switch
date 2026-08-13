<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Beneficiary.aspx.cs" Inherits="Connect.Beneficiary" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Beneficiary Management</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        body {
            background: #eef2f7;
            color: #1f2937;
        }

        .page-container {
            width: 95%;
            max-width: 1400px;
            margin: 30px auto;
        }

        .page-header {
            background: #ffffff;
            padding: 22px 28px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
            margin-bottom: 20px;
        }

        .page-header h1 {
            font-size: 26px;
            color: #1e3a8a;
            margin-bottom: 6px;
        }

        .page-header p {
            color: #6b7280;
            font-size: 14px;
        }

        .customer-box {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            padding: 12px 16px;
            border-radius: 8px;
            margin-top: 15px;
        }

        .customer-box span {
            font-weight: 600;
            color: #374151;
        }

        .card {
            background: #ffffff;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 22px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
        }

        .card-title {
            font-size: 19px;
            font-weight: 600;
            color: #1e3a8a;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid #e5e7eb;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px 22px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 7px;
            color: #374151;
        }

        .form-control {
            width: 100%;
            height: 42px;
            padding: 9px 12px;
            border: 1px solid #d1d5db;
            border-radius: 7px;
            outline: none;
            font-size: 14px;
            background: #ffffff;
        }

        .form-control:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 2px rgba(37,99,235,0.10);
        }

        .button-row {
            margin-top: 22px;
            display: flex;
            gap: 10px;
        }

        .btn {
            border: none;
            border-radius: 7px;
            padding: 11px 24px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }

        .btn-primary {
            background: #2563eb;
            color: #ffffff;
        }

        .btn-primary:hover {
            background: #1d4ed8;
        }

        .btn-secondary {
            background: #64748b;
            color: #ffffff;
        }

        .message {
            display: block;
            margin-top: 15px;
            font-size: 14px;
            font-weight: 600;
        }

        .grid-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        .beneficiary-grid {
            width: 100%;
            border-collapse: collapse;
            min-width: 1200px;
        }

        .beneficiary-grid th {
            background: #1e3a8a;
            color: #ffffff;
            padding: 12px 10px;
            text-align: left;
            font-size: 13px;
            white-space: nowrap;
        }

        .beneficiary-grid td {
            padding: 11px 10px;
            border-bottom: 1px solid #e5e7eb;
            font-size: 13px;
            color: #374151;
            white-space: nowrap;
        }

        .beneficiary-grid tr:nth-child(even) {
            background: #f8fafc;
        }

        .beneficiary-grid tr:hover {
            background: #eff6ff;
        }

        @media (max-width: 1000px) {

            .form-grid {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 650px) {

            .form-grid {
                grid-template-columns: 1fr;
            }

            .page-container {
                width: 94%;
                margin: 15px auto;
            }

            .card {
                padding: 18px;
            }

        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="page-container">

        <!-- PAGE HEADER -->

        <div class="page-header">

            <h1>Beneficiary Management</h1>

            <p>
                Add and manage beneficiary accounts
            </p>

            <div class="customer-box">

                Customer ID:

                <asp:Label
                    ID="lblCustomerID"
                    runat="server">
                </asp:Label>

            </div>

        </div>


        <!-- ADD BENEFICIARY -->

        <div class="card">

            <div class="card-title">
                Add Beneficiary
            </div>


            <div class="form-grid">

                <!-- BENEFICIARY NAME -->

                <div class="form-group">

                    <label>
                        Beneficiary Name
                    </label>

                    <asp:TextBox
                        ID="txtBeneficiaryName"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="100">
                    </asp:TextBox>

                </div>


                <!-- ACCOUNT NUMBER -->

                <div class="form-group">

                    <label>
                        Account Number
                    </label>

                    <asp:TextBox
                        ID="txtAccountNumber"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="30">
                    </asp:TextBox>

                </div>


                <!-- CONFIRM ACCOUNT NUMBER -->

                <div class="form-group">

                    <label>
                        Confirm Account Number
                    </label>

                    <asp:TextBox
                        ID="txtConfirmAccount"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="30">
                    </asp:TextBox>

                </div>


                <!-- IFSC -->

                <div class="form-group">

                    <label>
                        IFSC Code
                    </label>

                    <asp:TextBox
                        ID="txtIFSC"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="20">
                    </asp:TextBox>

                </div>


                <!-- BANK NAME -->

                <div class="form-group">

                    <label>
                        Bank Name
                    </label>

                    <asp:TextBox
                        ID="txtBankName"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="100">
                    </asp:TextBox>

                </div>


                <!-- BRANCH NAME -->

                <div class="form-group">

                    <label>
                        Branch Name
                    </label>

                    <asp:TextBox
                        ID="txtBranch"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="100">
                    </asp:TextBox>

                </div>


                <!-- NICKNAME -->

                <div class="form-group">

                    <label>
                        Nickname
                    </label>

                    <asp:TextBox
                        ID="txtNickName"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="50">
                    </asp:TextBox>

                </div>


                <!-- MOBILE -->

                <div class="form-group">

                    <label>
                        Mobile Number
                    </label>

                    <asp:TextBox
                        ID="txtMobile"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="15">
                    </asp:TextBox>

                </div>


                <!-- EMAIL -->

                <div class="form-group">

                    <label>
                        Email
                    </label>

                    <asp:TextBox
                        ID="txtEmail"
                        runat="server"
                        CssClass="form-control"
                        MaxLength="100">
                    </asp:TextBox>

                </div>

            </div>


            <!-- BUTTON -->

            <div class="button-row">

                <asp:Button
                    ID="btnAdd"
                    runat="server"
                    Text="Add Beneficiary"
                    CssClass="btn btn-primary"
                    OnClick="btnAdd_Click" />

            </div>

        </div>


        <!-- BENEFICIARY LIST -->

        <div class="card">

            <div class="card-title">
                Beneficiary List
            </div>


            <div class="grid-wrapper">

                <asp:GridView
                    ID="gvBeneficiary"
                    runat="server"
                    AutoGenerateColumns="False"
                    CssClass="beneficiary-grid"
                    EmptyDataText="No beneficiaries found."
                    GridLines="None">

                    <Columns>



                        <asp:BoundField
                            DataField="BeneficiaryID"
                            HeaderText="ID"
                            Visible="false" />



                        <asp:BoundField
                            DataField="BeneficiaryName"
                            HeaderText="Beneficiary Name" />



                        <asp:BoundField
                            DataField="AccountNumber"
                            HeaderText="Account Number" />



                        <asp:BoundField
                            DataField="IFSCCode"
                            HeaderText="IFSC Code" />



                        <asp:BoundField
                            DataField="BankName"
                            HeaderText="Bank Name" />



                        <asp:BoundField
                            DataField="BranchName"
                            HeaderText="Branch Name" />



                        <asp:BoundField
                            DataField="NickName"
                            HeaderText="Nickname" />



                        <asp:BoundField
                            DataField="MobileNumber"
                            HeaderText="Mobile Number" />



                        <asp:BoundField
                            DataField="EmailID"
                            HeaderText="Email" />



                        <asp:BoundField
                            DataField="Status"
                            HeaderText="Status" />



                        <asp:BoundField
                            DataField="CreatedDate"
                            HeaderText="Created Date"
                            DataFormatString="{0:dd-MM-yyyy HH:mm}"
                            HtmlEncode="false" />

                    </Columns>

                </asp:GridView>

            </div>



            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>

        </div>

    </div>

</form>

</body>
</html>