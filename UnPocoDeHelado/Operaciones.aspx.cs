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

            if (!Seguridad.esAdmin(Session["usuario"]))
            {
                pillTodas.Visible = false;
                pillCompras.Visible = false;
                pillVentas.Attributes["class"] = "filter-pill active";
            }

            if (!IsPostBack)
                cargarLista();
        }

        private void cargarLista()
        {
            NegocioOperacion negocio = new NegocioOperacion();
            List<Operacion> lista;
            if (Seguridad.esAdmin(Session["usuario"]))
            {
                lista = negocio.listar(true);
                lista.AddRange(negocio.listar(false));
            }
            else
            {
                Usuario u = (Usuario)Session["usuario"];
                lista = negocio.listar(true, u.Id);
            }
            rptOperaciones.DataSource = lista.OrderByDescending(o => o.Fecha).ToList();
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
