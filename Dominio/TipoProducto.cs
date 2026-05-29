using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class TipoProducto
    {
        public int Id { get; set; }
        [DisplayName("Nombre")]
        public string Nombre { get; set; }
        public Categoria Categoria { get; set; }
        public bool Activo { get; set; }

        public override string ToString() => Nombre;
    }

}
