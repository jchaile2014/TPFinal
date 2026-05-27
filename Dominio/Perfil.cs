using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Perfil
    {
        public int Id { get; set; }

        [DisplayName("Nombre")]
        public string Nombre { get; set; }
        public string Descripcion { get; set; }

        public override string ToString() => Nombre;
    }
}
