using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class NegocioEmpleado
    {
        public List<Empleado> listar()
        {
            List<Empleado> lista = new List<Empleado>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Select Id, Nombre, Apellido, DNI, Email, Telefono, IdSucursal, IdRol, FechaIngreso, Salario, Activo From Empleado Order By Nombre");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Empleado aux = new Empleado();
                    aux.Id = (long)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.DNI = (string)datos.Lector["DNI"];
                    aux.Email = !(datos.Lector["Email"] is DBNull) ? (string)datos.Lector["Email"] : null;
                    aux.Telefono = !(datos.Lector["Telefono"] is DBNull) ? (string)datos.Lector["Telefono"] : null;
                    aux.IdSucursal = datos.Lector["IdSucursal"] is DBNull ? 0 : Convert.ToInt32(datos.Lector["IdSucursal"]);
                    aux.Rol = (int)datos.Lector["IdRol"];
                    aux.FechaIngreso = (DateTime)datos.Lector["FechaIngreso"];
                    aux.Salario = !(datos.Lector["Salario"] is DBNull) ? (decimal?)datos.Lector["Salario"] : null;
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

        public void agregar(Empleado nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Insert Into Empleado (Nombre, Apellido, DNI, Email, Telefono, IdSucursal, IdRol, FechaIngreso, Salario, Activo) " +
                    "Values (@nombre, @apellido, @dni, @email, @telefono, @idSucursal, @idRol, @fechaIngreso, @salario, 1)");
                datos.setearParametro("@nombre", nuevo.Nombre);
                datos.setearParametro("@apellido", nuevo.Apellido);
                datos.setearParametro("@dni", nuevo.DNI);
                datos.setearParametro("@email", (object)nuevo.Email ?? DBNull.Value);
                datos.setearParametro("@telefono", (object)nuevo.Telefono ?? DBNull.Value);
                datos.setearParametro("@idSucursal", nuevo.IdSucursal);
                datos.setearParametro("@idRol", nuevo.Rol);
                datos.setearParametro("@fechaIngreso", nuevo.FechaIngreso);
                datos.setearParametro("@salario", (object)nuevo.Salario ?? DBNull.Value);
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

        public void modificar(Empleado empleado)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("Update Empleado Set Nombre = @nombre, Apellido = @apellido, DNI = @dni, " +
                    "Email = @email, Telefono = @telefono, IdSucursal = @idSucursal, IdRol = @idRol, " +
                    "FechaIngreso = @fechaIngreso, Salario = @salario, Activo = @activo Where Id = @id");
                datos.setearParametro("@nombre", empleado.Nombre);
                datos.setearParametro("@apellido", empleado.Apellido);
                datos.setearParametro("@dni", empleado.DNI);
                datos.setearParametro("@email", (object)empleado.Email ?? DBNull.Value);
                datos.setearParametro("@telefono", (object)empleado.Telefono ?? DBNull.Value);
                datos.setearParametro("@idSucursal", empleado.IdSucursal);
                datos.setearParametro("@idRol", empleado.Rol);
                datos.setearParametro("@fechaIngreso", empleado.FechaIngreso);
                datos.setearParametro("@salario", (object)empleado.Salario ?? DBNull.Value);
                datos.setearParametro("@activo", empleado.Activo);
                datos.setearParametro("@id", empleado.Id);
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
                datos.setearConsulta("Update Empleado Set Activo = @activo Where Id = @id");
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
