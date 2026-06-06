using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class DetalleOperacion
    {
        public long Id { get; set; }
        public long IdOperacion { get; set; }

        [DisplayName("Se Opera")]
        public bool SeOpera { get; set; }   

        public Producto Producto { get; set; }

        [DisplayName("Cantidad")]
        public int Cantidad { get; set; }

        [DisplayName("Precio Unit.")]
        public decimal PrecioUnitario { get; set; }

        [DisplayName("Subtotal")]
        public decimal Subtotal { get; set; }
    }
}
