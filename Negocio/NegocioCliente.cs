using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class NegocioCliente
    {
        public List<Cliente> listar()
        {
            List<Cliente> lista = new List<Cliente>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Select Id, Nombre, Apellido, DNI, Email, Telefono From Cliente Order By Apellido, Nombre");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Cliente aux = new Cliente();
                    aux.Id = (long)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];

                    if (!(datos.Lector["DNI"] is DBNull))
                        aux.DNI = (string)datos.Lector["DNI"];

                    if (!(datos.Lector["Email"] is DBNull))
                        aux.Email = (string)datos.Lector["Email"];

                    if (!(datos.Lector["Telefono"] is DBNull))
                        aux.Telefono = (string)datos.Lector["Telefono"];
                    lista.Add(aux);
                }
                return lista;
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
        public void agregar(Cliente nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Insert Into Cliente (Nombre, Apellido, DNI, Email, Telefono) Values (@nombre, @apellido, @dni, @email, @telefono)");
                datos.setearParametro("@nombre", nuevo.Nombre);
                datos.setearParametro("@apellido", nuevo.Apellido);
                datos.setearParametro("@dni", (object)nuevo.DNI ?? DBNull.Value);
                datos.setearParametro("@email", (object)nuevo.Email ?? DBNull.Value);
                datos.setearParametro("@telefono", (object)nuevo.Telefono ?? DBNull.Value);

                datos.ejecutarAccion();
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
        public void modificar(Cliente cliente)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Update Cliente Set Nombre = @nombre, Apellido = @apellido, DNI = @dni, Email = @email, Telefono = @telefono Where Id = @id");
                datos.setearParametro("@nombre", cliente.Nombre);
                datos.setearParametro("@apellido", cliente.Apellido);
                datos.setearParametro("@dni", (object)cliente.DNI ?? DBNull.Value);
                datos.setearParametro("@email", (object)cliente.Email ?? DBNull.Value);
                datos.setearParametro("@telefono", (object)cliente.Telefono ?? DBNull.Value);
                datos.setearParametro("@id", cliente.Id);

                datos.ejecutarAccion();
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
        public void eliminar(long id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Delete From Cliente Where Id = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarAccion();
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
