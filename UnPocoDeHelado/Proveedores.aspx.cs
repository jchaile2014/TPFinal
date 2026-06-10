using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace UnPocoDeHelado
{
    public partial class Proveedores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                cargarProveedores();
        }

        private void cargarProveedores()
        {
            try
            {
                NegocioProveedor negocio = new NegocioProveedor();
                List<Proveedor> lista = negocio.listar();
                Session["listaDeProveedores"] = lista;
                dgvProveedores.DataSource = lista;
                dgvProveedores.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void dgvProveedores_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            List<Proveedor> lista = (List<Proveedor>)Session["listaDeProveedores"];
            dgvProveedores.DataSource = lista;
            dgvProveedores.PageIndex = e.NewPageIndex;
            dgvProveedores.DataBind();
        }

        protected void dgvProveedores_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvProveedores.SelectedDataKey.Value.ToString();
            Response.Redirect("ProveedoresABM.aspx?id=" + id, false);
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProveedoresABM.aspx", false);
        }
    }
}