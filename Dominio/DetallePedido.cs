using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class DetallePedido
    {
        public long Id { get; set; }
        public long IdPedido { get; set; }
        public Producto Producto { get; set; }

        [DisplayName("Cantidad")]
        public int Cantidad { get; set; }

        [DisplayName("Precio Unit.")]
        public decimal PrecioUnitario { get; set; }

        [DisplayName("Subtotal")]
        public decimal Subtotal { get; set; }
        public string Observacion { get; set; }
    }
}
