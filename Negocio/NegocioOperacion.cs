using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class NegocioOperacion
    {
        public List<Operacion> listar(bool esVenta)
        {
            List<Operacion> lista = new List<Operacion>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Select IdOperacion, Tipo, NumeroFactura, Fecha, IdSucursal, Empleado, Cliente, Proveedores, MedioPago, Estado, Total From vista_operacionesDetalladas Where Tipo = @tipo Order By Fecha Desc");
                datos.setearParametro("@tipo", esVenta ? "Venta" : "Compra");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Operacion aux = new Operacion();
                    aux.Id = (long)datos.Lector["IdOperacion"];
                    aux.SeOpera = esVenta;

                    if (!(datos.Lector["NumeroFactura"] is DBNull))
                        aux.NumeroFactura = (string)datos.Lector["NumeroFactura"];

                    aux.Fecha = (DateTime)datos.Lector["Fecha"];

                    if (!(datos.Lector["IdSucursal"] is DBNull))
                        aux.IdSucursal = Convert.ToInt32(datos.Lector["IdSucursal"]);

                    aux.Cliente = new Cliente();
                    aux.Cliente.Nombre = (string)datos.Lector["Cliente"];

                    aux.Empleado = new Empleado();
                    aux.Empleado.Nombre = (string)datos.Lector["Empleado"];

                    aux.Estado = (string)datos.Lector["Estado"];
                    aux.Total = (decimal)datos.Lector["Total"];
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
        public Operacion obtenerPorId(long id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Select O.Id, O.SeOpera, O.NumeroFactura, O.Fecha, O.Total, O.Estado, O.IdCliente, C.Nombre + ' ' + C.Apellido as ClienteNombre From Operacion O Left Join Cliente C On O.IdCliente = C.Id Where O.Id = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarLectura();
                Operacion aux = new Operacion();
                if (datos.Lector.Read())
                {
                    aux.Id = (long)datos.Lector["Id"];
                    aux.SeOpera = (bool)datos.Lector["SeOpera"];
                    if (!(datos.Lector["NumeroFactura"] is DBNull)) aux.NumeroFactura = (string)datos.Lector["NumeroFactura"];
                    aux.Fecha = (DateTime)datos.Lector["Fecha"];
                    aux.Total = (decimal)datos.Lector["Total"];
                    aux.Estado = (string)datos.Lector["Estado"];
                    if (!(datos.Lector["IdCliente"] is DBNull))
                    {
                        aux.Cliente = new Cliente();
                        aux.Cliente.Id = (long)datos.Lector["IdCliente"];
                        aux.Cliente.Nombre = (string)datos.Lector["ClienteNombre"];
                    }
                }
                datos.cerrarConexion();
                datos = new AccesoDatos();
                datos.setearConsulta("Select D.Id, D.IdProducto, P.Nombre as ProductoNombre, D.IdProveedor, Pr.Nombre as ProveedorNombre, D.Cantidad, D.PrecioUnitario, D.Subtotal From DetalleOperacion D Inner Join Producto P on D.IdProducto = P.Id Left Join Proveedor Pr on D.IdProveedor = Pr.Id Where D.IdOperacion = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarLectura();
                aux.Detalles = new List<DetalleOperacion>();
                while (datos.Lector.Read())
                {
                    DetalleOperacion det = new DetalleOperacion();
                    det.Id = (long)datos.Lector["Id"];
                    det.Producto = new Producto();
                    det.Producto.Id = (long)datos.Lector["IdProducto"];
                    det.Producto.Nombre = (string)datos.Lector["ProductoNombre"];
                    if (!(datos.Lector["IdProveedor"] is DBNull))
                    {
                        det.Proveedor = new Proveedor();
                        det.Proveedor.Id = (long)datos.Lector["IdProveedor"];
                        det.Proveedor.Nombre = (string)datos.Lector["ProveedorNombre"];
                    }
                    det.Cantidad = (int)datos.Lector["Cantidad"];
                    det.PrecioUnitario = (decimal)datos.Lector["PrecioUnitario"];
                    det.Subtotal = (decimal)datos.Lector["Subtotal"];
                    aux.Detalles.Add(det);
                }
                return aux;
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
        public void agregar(Operacion nueva)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Insert Into Operacion (SeOpera, NumeroFactura, Fecha, IdSucursal, IdCliente, IdEmpleado, IdMedioPago, Estado, Total) OUTPUT INSERTED.Id Values (@seOpera, @numFactura, @fecha, @idSucursal, @idCliente, @idEmpleado, @idMedioPago, @estado, @total)");
                datos.setearParametro("@seOpera", nueva.SeOpera);
                datos.setearParametro("@numFactura", (object)nueva.NumeroFactura ?? DBNull.Value);
                datos.setearParametro("@fecha", nueva.Fecha);
                datos.setearParametro("@idSucursal", nueva.IdSucursal > 0 ? (object)nueva.IdSucursal : DBNull.Value);
                datos.setearParametro("@idCliente", nueva.Cliente != null && nueva.Cliente.Id > 0 ? (object)nueva.Cliente.Id : DBNull.Value);
                datos.setearParametro("@idEmpleado", nueva.Empleado.Id);
                datos.setearParametro("@idMedioPago", nueva.MedioPago > 0 ? (object)nueva.MedioPago : DBNull.Value);
                datos.setearParametro("@estado", nueva.Estado ?? "Pendiente");
                datos.setearParametro("@total", nueva.Total);

                long idOperacion = (long)datos.ejecutarAccionScalar();
                nueva.Id = idOperacion;
                datos.cerrarConexion();
                if (nueva.Detalles != null && nueva.Detalles.Count > 0)
                {
                    foreach (DetalleOperacion det in nueva.Detalles)
                    {
                        AccesoDatos datosDet = new AccesoDatos();
                        datosDet.setearConsulta("Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, IdProveedor, Cantidad, PrecioUnitario, Subtotal) Values (@idOp, @seOperaDet, @idProd, @idProvDet, @cant, @precio, @subtotal)");
                        datosDet.setearParametro("@idOp", nueva.Id);
                        datosDet.setearParametro("@seOperaDet", nueva.SeOpera);
                        datosDet.setearParametro("@idProd", det.Producto.Id);
                        datosDet.setearParametro("@idProvDet", det.Proveedor != null && det.Proveedor.Id > 0 ? (object)det.Proveedor.Id : DBNull.Value);
                        datosDet.setearParametro("@cant", det.Cantidad);
                        datosDet.setearParametro("@precio", det.PrecioUnitario);
                        datosDet.setearParametro("@subtotal", det.Subtotal);
                        datosDet.ejecutarAccion();
                        datosDet.cerrarConexion();
                    }
                }
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

        public void registrarCompra(Operacion compra)
        {
            long? idOperacion = null;
            foreach (DetalleOperacion det in compra.Detalles)
            {
                AccesoDatos datos = new AccesoDatos();
                try
                {
                    datos.setearProcedimiento("sp_registrarCompra");
                    datos.setearParametro("@IdProveedor", det.Proveedor.Id);
                    datos.setearParametro("@IdSucursal", compra.IdSucursal);
                    datos.setearParametro("@IdEmpleado", compra.Empleado.Id);
                    datos.setearParametro("@IdProducto", det.Producto.Id);
                    datos.setearParametro("@Cantidad", det.Cantidad);
                    datos.setearParametro("@PrecioUnitario", det.PrecioUnitario);
                    if (idOperacion == null)
                    {
                        datos.setearParametroSalida("@IdOperacion", SqlDbType.BigInt);
                        datos.ejecutarAccion();
                        idOperacion = Convert.ToInt64(datos.obtenerValorSalida("@IdOperacion"));
                    }
                    else
                    {
                        datos.setearParametro("@IdOperacion", idOperacion.Value);
                        datos.ejecutarAccion();
                    }
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

        public long registrarVenta(Operacion venta)
        {
            foreach (DetalleOperacion det in venta.Detalles)
            {
                if (obtenerStock(det.Producto.Id) < det.Cantidad)
                    throw new Exception("Stock insuficiente para el producto: " + det.Producto.Nombre);
            }

            long idOperacion;
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("sp_registrarVenta");
                datos.setearParametro("@IdSucursal", venta.IdSucursal);
                datos.setearParametro("@IdEmpleado", venta.Empleado.Id);
                datos.setearParametro("@IdCliente", venta.Cliente != null && venta.Cliente.Id > 0 ? (object)venta.Cliente.Id : 1);
                datos.setearParametroSalida("@IdOperacionSalida", SqlDbType.BigInt);
                datos.ejecutarAccion();
                idOperacion = Convert.ToInt64(datos.obtenerValorSalida("@IdOperacionSalida"));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }

            foreach (DetalleOperacion det in venta.Detalles)
            {
                AccesoDatos datosItem = new AccesoDatos();
                try
                {
                    datosItem.setearProcedimiento("sp_agregarItemVenta");
                    datosItem.setearParametro("@IdOperacion", idOperacion);
                    datosItem.setearParametro("@IdProducto", det.Producto.Id);
                    datosItem.setearParametro("@Cantidad", det.Cantidad);
                    datosItem.ejecutarAccion();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    datosItem.cerrarConexion();
                }
            }

            AccesoDatos datosCobro = new AccesoDatos();
            try
            {
                datosCobro.setearProcedimiento("sp_cobrarVenta");
                datosCobro.setearParametro("@IdOperacion", idOperacion);
                datosCobro.setearParametro("@IdMedioPago", venta.MedioPago > 0 ? (object)venta.MedioPago : 1);
                datosCobro.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datosCobro.cerrarConexion();
            }

            return idOperacion;
        }

        private int obtenerStock(long idProducto)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Select Cantidad From Producto Where Id = @id");
                datos.setearParametro("@id", idProducto);
                datos.ejecutarLectura();
                if (datos.Lector.Read())
                    return (int)datos.Lector["Cantidad"];
                return 0;
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

        public void cambiarEstado(long id, string estado)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Update Operacion Set Estado = @estado Where Id = @id");
                datos.setearParametro("@estado", estado);
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
