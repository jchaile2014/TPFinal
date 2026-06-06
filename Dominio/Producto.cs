using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Producto
    {
        public long Id { get; set; }

        [DisplayName("Nombre")]
        public string Nombre { get; set; }

        [DisplayName("Descripción")]
        public string Descripcion { get; set; }

        public Clasificacion Marca { get; set; }      
        public Clasificacion Categoria { get; set; }  

        [DisplayName("Stock")]
        public int Cantidad { get; set; }               

        [DisplayName("Stock Mínimo")]
        public int StockMinimo { get; set; }

        [DisplayName("% Ganancia")]
        public decimal PorcentajeGanancia { get; set; }

        [DisplayName("Precio Compra")]
        public decimal PrecioCompraActual { get; set; } 

        public int IdSucursal { get; set; }
        public bool Activo { get; set; }

        [DisplayName("Precio Venta")]
        public decimal PrecioVenta => PrecioCompraActual * (1 + PorcentajeGanancia / 100m);

        public override string ToString() => Nombre;
    }
}
