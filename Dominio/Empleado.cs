using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Empleado : Cliente
    {
        public int IdSucursal { get; set; }
        public int Rol { get; set; }

        [DisplayName("Ingreso")]
        public DateTime FechaIngreso { get; set; }
        public decimal? Salario { get; set; }
        public bool Activo { get; set; }
    }
}
