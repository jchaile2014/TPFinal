using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class ProductoProveedor
    {
        public Producto Producto { get; set; }
        public Proveedor Proveedor { get; set; }
        [DisplayName("Última Compra")]
        public DateTime? UltimaFechaCompra { get; set; }
        [DisplayName("Último Precio")]
        public decimal? UltimoPrecioCompra { get; set; }
    }
}
