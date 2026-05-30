using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Usuario : Empleado
    {
        [DisplayName("Usuario")]
        public string NombreUsuario { get; set; }
        public string Pass { get; set; }
      
    }
}
