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
            bool logueado = Seguridad.sesionActiva(Session["usuario"]);
            bool admin = Seguridad.esAdmin(Session["usuario"]);

            liOperaciones.Visible = logueado;
            liClientes.Visible = logueado;
            liProveedores.Visible = admin;
            liProductos.Visible = admin;
            liClasificacion.Visible = admin;
            liEmpleados.Visible = admin;
            liBalances.Visible = admin;
            liSalir.Visible = logueado;
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("default.aspx");
        }
    }
}