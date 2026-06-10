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
                datos.setearConsulta(
                    "Select P.Id, P.Nombre, P.Descripcion, P.IdMarca, M.Nombre NombreMarca, " +
                    "P.IdCategoria, C.Nombre NombreCategoria, P.Cantidad, P.StockMinimo, " +
                    "P.PorcentajeGanancia, P.PrecioCompraActual, P.IdSucursal, P.Activo " +
                    "From Producto P " +
                    "Left Join Clasificacion M On P.IdMarca = M.Id " +
                    "Left Join Clasificacion C On P.IdCategoria = C.Id " +
                    "Order By P.Nombre");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Producto aux = new Producto();
                    aux.Id = (long)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Descripcion = !(datos.Lector["Descripcion"] is DBNull) ? (string)datos.Lector["Descripcion"] : null;

                    if (!(datos.Lector["IdMarca"] is DBNull))
                    {
                        aux.Marca = new Clasificacion();
                        aux.Marca.Id = (long)datos.Lector["IdMarca"];
                        aux.Marca.Nombre = (string)datos.Lector["NombreMarca"];
                        aux.Marca.SeClasifica = true;
                    }

                    if (!(datos.Lector["IdCategoria"] is DBNull))
                    {
                        aux.Categoria = new Clasificacion();
                        aux.Categoria.Id = (long)datos.Lector["IdCategoria"];
                        aux.Categoria.Nombre = (string)datos.Lector["NombreCategoria"];
                        aux.Categoria.SeClasifica = false;
                    }

                    aux.Cantidad = (int)datos.Lector["Cantidad"];
                    aux.StockMinimo = (int)datos.Lector["StockMinimo"];
                    aux.PorcentajeGanancia = (decimal)datos.Lector["PorcentajeGanancia"];
                    aux.PrecioCompraActual = (decimal)datos.Lector["PrecioCompraActual"];
                    aux.IdSucursal = datos.Lector["IdSucursal"] is DBNull ? 0 : Convert.ToInt32(datos.Lector["IdSucursal"]);
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
                datos.setearConsulta(
                    "Insert Into Producto (Nombre, Descripcion, IdMarca, IdCategoria, Cantidad, StockMinimo, PorcentajeGanancia, PrecioCompraActual, IdSucursal, Activo) " +
                    "Values (@nombre, @descripcion, @idMarca, @idCategoria, @cantidad, @stockMinimo, @porcentajeGanancia, @precioCompraActual, @idSucursal, 1)");
                datos.setearParametro("@nombre", nuevo.Nombre);
                datos.setearParametro("@descripcion", (object)nuevo.Descripcion ?? DBNull.Value);
                datos.setearParametro("@idMarca", nuevo.Marca != null ? (object)nuevo.Marca.Id : DBNull.Value);
                datos.setearParametro("@idCategoria", nuevo.Categoria != null ? (object)nuevo.Categoria.Id : DBNull.Value);
                datos.setearParametro("@cantidad", nuevo.Cantidad);
                datos.setearParametro("@stockMinimo", nuevo.StockMinimo);
                datos.setearParametro("@porcentajeGanancia", nuevo.PorcentajeGanancia);
                datos.setearParametro("@precioCompraActual", nuevo.PrecioCompraActual);
                datos.setearParametro("@idSucursal", nuevo.IdSucursal);
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
                datos.setearConsulta(
                    "Update Producto Set Nombre = @nombre, Descripcion = @descripcion, IdMarca = @idMarca, " +
                    "IdCategoria = @idCategoria, Cantidad = @cantidad, StockMinimo = @stockMinimo, " +
                    "PorcentajeGanancia = @porcentajeGanancia, PrecioCompraActual = @precioCompraActual, " +
                    "IdSucursal = @idSucursal, Activo = @activo Where Id = @id");
                datos.setearParametro("@nombre", producto.Nombre);
                datos.setearParametro("@descripcion", (object)producto.Descripcion ?? DBNull.Value);
                datos.setearParametro("@idMarca", producto.Marca != null ? (object)producto.Marca.Id : DBNull.Value);
                datos.setearParametro("@idCategoria", producto.Categoria != null ? (object)producto.Categoria.Id : DBNull.Value);
                datos.setearParametro("@cantidad", producto.Cantidad);
                datos.setearParametro("@stockMinimo", producto.StockMinimo);
                datos.setearParametro("@porcentajeGanancia", producto.PorcentajeGanancia);
                datos.setearParametro("@precioCompraActual", producto.PrecioCompraActual);
                datos.setearParametro("@idSucursal", producto.IdSucursal);
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