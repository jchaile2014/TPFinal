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
            if (!IsPostBack)
                cargarProductos();
        }

        private void cargarProductos()
        {
            try
            {
                NegocioProducto negocio = new NegocioProducto();
                int idSucursal = int.Parse(ddlSucursal.SelectedValue);
                rptProductos.DataSource = negocio.listar().FindAll(x => x.IdSucursal == idSucursal);
                rptProductos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void ddlSucursal_SelectedIndexChanged(object sender, EventArgs e)
        {
            cargarProductos();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProductosABM.aspx?sucursal=" + ddlSucursal.SelectedValue, false);
        }
    }
}