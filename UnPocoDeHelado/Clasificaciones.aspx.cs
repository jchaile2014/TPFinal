using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;

namespace UnPocoDeHelado
{
    public partial class Clasificaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                btnAgregar.Enabled = false;
        }

        protected void ddlTipo_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlTipo.SelectedValue == "")
            {
                btnAgregar.Enabled = false;
                dgvClasificaciones.DataSource = null;
                dgvClasificaciones.DataBind();
                return;
            }

            bool esMarca = bool.Parse(ddlTipo.SelectedValue);
            cargarClasificaciones(esMarca);

            btnAgregar.Enabled = true;
            btnAgregar.Text = esMarca ? "Nueva Marca" : "Nueva Categoría";
        }

        private void cargarClasificaciones(bool esMarca)
        {
            try
            {
                NegocioClasificacion negocio = new NegocioClasificacion();
                List<Clasificacion> lista = negocio.listar(esMarca);
                Session["listaDeClasificaciones"] = lista;
                dgvClasificaciones.DataSource = lista;
                dgvClasificaciones.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void dgvClasificaciones_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            List<Clasificacion> lista = (List<Clasificacion>)Session["listaDeClasificaciones"];
            dgvClasificaciones.DataSource = lista;
            dgvClasificaciones.PageIndex = e.NewPageIndex;
            dgvClasificaciones.DataBind();
        }

        protected void dgvClasificaciones_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvClasificaciones.SelectedDataKey.Value.ToString();
            Response.Redirect("ClasificacionesABM.aspx?id=" + id, false);
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ClasificacionesABM.aspx?esMarca=" + ddlTipo.SelectedValue, false);
        }
    }
}