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
    public partial class ListaDeSucursales : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarSucursales();
            }
        }

        private void cargarSucursales()
        {
            try
            {
                NegocioSucursal negocio = new NegocioSucursal();
                List<Sucursal> lista = negocio.listar();
                Session["listaDeSucursales"] = lista;
                dgvSucursales.DataSource = lista;
                dgvSucursales.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx");
            }
        }

        protected void dgvSucursales_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            List<Sucursal> lista = (List<Sucursal>)Session["listaDeSucursales"];
            dgvSucursales.DataSource = lista;
            dgvSucursales.PageIndex = e.NewPageIndex;
            dgvSucursales.DataBind();
        }

        protected void dgvSucursales_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvSucursales.SelectedDataKey.Value.ToString();
            Response.Redirect("SucursalesABM.aspx?id=" + id, false);
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("SucursalesABM.aspx", false);
        }
    }
}