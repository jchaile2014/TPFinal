using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Stock
    {
        public Sucursal Sucursal { get; set; }
        public Producto Producto { get; set; }
        [DisplayName("Cantidad")]
        public decimal Cantidad { get; set; }
        [DisplayName("Stock Mínimo")]
        public decimal StockMinimo { get; set; }
        [DisplayName("Actualización")]
        public DateTime FechaActualizacion { get; set; }
    }

}
