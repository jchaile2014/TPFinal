using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class NegocioClasificacion
    {
        public List<Clasificacion> listar()
        {
            List<Clasificacion> lista = new List<Clasificacion>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("Select Id, Nombre, SeClasifica, Activo From Clasificacion Order By Nombre");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Clasificacion aux = new Clasificacion();
                    aux.Id = (long)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.SeClasifica = (bool)datos.Lector["SeClasifica"];
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

        public List<Clasificacion> listar(bool esMarca)
        {
            List<Clasificacion> lista = new List<Clasificacion>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("Select Id, Nombre, SeClasifica, Activo From Clasificacion Where SeClasifica = @esMarca Order By Nombre");
                datos.setearParametro("@esMarca", esMarca);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Clasificacion aux = new Clasificacion();
                    aux.Id = (long)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.SeClasifica = (bool)datos.Lector["SeClasifica"];
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

        public void agregar(Clasificacion nueva)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("Insert Into Clasificacion (Nombre, SeClasifica, Activo) Values (@nombre, @seClasifica, 1)");
                datos.setearParametro("@nombre", nueva.Nombre);
                datos.setearParametro("@seClasifica", nueva.SeClasifica);
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

        public void modificar(Clasificacion clasificacion)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("Update Clasificacion Set Nombre = @nombre, SeClasifica = @seClasifica, Activo = @activo Where Id = @id");
                datos.setearParametro("@nombre", clasificacion.Nombre);
                datos.setearParametro("@seClasifica", clasificacion.SeClasifica);
                datos.setearParametro("@activo", clasificacion.Activo);
                datos.setearParametro("@id", clasificacion.Id);
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
                datos.setearConsulta("Update Clasificacion Set Activo = @activo Where Id = @id");
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
