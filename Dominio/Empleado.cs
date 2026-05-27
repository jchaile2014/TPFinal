using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{ 
public class Empleado
{
    public long Id { get; set; }

    [DisplayName("Nombre")]
    public string Nombre { get; set; }

    [DisplayName("Apellido")]
    public string Apellido { get; set; }
    public string DNI { get; set; }
    public string Email { get; set; }
    public string Telefono { get; set; }
    public Sucursal Sucursal { get; set; }
    public Rol Rol { get; set; }

    [DisplayName("Ingreso")]
    public DateTime FechaIngreso { get; set; }
    public decimal? Salario { get; set; }
    public bool Activo { get; set; }

    public override string ToString() => Nombre + " " + Apellido;
}
}
