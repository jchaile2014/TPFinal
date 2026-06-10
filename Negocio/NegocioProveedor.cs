using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class NegocioProveedor
    {
        public List<Proveedor> listar()
        {
            List<Proveedor> lista = new List<Proveedor>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Select Id, Nombre, CUIT, Telefono, Email, Direccion, Rubro, Activo From Proveedor Order By Nombre");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Proveedor aux = new Proveedor();
                    aux.Id = (long)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.CUIT = (string)datos.Lector["CUIT"];
                    aux.Activo = (bool)datos.Lector["Activo"];
                    if (!(datos.Lector["Telefono"] is DBNull))
                        aux.Telefono = (string)datos.Lector["Telefono"];

                    if (!(datos.Lector["Email"] is DBNull))
                        aux.Email = (string)datos.Lector["Email"];

                    if (!(datos.Lector["Direccion"] is DBNull))
                        aux.Direccion = (string)datos.Lector["Direccion"];

                    if (!(datos.Lector["Rubro"] is DBNull))
                        aux.Rubro = (string)datos.Lector["Rubro"];
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
        public void agregar(Proveedor nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Insert Into Proveedor (Nombre, CUIT, Telefono, Email, Direccion, Rubro, Activo) Values (@nombre, @cuit, @telefono, @email, @direccion, @rubro, 1)");
                datos.setearParametro("@nombre", nuevo.Nombre);
                datos.setearParametro("@cuit", nuevo.CUIT);
                datos.setearParametro("@telefono", (object)nuevo.Telefono ?? DBNull.Value);
                datos.setearParametro("@email", (object)nuevo.Email ?? DBNull.Value);
                datos.setearParametro("@direccion", (object)nuevo.Direccion ?? DBNull.Value);
                datos.setearParametro("@rubro", (object)nuevo.Rubro ?? DBNull.Value);

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
        public void modificar(Proveedor proveedor)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Update Proveedor Set Nombre = @nombre, CUIT = @cuit, Telefono = @telefono, Email = @email, Direccion = @direccion, Rubro = @rubro, Activo = @activo Where Id = @id");
                datos.setearParametro("@nombre", proveedor.Nombre);
                datos.setearParametro("@cuit", proveedor.CUIT);
                datos.setearParametro("@telefono", (object)proveedor.Telefono ?? DBNull.Value);
                datos.setearParametro("@email", (object)proveedor.Email ?? DBNull.Value);
                datos.setearParametro("@direccion", (object)proveedor.Direccion ?? DBNull.Value);
                datos.setearParametro("@rubro", (object)proveedor.Rubro ?? DBNull.Value);
                datos.setearParametro("@activo", proveedor.Activo);
                datos.setearParametro("@id", proveedor.Id);

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
        public void eliminarLogico(long id, bool activo = false)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Update Proveedor Set Activo = @activo Where Id = @id");
                datos.setearParametro("@activo", activo);
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

        public void eliminar(long id)
        {
            throw new NotImplementedException();
        }
    }
}
