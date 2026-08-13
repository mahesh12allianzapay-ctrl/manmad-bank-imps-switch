using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace Connect
{
    public partial class Beneficiary : Page
    {
        private readonly string cs =
            ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;


        // =========================================================
        // PAGE LOAD
        // =========================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check whether user is logged in
            if (Session["CustomerID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Display Customer ID
            lblCustomerID.Text = Session["CustomerID"].ToString();

            // Load beneficiaries only on first page load
            if (!IsPostBack)
            {
                LoadBeneficiaries();
            }
        }


        // =========================================================
        // ADD BENEFICIARY
        // =========================================================
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                lblMessage.Text = "";

                // -------------------------------------------------
                // GET CUSTOMER ID FROM SESSION
                // -------------------------------------------------
                if (Session["CustomerID"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                string customerId = Session["CustomerID"].ToString();

                // -------------------------------------------------
                // READ FORM VALUES
                // -------------------------------------------------
                string beneficiaryName = txtBeneficiaryName.Text.Trim();

                string accountNumber = txtAccountNumber.Text.Trim();

                string confirmAccount =
                    txtConfirmAccount.Text.Trim();

                string ifsc =
                    txtIFSC.Text.Trim().ToUpper();

                string bankName =
                    txtBankName.Text.Trim();

                string branchName =
                    txtBranch.Text.Trim();

                string nickName =
                    txtNickName.Text.Trim();

                string mobileNumber =
                    txtMobile.Text.Trim();

                string emailID =
                    txtEmail.Text.Trim();


                // =================================================
                // REQUIRED FIELD VALIDATION
                // =================================================

                if (string.IsNullOrWhiteSpace(beneficiaryName))
                {
                    ShowMessage(
                        "Please enter beneficiary name.",
                        false);

                    return;
                }


                if (string.IsNullOrWhiteSpace(accountNumber))
                {
                    ShowMessage(
                        "Please enter account number.",
                        false);

                    return;
                }


                if (string.IsNullOrWhiteSpace(confirmAccount))
                {
                    ShowMessage(
                        "Please confirm account number.",
                        false);

                    return;
                }


                // =================================================
                // ACCOUNT NUMBER MATCH
                // =================================================

                if (accountNumber != confirmAccount)
                {
                    ShowMessage(
                        "Account number and confirm account number do not match.",
                        false);

                    return;
                }


                if (string.IsNullOrWhiteSpace(ifsc))
                {
                    ShowMessage(
                        "Please enter IFSC code.",
                        false);

                    return;
                }


                if (string.IsNullOrWhiteSpace(bankName))
                {
                    ShowMessage(
                        "Please enter bank name.",
                        false);

                    return;
                }


                if (string.IsNullOrWhiteSpace(branchName))
                {
                    ShowMessage(
                        "Please enter branch name.",
                        false);

                    return;
                }


                // =================================================
                // ACCOUNT NUMBER VALIDATION
                // =================================================

                if (!Regex.IsMatch(
                    accountNumber,
                    @"^[0-9]{6,30}$"))
                {
                    ShowMessage(
                        "Account number must contain only digits and be between 6 and 30 digits.",
                        false);

                    return;
                }


                // =================================================
                // IFSC VALIDATION
                // Example: SBIN0001234
                // =================================================

                if (!Regex.IsMatch(
                    ifsc,
                    @"^[A-Z]{4}0[A-Z0-9]{6}$"))
                {
                    ShowMessage(
                        "Please enter a valid IFSC code.",
                        false);

                    return;
                }


                // =================================================
                // MOBILE VALIDATION - OPTIONAL
                // =================================================

                if (!string.IsNullOrWhiteSpace(mobileNumber))
                {
                    if (!Regex.IsMatch(
                        mobileNumber,
                        @"^[0-9]{10,15}$"))
                    {
                        ShowMessage(
                            "Please enter a valid mobile number.",
                            false);

                        return;
                    }
                }


                // =================================================
                // EMAIL VALIDATION - OPTIONAL
                // =================================================

                if (!string.IsNullOrWhiteSpace(emailID))
                {
                    if (!Regex.IsMatch(
                        emailID,
                        @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
                    {
                        ShowMessage(
                            "Please enter a valid email address.",
                            false);

                        return;
                    }
                }


                // =================================================
                // DATABASE CONNECTION
                // =================================================

                using (SqlConnection con =
                    new SqlConnection(cs))
                {
                    con.Open();


                    // =================================================
                    // CHECK DUPLICATE BENEFICIARY
                    // =================================================

                    string duplicateQuery = @"
                        SELECT COUNT(*)
                        FROM Beneficiaries
                        WHERE CustomerID = @CustomerID
                        AND AccountNumber = @AccountNumber";


                    using (SqlCommand duplicateCmd =
                        new SqlCommand(
                            duplicateQuery,
                            con))
                    {
                        duplicateCmd.Parameters.Add(
                            "@CustomerID",
                            SqlDbType.VarChar,
                            50).Value = customerId;


                        duplicateCmd.Parameters.Add(
                            "@AccountNumber",
                            SqlDbType.VarChar,
                            30).Value = accountNumber;


                        int count =
                            Convert.ToInt32(
                                duplicateCmd.ExecuteScalar());


                        if (count > 0)
                        {
                            ShowMessage(
                                "This beneficiary account is already added.",
                                false);

                            return;
                        }
                    }


                    // =================================================
                    // INSERT BENEFICIARY
                    // =================================================
                    //
                    // IMPORTANT:
                    // These names exactly match your database:
                    //
                    // CustomerID
                    // BeneficiaryName
                    // AccountNumber
                    // IFSCCode
                    // BankName
                    // BranchName
                    // NickName
                    // MobileNumber
                    // EmailID
                    // Status
                    // CreatedDate
                    //
                    // BeneficiaryID is not included because it
                    // should normally be an IDENTITY column.
                    // =================================================

                    string insertQuery = @"
                        INSERT INTO Beneficiaries
                        (
                            CustomerID,
                            BeneficiaryName,
                            AccountNumber,
                            IFSCCode,
                            BankName,
                            BranchName,
                            NickName,
                            MobileNumber,
                            EmailID,
                            Status,
                            CreatedDate
                        )
                        VALUES
                        (
                            @CustomerID,
                            @BeneficiaryName,
                            @AccountNumber,
                            @IFSCCode,
                            @BankName,
                            @BranchName,
                            @NickName,
                            @MobileNumber,
                            @EmailID,
                            @Status,
                            GETDATE()
                        )";


                    using (SqlCommand cmd =
                        new SqlCommand(
                            insertQuery,
                            con))
                    {
                        // Customer ID
                        cmd.Parameters.Add(
                            "@CustomerID",
                            SqlDbType.VarChar,
                            50).Value = customerId;


                        // Beneficiary Name
                        cmd.Parameters.Add(
                            "@BeneficiaryName",
                            SqlDbType.VarChar,
                            100).Value = beneficiaryName;


                        // Account Number
                        cmd.Parameters.Add(
                            "@AccountNumber",
                            SqlDbType.VarChar,
                            30).Value = accountNumber;


                        // IFSC Code
                        cmd.Parameters.Add(
                            "@IFSCCode",
                            SqlDbType.VarChar,
                            20).Value = ifsc;


                        // Bank Name
                        cmd.Parameters.Add(
                            "@BankName",
                            SqlDbType.VarChar,
                            100).Value = bankName;


                        // Branch Name
                        cmd.Parameters.Add(
                            "@BranchName",
                            SqlDbType.VarChar,
                            100).Value = branchName;


                        // Nickname - optional
                        cmd.Parameters.Add(
                            "@NickName",
                            SqlDbType.VarChar,
                            50).Value =
                                string.IsNullOrWhiteSpace(nickName)
                                ? (object)DBNull.Value
                                : nickName;


                        // Mobile Number - optional
                        cmd.Parameters.Add(
                            "@MobileNumber",
                            SqlDbType.VarChar,
                            15).Value =
                                string.IsNullOrWhiteSpace(mobileNumber)
                                ? (object)DBNull.Value
                                : mobileNumber;


                        // Email ID - optional
                        cmd.Parameters.Add(
                            "@EmailID",
                            SqlDbType.VarChar,
                            100).Value =
                                string.IsNullOrWhiteSpace(emailID)
                                ? (object)DBNull.Value
                                : emailID;


                        // Status - required by database
                        cmd.Parameters.Add(
                            "@Status",
                            SqlDbType.VarChar,
                            50).Value = "Active";


                        // Execute INSERT
                        int result =
                            cmd.ExecuteNonQuery();


                        if (result > 0)
                        {
                            ShowMessage(
                                "Beneficiary added successfully.",
                                true);


                            ClearFields();


                            // Reload GridView
                            LoadBeneficiaries();
                        }
                        else
                        {
                            ShowMessage(
                                "Beneficiary could not be added.",
                                false);
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                ShowMessage(
                    "Database error: " + ex.Message,
                    false);
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Error: " + ex.Message,
                    false);
            }
        }


        // =========================================================
        // LOAD BENEFICIARIES
        // =========================================================
        private void LoadBeneficiaries()
        {
            try
            {
                if (Session["CustomerID"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }


                string customerId =
                    Session["CustomerID"].ToString();


                // IMPORTANT:
                // These DataField names match the updated
                // Beneficiary.aspx GridView.
                string query = @"
                    SELECT
                        BeneficiaryID,
                        BeneficiaryName,
                        AccountNumber,
                        IFSCCode,
                        BankName,
                        BranchName,
                        NickName,
                        MobileNumber,
                        EmailID,
                        Status,
                        CreatedDate
                    FROM Beneficiaries
                    WHERE CustomerID = @CustomerID
                    ORDER BY BeneficiaryID DESC";


                using (SqlConnection con =
                    new SqlConnection(cs))
                {
                    using (SqlCommand cmd =
                        new SqlCommand(
                            query,
                            con))
                    {
                        cmd.Parameters.Add(
                            "@CustomerID",
                            SqlDbType.VarChar,
                            50).Value = customerId;


                        using (SqlDataAdapter da =
                            new SqlDataAdapter(cmd))
                        {
                            DataTable dt =
                                new DataTable();


                            da.Fill(dt);


                            gvBeneficiary.DataSource =
                                dt;

                            gvBeneficiary.DataBind();
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                ShowMessage(
                    "Unable to load beneficiaries: " +
                    ex.Message,
                    false);
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Error loading beneficiaries: " +
                    ex.Message,
                    false);
            }
        }


        // =========================================================
        // CLEAR FORM
        // =========================================================
        private void ClearFields()
        {
            txtBeneficiaryName.Text = "";

            txtAccountNumber.Text = "";

            txtConfirmAccount.Text = "";

            txtIFSC.Text = "";

            txtBankName.Text = "";

            txtBranch.Text = "";

            txtNickName.Text = "";

            txtMobile.Text = "";

            txtEmail.Text = "";
        }


        // =========================================================
        // SHOW MESSAGE
        // =========================================================
        private void ShowMessage(
            string message,
            bool success)
        {
            lblMessage.Text = message;


            if (success)
            {
                lblMessage.ForeColor =
                    System.Drawing.Color.Green;
            }
            else
            {
                lblMessage.ForeColor =
                    System.Drawing.Color.Red;
            }
        }
    }
}