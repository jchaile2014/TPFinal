using Dominio;
using Negocio;
using System;
using System.Collections.Generic;

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
                rptClasificaciones.DataSource = null;
                rptClasificaciones.DataBind();
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
                rptClasificaciones.DataSource = negocio.listar(esMarca);
                rptClasificaciones.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ClasificacionesABM.aspx?esMarca=" + ddlTipo.SelectedValue, false);
        }
    }
}
