using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Stock
    {
        public Sucursal Sucursal { get; set; }
        public Producto Producto { get; set; }
        public decimal Cantidad { get; set; }
    }
}
