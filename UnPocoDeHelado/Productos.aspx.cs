using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UnPocoDeHelado
{
    public partial class Productos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.esAdmin(Session["usuario"]))
            {
                Session.Add("error", "No tenés permisos para acceder a esta sección.");
                Response.Redirect("Error.aspx", false);
                return;
            }
            if (!IsPostBack)
                cargarProductos();
        }

        private void cargarProductos()
        {
            try
            {
                Usuario u = (Usuario)Session["usuario"];
                NegocioProducto negocio = new NegocioProducto();
                rptProductos.DataSource = negocio.listar(u.IdSucursal);
                rptProductos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProductosABM.aspx", false);
        }
    }
}