using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class NegocioSucursal
    {
        public List<Sucursal> listar()
        {
            List<Sucursal> lista = new List<Sucursal>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("Select Id, Nombre, Direccion, Ciudad, Provincia, Telefono, Email, FechaApertura, Activa " +
                    "From Sucursal Order By Nombre");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Sucursal aux = new Sucursal();
                    aux.Id = (long)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Direccion = (string)datos.Lector["Direccion"];
                    aux.Ciudad = (string)datos.Lector["Ciudad"];
                    aux.Provincia = (string)datos.Lector["Provincia"];
                    aux.Telefono = !(datos.Lector["Telefono"] is DBNull) ? (string)datos.Lector["Telefono"] : null;
                    aux.Email = !(datos.Lector["Email"] is DBNull) ? (string)datos.Lector["Email"] : null;
                    aux.FechaApertura = (DateTime)datos.Lector["FechaApertura"];
                    aux.Activa = (bool)datos.Lector["Activa"];

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

        public void agregar(Sucursal nueva)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("Insert Into Sucursal (Nombre, Direccion, Ciudad, Provincia, Telefono, Email, FechaApertura, Activa) " +
                    "Values (@nombre, @direccion, @ciudad, @provincia, @telefono, @email, @fechaApertura, 1)");
                datos.setearParametro("@nombre", nueva.Nombre);
                datos.setearParametro("@direccion", nueva.Direccion);
                datos.setearParametro("@ciudad", nueva.Ciudad);
                datos.setearParametro("@provincia", nueva.Provincia);
                datos.setearParametro("@telefono", nueva.Telefono ?? (object)DBNull.Value);
                datos.setearParametro("@email", nueva.Email ?? (object)DBNull.Value);
                datos.setearParametro("@fechaApertura", nueva.FechaApertura);
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

        public void modificar(Sucursal sucursal)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("Update Sucursal Set Nombre = @nombre, Direccion = @direccion, Ciudad = @ciudad, " +
                    "Provincia = @provincia, Telefono = @telefono, Email = @email, FechaApertura = @fechaApertura, " +
                    "Activa = @activa Where Id = @id");
                datos.setearParametro("@nombre", sucursal.Nombre);
                datos.setearParametro("@direccion", sucursal.Direccion);
                datos.setearParametro("@ciudad", sucursal.Ciudad);
                datos.setearParametro("@provincia", sucursal.Provincia);
                datos.setearParametro("@telefono", sucursal.Telefono ?? (object)DBNull.Value);
                datos.setearParametro("@email", sucursal.Email ?? (object)DBNull.Value);
                datos.setearParametro("@fechaApertura", sucursal.FechaApertura);
                datos.setearParametro("@activa", sucursal.Activa);
                datos.setearParametro("@id", sucursal.Id);
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

        public void eliminarLogico(long id, bool activa = false)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("Update Sucursal Set Activa = @activa Where Id = @id");
                datos.setearParametro("@activa", activa);
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