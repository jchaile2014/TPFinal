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
                cargarTodasLasClasificaciones();
            }
        }

        protected void ddlTipo_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlTipo.SelectedValue == "")
            {
                cargarTodasLasClasificaciones();
                return;
            }

            bool esMarca = bool.Parse(ddlTipo.SelectedValue);
            cargarClasificaciones(esMarca);
        }

        private void cargarTodasLasClasificaciones()
        {
            try
            {
                NegocioClasificacion negocio = new NegocioClasificacion();
                rptClasificaciones.DataSource = negocio.listar();
                rptClasificaciones.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
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
