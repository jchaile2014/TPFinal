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
        public int Categoria { get; set; }
        public string Marca { get; set; }
        public decimal Cantidad {  get; set; }
   
        [DisplayName("Precio Venta")]
        public decimal PrecioVenta { get; set; }
               
        [DisplayName("Descripción")]
        public string Descripcion { get; set; }
        public bool Activo { get; set; }

        public override string ToString() => Nombre;
    }
}
