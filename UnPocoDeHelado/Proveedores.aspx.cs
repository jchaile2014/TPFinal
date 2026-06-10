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
            {
                cargarGrilla();
            }
        }
        private void cargarGrilla()
        {
            NegocioProveedor negocio = new NegocioProveedor();
            dgvProveedores.DataSource = negocio.listar();
            dgvProveedores.DataBind();
        }
        protected void dgvProveedores_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvProveedores.PageIndex = e.NewPageIndex;
            cargarGrilla();
        }
        protected void dgvProveedores_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvProveedores.SelectedDataKey.Value.ToString();
            Response.Redirect("ProveedoresABM.aspx?id=" + id);
        }
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProveedoresABM.aspx");
        }
    }
}