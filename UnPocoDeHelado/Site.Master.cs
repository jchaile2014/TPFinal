using Negocio;
using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UnPocoDeHelado
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool admin = Seguridad.esAdmin(Session["usuario"]);

            liProveedores.Visible = admin;
            liProductos.Visible = admin;
            liClasificacion.Visible = admin;
            liEmpleados.Visible = admin;
        }
    }
}