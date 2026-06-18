using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class NegocioUsuario
    {
                public Usuario login(string nombreUsuario, string pass)
        {
            Usuario usuario = null;
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(
                    "Select U.Id, U.NombreUsuario, E.Nombre, E.Apellido, E.Email, E.IdRol, E.Activo " +
                    "From Usuario U Inner Join Empleado E On U.Id = E.Id " +
                    "Where U.NombreUsuario = @usuario And U.Pass = @pass And E.Activo = 1");
                datos.setearParametro("@usuario", nombreUsuario);
                datos.setearParametro("@pass", pass);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    usuario = new Usuario();
                    usuario.Id = (long)datos.Lector["Id"];
                    usuario.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    usuario.Nombre = (string)datos.Lector["Nombre"];
                    usuario.Apellido = (string)datos.Lector["Apellido"];
                    usuario.Email = !(datos.Lector["Email"] is DBNull) ? (string)datos.Lector["Email"] : null;
                    usuario.Rol = (int)datos.Lector["IdRol"];
                    usuario.Activo = (bool)datos.Lector["Activo"];
                }
                return usuario;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
