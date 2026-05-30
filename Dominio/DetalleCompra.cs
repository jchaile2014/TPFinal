using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class DetalleCompra
    {
        public long Id { get; set; }
        public long IdCompra { get; set; }
        public Producto Producto { get; set; }

        [DisplayName("Cantidad")]
        public decimal Cantidad { get; set; }

        [DisplayName("Precio Unitario")]
        public decimal PrecioUnitario { get; set; }

        [DisplayName("Subtotal")]
        public decimal Subtotal { get; set; }
    }
}
