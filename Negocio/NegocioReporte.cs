using System;
using System.Data;

namespace Negocio
{
    public class NegocioReporte
    {
        public decimal ventasPorPeriodo(int idSucursal, DateTime desde, DateTime hasta)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Select dbo.fn_ventasSucursalPeriodo(@idSuc, @desde, @hasta)");
                datos.setearParametro("@idSuc", idSucursal);
                datos.setearParametro("@desde", desde);
                datos.setearParametro("@hasta", hasta);
                object resultado = datos.ejecutarAccionScalar();
                return resultado == null || resultado is DBNull ? 0 : (decimal)resultado;
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

        public DataTable detalleVendidoPorPeriodo(int idSucursal, DateTime desde, DateTime hasta)
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta(
                    "Select P.Nombre As Producto, SUM(D.Cantidad) As Cantidad, SUM(D.Subtotal) As Total " +
                    "From DetalleOperacion D " +
                    "Inner Join Operacion O On O.Id = D.IdOperacion " +
                    "Inner Join Producto P On P.Id = D.IdProducto " +
                    "Where O.SeOpera = 1 And O.Estado = 'Cobrada' And O.IdSucursal = @idSuc " +
                    "And Cast(O.Fecha As Date) Between @desde And @hasta " +
                    "Group By P.Nombre Order By SUM(D.Cantidad) Desc");
                datos.setearParametro("@idSuc", idSucursal);
                datos.setearParametro("@desde", desde);
                datos.setearParametro("@hasta", hasta);
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
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

        public DataTable stockCritico(int idSucursal)
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta("Select Producto, Categoria, StockActual, StockMinimo, PrecioCompraActual, ProveedoresDisponibles From vista_stockCritico Where IdSucursal = @idSuc Order By StockActual");
                datos.setearParametro("@idSuc", idSucursal);
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
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

        public DataTable topProductosVendidos()
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta("Select Producto, Categoria, Marca, UnidadesVendidas, TotalFacturado From vista_topProductosVendidos");
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
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
