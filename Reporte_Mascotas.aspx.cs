using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Examen_Christopher_Berrocal_Ugalde.Capas.Presentacion
{
    public partial class Usuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string constr = ConfigurationManager.ConnectionStrings["VeterinariaConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT Mae_Mascotas.Nombre_Mascota, Control_Citas.Proxima_fecha, Control_Citas.Medico_Asignado FROM Control_Citas INNER JOIN Mae_Mascotas ON Control_Citas.ID_Mascota = Mae_Mascotas.ID_Mascota WHERE Proxima_fecha >= GETDATE() ORDER BY Proxima_fecha ASC"))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            cmd.Connection = con;
                            sda.SelectCommand = cmd;
                            using (DataTable dt = new DataTable())
                            {
                                sda.Fill(dt);
                               GVMascotas.DataSource = dt;
                               GVMascotas.DataBind();
                            }
                        }
                    }
                }
            }
        }
    }
}