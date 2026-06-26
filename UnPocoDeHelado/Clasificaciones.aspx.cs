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
            if (!Seguridad.sesionActiva(Session["usuario"]))
            {
                Response.Redirect("default.aspx", false);
                return;
            }
            if (!Seguridad.esAdmin(Session["usuario"]))
            {
                Session.Add("error", "No tenés permisos para acceder a esta sección.");
                Response.Redirect("Error.aspx", false);
                return;
            }
           
            if (!IsPostBack)
            {
                ddlTipo.SelectedValue = "True";
                cargarClasificaciones(true);
                actualizarBotones(true);
            }
        }

        protected void ddlTipo_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool esMarca = bool.Parse(ddlTipo.SelectedValue);
            cargarClasificaciones(esMarca);
            actualizarBotones(esMarca);
        }

        private void actualizarBotones(bool esMarca)
        {
            btnNuevaMarca.Visible = esMarca;
            btnNuevaCategoria.Visible = !esMarca;
        }

        protected void btnNuevaMarca_Click(object sender, EventArgs e)
        {
            Response.Redirect("ClasificacionesABM.aspx?tipo=marca", false);
        }

        protected void btnNuevaCategoria_Click(object sender, EventArgs e)
        {
            Response.Redirect("ClasificacionesABM.aspx?tipo=categoria", false);
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
    }
}
