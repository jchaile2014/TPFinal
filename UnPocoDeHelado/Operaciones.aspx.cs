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
    public partial class Operaciones : System.Web.UI.Page
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
            NegocioOperacion negocio = new NegocioOperacion();

            List<Operacion> ventas = negocio.listar(true);
            List<Operacion> compras = negocio.listar(false);

            ventas.AddRange(compras);

            dgvOperaciones.DataSource = ventas.OrderByDescending(o => o.Fecha).ToList();
            dgvOperaciones.DataBind();
        }
        protected void dgvOperaciones_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvOperaciones.PageIndex = e.NewPageIndex;
            cargarGrilla();
        }
        protected void dgvOperaciones_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvOperaciones.SelectedDataKey.Value.ToString();
            Response.Redirect("OperacionesABM.aspx?id=" + id);
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