using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class NegocioProducto
    {
        public List<Producto> listar()
        {
            List<Producto> lista = new List<Producto>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("Select Id, Nombre, IdCategoria, Marca, PrecioVenta, Descripcion, Activo " +
                    "From Producto Order By Nombre");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Producto aux = new Producto();
                    aux.Id = (long)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Categoria = (int)datos.Lector["IdCategoria"];
                    aux.Marca = !(datos.Lector["Marca"] is DBNull) ? (string)datos.Lector["Marca"] : null;
                    aux.PrecioVenta = (decimal)datos.Lector["PrecioVenta"];
                    aux.Descripcion = !(datos.Lector["Descripcion"] is DBNull) ? (string)datos.Lector["Descripcion"] : null;
                    aux.Activo = (bool)datos.Lector["Activo"];

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

        public void agregar(Producto nuevo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("Insert Into Producto (Nombre, IdCategoria, Marca, PrecioVenta, Descripcion, Activo) " +
                    "Values (@nombre, @idCategoria, @marca, @precioVenta, @descripcion, 1)");
                datos.setearParametro("@nombre", nuevo.Nombre);
                datos.setearParametro("@idCategoria", nuevo.Categoria);
                datos.setearParametro("@marca", nuevo.Marca ?? (object)DBNull.Value);
                datos.setearParametro("@precioVenta", nuevo.PrecioVenta);
                datos.setearParametro("@descripcion", nuevo.Descripcion ?? (object)DBNull.Value);
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

        public void modificar(Producto producto)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("Update Producto Set Nombre = @nombre, IdCategoria = @idCategoria, " +
                    "Marca = @marca, PrecioVenta = @precioVenta, Descripcion = @descripcion, Activo = @activo " +
                    "Where Id = @id");
                datos.setearParametro("@nombre", producto.Nombre);
                datos.setearParametro("@idCategoria", producto.Categoria);
                datos.setearParametro("@marca", producto.Marca ?? (object)DBNull.Value);
                datos.setearParametro("@precioVenta", producto.PrecioVenta);
                datos.setearParametro("@descripcion", producto.Descripcion ?? (object)DBNull.Value);
                datos.setearParametro("@activo", producto.Activo);
                datos.setearParametro("@id", producto.Id);
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
                datos.setearConsulta("Update Producto Set Activo = @activo Where Id = @id");
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
    }
}
