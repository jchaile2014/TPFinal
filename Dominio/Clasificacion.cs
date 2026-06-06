using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Clasificacion
    {
        public long Id { get; set; }

        [DisplayName("Nombre")]
        public string Nombre { get; set; }

        [DisplayName("Se Clasifica")]
        public bool SeClasifica { get; set; }  
        public bool Activo { get; set; }

        public override string ToString() => Nombre;
    }
}
