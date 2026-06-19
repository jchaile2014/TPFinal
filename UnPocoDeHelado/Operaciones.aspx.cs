using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;

namespace UnPocoDeHelado
{
    public partial class Operaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.sesionActiva(Session["usuario"]))
            {
                Response.Redirect("default.aspx", false);
                return;
            }

            btnNuevaCompra.Visible = Seguridad.esAdmin(Session["usuario"]);

            if (!IsPostBack)
                cargarLista();
        }

        private void cargarLista()
        {
            NegocioOperacion negocio = new NegocioOperacion();
            List<Operacion> ventas = negocio.listar(true);
            List<Operacion> compras = negocio.listar(false);
            ventas.AddRange(compras);
            rptOperaciones.DataSource = ventas.OrderByDescending(o => o.Fecha).ToList();
            rptOperaciones.DataBind();
        }

        protected void btnNuevaVenta_Click(object sender, EventArgs e)
        {
            Response.Redirect("OperacionesABM.aspx?tipo=venta");
        }

        protected void btnNuevaCompra_Click(object sender, EventArgs e)
        {
            Response.Redirect("OperacionesABM.aspx?tipo=compra");
        }
    }
}
