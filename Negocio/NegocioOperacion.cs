using System;
using System.Collections.Generic;
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
                datos.setearConsulta("Select Id, SeOpera, NumeroFactura, Fecha, IdSucursal, IdCliente, IdEmpleado, IdMedioPago, Estado, Total From Operacion Where SeOpera = @seOpera Order By Fecha Desc");
                datos.setearParametro("@seOpera", esVenta);
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Operacion aux = new Operacion();
                    aux.Id = (long)datos.Lector["Id"];
                    aux.SeOpera = (bool)datos.Lector["SeOpera"];

                    if (!(datos.Lector["NumeroFactura"] is DBNull))
                        aux.NumeroFactura = (string)datos.Lector["NumeroFactura"];

                    aux.Fecha = (DateTime)datos.Lector["Fecha"];

                    if (!(datos.Lector["IdSucursal"] is DBNull))
                        aux.IdSucursal = Convert.ToInt32(datos.Lector["IdSucursal"]);

                    if (!(datos.Lector["IdCliente"] is DBNull))
                    {
                        aux.Cliente = new Cliente();
                        aux.Cliente.Id = (long)datos.Lector["IdCliente"];
                    }

                    aux.Empleado = new Empleado();
                    aux.Empleado.Id = (long)datos.Lector["IdEmpleado"];

                    if (!(datos.Lector["IdMedioPago"] is DBNull))
                        aux.MedioPago = Convert.ToInt32(datos.Lector["IdMedioPago"]);

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
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.iniciarTransaccion();

                datos.setearConsulta("Insert Into Operacion (SeOpera, Fecha, IdSucursal, IdEmpleado, IdMedioPago, Estado, Total) OUTPUT INSERTED.Id Values (0, @fecha, @idSucursal, @idEmpleado, @idMedioPago, @estado, @total)");
                datos.setearParametro("@fecha", compra.Fecha);
                datos.setearParametro("@idSucursal", compra.IdSucursal > 0 ? (object)compra.IdSucursal : DBNull.Value);
                datos.setearParametro("@idEmpleado", compra.Empleado.Id);
                datos.setearParametro("@idMedioPago", compra.MedioPago > 0 ? (object)compra.MedioPago : DBNull.Value);
                datos.setearParametro("@estado", compra.Estado ?? "Finalizado");
                datos.setearParametro("@total", compra.Total);
                long idOperacion = (long)datos.ejecutarAccionScalarTransaccion();

                foreach (DetalleOperacion det in compra.Detalles)
                {
                    datos.limpiarParametros();
                    datos.setearConsulta("Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, IdProveedor, Cantidad, PrecioUnitario, Subtotal) Values (@idOp, 0, @idProd, @idProv, @cant, @precio, @subtotal)");
                    datos.setearParametro("@idOp", idOperacion);
                    datos.setearParametro("@idProd", det.Producto.Id);
                    datos.setearParametro("@idProv", det.Proveedor != null && det.Proveedor.Id > 0 ? (object)det.Proveedor.Id : DBNull.Value);
                    datos.setearParametro("@cant", det.Cantidad);
                    datos.setearParametro("@precio", det.PrecioUnitario);
                    datos.setearParametro("@subtotal", det.Subtotal);
                    datos.ejecutarAccionTransaccion();
                }

                datos.confirmarTransaccion();
            }
            catch (Exception ex)
            {
                datos.revertirTransaccion();
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public long registrarVenta(Operacion venta)
        {
            foreach (DetalleOperacion det in venta.Detalles)
            {
                if (obtenerStock(det.Producto.Id) < det.Cantidad)
                    throw new Exception("Stock insuficiente para el producto: " + det.Producto.Nombre);
            }

            string numeroFactura = generarNumeroFactura(venta.IdSucursal);

            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.iniciarTransaccion();

                datos.setearConsulta("Insert Into Operacion (SeOpera, NumeroFactura, Fecha, IdSucursal, IdCliente, IdEmpleado, IdMedioPago, Estado, Total) OUTPUT INSERTED.Id Values (1, @numFactura, @fecha, @idSucursal, @idCliente, @idEmpleado, @idMedioPago, @estado, @total)");
                datos.setearParametro("@numFactura", numeroFactura);
                datos.setearParametro("@fecha", venta.Fecha);
                datos.setearParametro("@idSucursal", venta.IdSucursal > 0 ? (object)venta.IdSucursal : DBNull.Value);
                datos.setearParametro("@idCliente", venta.Cliente != null && venta.Cliente.Id > 0 ? (object)venta.Cliente.Id : DBNull.Value);
                datos.setearParametro("@idEmpleado", venta.Empleado.Id);
                datos.setearParametro("@idMedioPago", venta.MedioPago > 0 ? (object)venta.MedioPago : DBNull.Value);
                datos.setearParametro("@estado", venta.Estado ?? "Cobrada");
                datos.setearParametro("@total", venta.Total);
                long idOperacion = (long)datos.ejecutarAccionScalarTransaccion();

                foreach (DetalleOperacion det in venta.Detalles)
                {
                    datos.limpiarParametros();
                    datos.setearConsulta("Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, IdProveedor, Cantidad, PrecioUnitario, Subtotal) Values (@idOp, 1, @idProd, NULL, @cant, @precio, @subtotal)");
                    datos.setearParametro("@idOp", idOperacion);
                    datos.setearParametro("@idProd", det.Producto.Id);
                    datos.setearParametro("@cant", det.Cantidad);
                    datos.setearParametro("@precio", det.PrecioUnitario);
                    datos.setearParametro("@subtotal", det.Subtotal);
                    datos.ejecutarAccionTransaccion();
                }

                datos.confirmarTransaccion();
                return idOperacion;
            }
            catch (Exception ex)
            {
                datos.revertirTransaccion();
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        private string generarNumeroFactura(int idSucursal)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Select Count(*) From Operacion Where SeOpera = 1 And IdSucursal = @idSuc And NumeroFactura Is Not Null");
                datos.setearParametro("@idSuc", idSucursal);
                int correlativo = Convert.ToInt32(datos.ejecutarAccionScalar()) + 1;
                return "B-" + idSucursal.ToString("0000") + "-" + correlativo.ToString("00000000");
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
