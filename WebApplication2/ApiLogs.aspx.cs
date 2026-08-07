using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebApplication2
{
    public partial class ApiLogs : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["BankDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLogs();
            }
        }

        private void LoadLogs()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT * FROM ApiLogs ORDER BY CreatedOn DESC", con);

                DataTable dt = new DataTable();

                da.Fill(dt);

                gvLogs.DataSource = dt;

                gvLogs.DataBind();
            }
        }
    }
}