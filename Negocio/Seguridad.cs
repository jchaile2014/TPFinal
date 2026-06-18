using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Negocio
{
    public class Seguridad
    {
        public static bool sesionActiva(object user)
        {
            return user is Usuario u && u.Id != 0;
        }
        public static bool esAdmin(object user)
        {
            return user is Usuario u && u.Rol == 1;   
        }
        public static bool esVendedor(object user)
        {
            return user is Usuario u && u.Rol == 2;  
        }
    }
}
