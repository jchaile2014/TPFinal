using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class AccesoDatos
    {
        private SqlConnection conexion;
        private SqlCommand comando;
        public SqlDataReader Lector { get; private set; }

        public AccesoDatos()
        {
            conexion = new SqlConnection("server=DESKTOP-GCAJBDA\\SQLEXPRESS; database=UnPocoDeHelado; integrated security=true");
            comando = new SqlCommand();
            comando.Connection = conexion;
        }

        public void setearConsulta(string consulta)
        {
            comando.CommandType = CommandType.Text;
            comando.CommandText = consulta;
        }

        public void setearProcedimiento(string procedimiento)
        {
            comando.CommandType = CommandType.StoredProcedure;
            comando.CommandText = procedimiento;
        }

        public void setearParametro(string nombre, object valor)
        {
            comando.Parameters.AddWithValue(nombre, valor);
        }

        public void ejecutarLectura()
        {
            conexion.Open();
            Lector = comando.ExecuteReader();
        }

        public void ejecutarAccion()
        {
            conexion.Open();
            comando.ExecuteNonQuery();
        }

        public object ejecutarAccionScalar()
        {
            conexion.Open();
            return comando.ExecuteScalar();
        }

        public void cerrarConexion()
        {
            if (Lector != null && !Lector.IsClosed)
                Lector.Close();
            if (conexion.State == ConnectionState.Open)
                conexion.Close();
        }
    }
}
