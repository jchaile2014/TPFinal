using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Mesa
    {
        public long Id { get; set; }
        public Sucursal Sucursal { get; set; }

        [DisplayName("Número")]
        public int Numero { get; set; }

        [DisplayName("Capacidad")]
        public int Capacidad { get; set; }

        [DisplayName("Estado")]
        public string Estado { get; set; } = "Libre";
        public bool Activa { get; set; }

        public override string ToString() => "Mesa " + Numero;
    }
}
