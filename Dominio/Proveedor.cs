using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Proveedor
    {
        public long Id { get; set; }

        [DisplayName("Nombre")]
        public string Nombre { get; set; }
        public string CUIT { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }

        [DisplayName("Dirección")]
        public string Direccion { get; set; }
        public string Rubro { get; set; }
        public bool Activo { get; set; }

        public override string ToString() => Nombre;
    }
}
