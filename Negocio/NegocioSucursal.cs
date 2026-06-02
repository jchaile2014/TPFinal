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
                    "From Sucursal Where Activa = 1 Order By Nombre");
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
    }
}
