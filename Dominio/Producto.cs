using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Producto
    {
        public long Id { get; set; }
        [DisplayName("Nombre")]
        public string Nombre { get; set; }
        public Categoria Categoria { get; set; }
        [DisplayName("Tipo")]
        public TipoProducto TipoProducto { get; set; }
        public Marca Marca { get; set; }
        [DisplayName("Precio Venta")]
        public decimal PrecioVenta { get; set; }
        [DisplayName("% Ganancia")]
        public decimal PorcentajeGanancia { get; set; }
        [DisplayName("Stock Mínimo")]
        public decimal StockMinimo { get; set; }
        [DisplayName("Descripción")]
        public string Descripcion { get; set; }
        public bool Activo { get; set; }

        public override string ToString() => Nombre;
    }
}
