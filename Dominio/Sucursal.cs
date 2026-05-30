using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Sucursal
    {
        public long Id { get; set; }

        [DisplayName("Nombre")]
        public string Nombre { get; set; }

        [DisplayName("Dirección")]
        public string Direccion { get; set; }
        public string Ciudad { get; set; }
        public string Provincia { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }

        [DisplayName("Fecha Apertura")]
        public DateTime FechaApertura { get; set; }

        [DisplayName("Activa")]
        public bool Activa { get; set; }

        public override string ToString() => Nombre;
    }
}
