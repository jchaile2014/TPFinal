using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Usuario
    {
        public long Id { get; set; }

        [DisplayName("Usuario")]
        public string Nombre { get; set; }
        public string Pass { get; set; }
        public Empleado Empleado { get; set; }
        public Perfil Perfil { get; set; }
        public bool Activo { get; set; }
       
        public override string ToString() => Nombre;
    }
}
