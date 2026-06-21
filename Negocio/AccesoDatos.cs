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
        private SqlTransaction transaccion;
        public SqlDataReader Lector { get; private set; }

        public AccesoDatos()
        {
            conexion = new SqlConnection("Server=localhost\\SQLEXPRESS; Database=UnPocoDeHelado; Integrated Security=True;");
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

        public void setearParametroSalida(string nombre, SqlDbType tipo)
        {
            SqlParameter parametro = new SqlParameter(nombre, tipo);
            parametro.Direction = ParameterDirection.Output;
            comando.Parameters.Add(parametro);
        }

        public object obtenerValorSalida(string nombre)
        {
            return comando.Parameters[nombre].Value;
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

        public void limpiarParametros()
        {
            comando.Parameters.Clear();
        }

        public void iniciarTransaccion()
        {
            conexion.Open();
            transaccion = conexion.BeginTransaction();
            comando.Transaction = transaccion;
        }

        public void ejecutarAccionTransaccion()
        {
            comando.ExecuteNonQuery();
        }

        public object ejecutarAccionScalarTransaccion()
        {
            return comando.ExecuteScalar();
        }

        public void confirmarTransaccion()
        {
            transaccion.Commit();
        }

        public void revertirTransaccion()
        {
            if (transaccion != null)
                transaccion.Rollback();
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
