using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Venta
    {
        public long Id { get; set; }

        [DisplayName("Factura")]
        public string NumeroFactura { get; set; }
        public Sucursal Sucursal { get; set; }

        [DisplayName("Vendedor")]
        public Empleado EmpleadoVende { get; set; }

        [DisplayName("Cobrador")]
        public Empleado EmpleadoCobra { get; set; }
        public Cliente Cliente { get; set; }
        public DateTime Fecha { get; set; }

        [DisplayName("Medio De Pago")]
        public int MedioPago { get; set; }
        public string Estado { get; set; }
        public decimal Total { get; set; }
    }
}
