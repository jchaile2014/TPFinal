using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Pedido
    {
        public long Id { get; set; }
        public Mesa Mesa { get; set; }
        public Empleado Empleado { get; set; }
        public DateTime Fecha { get; set; }
        public string Estado { get; set; }
        public Venta Venta { get; set; }
    }
}
