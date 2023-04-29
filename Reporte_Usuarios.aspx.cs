using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Examen_Christopher_Berrocal_Ugalde.Capas.Presentacion
{
    public partial class Reporte_Usuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connString = ConfigurationManager.ConnectionStrings["VeterinariaConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = "SELECT * FROM Usuarios";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        GVMascotas.DataSource = reader;
                        GVMascotas.DataBind();
                        conn.Close();
                    }
                }
            }
        }
    }
}