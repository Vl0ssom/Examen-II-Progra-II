using Examen_Christopher_Berrocal_Ugalde.Capas;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace Examen_Christopher_Berrocal_Ugalde
{
    public class Login
    {
        public static string login_Usuario { get; set; }
        public static string Contraseña { get; set; }

        public static int ValidarUsuario(string Login_Usuario, string Contraseña)
        {

            int retorno = 0;

            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Conexión.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("SesionLogin", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@Usuario", Login_Usuario));
                    cmd.Parameters.Add(new SqlParameter("@Password", Contraseña));



                   
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            retorno = 1;
                            login_Usuario = Login_Usuario;
                        }

                    }

                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                retorno = -1;
            }
            finally
            {
                Conn.Close();
                Conn.Dispose();
            }

            return retorno;

        }

        internal static int ValidarUsuario(object text1, object text2)
        {
            throw new NotImplementedException();
        }
    }
}