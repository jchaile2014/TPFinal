using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Compra
    {
        public long Id { get; set; }
        public Proveedor Proveedor { get; set; }
        public Sucursal Sucursal { get; set; }
        public Empleado Empleado { get; set; }
        public DateTime Fecha { get; set; }
        public decimal Total { get; set; }
        public string Estado { get; set; }
    }
}
