using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Operacion
    {
        public long Id { get; set; }

        [DisplayName("Se Opera")]
        public bool SeOpera { get; set; }  

        [DisplayName("Factura")]
        public string NumeroFactura { get; set; }   
        public DateTime Fecha { get; set; }
        public int IdSucursal { get; set; }

        public Cliente Cliente { get; set; }       
        public Proveedor Proveedor { get; set; }   
        public Empleado Empleado { get; set; }    

        [DisplayName("Medio De Pago")]
        public int MedioPago { get; set; }
        public string Estado { get; set; }
        public decimal Total { get; set; }

        public List<DetalleOperacion> Detalles { get; set; }
    }
}
