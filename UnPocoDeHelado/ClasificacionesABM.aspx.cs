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
    public partial class ClasificacionesABM : System.Web.UI.Page
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
                if (Request.QueryString["id"] != null)
                {
                    long id = long.Parse(Request.QueryString["id"]);
                    titulo.InnerText = "Modificar Clasificación";
                    cargarClasificacion(id);
                    btnEliminar.Visible = true;
                }
                else
                {
                    titulo.InnerText = "Nueva Clasificación";
                    btnEliminar.Visible = false;
                    if (Request.QueryString["tipo"] == "categoria")
                        ddlTipo.SelectedValue = "False";
                    else
                        ddlTipo.SelectedValue = "True";
                }
            }
        }

        private void cargarClasificacion(long id)
        {
            try
            {
                NegocioClasificacion negocio = new NegocioClasificacion();
                List<Clasificacion> lista = negocio.listar();

                Clasificacion clasif = lista.Find(x => x.Id == id);
                if (clasif != null)
                {
                    txtNombre.Text = clasif.Nombre;
                    ddlTipo.SelectedValue = clasif.SeClasifica.ToString();
                    chkActivo.Checked = clasif.Activo;
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Page.Validate();
            if (!Page.IsValid)
                return;
            try
            {
                Clasificacion clasif = new Clasificacion();
                clasif.Nombre = txtNombre.Text;
                clasif.SeClasifica = bool.Parse(ddlTipo.SelectedValue);
                clasif.Activo = chkActivo.Checked;

                NegocioClasificacion negocio = new NegocioClasificacion();

                if (Request.QueryString["id"] != null)
                {
                    clasif.Id = long.Parse(Request.QueryString["id"]);
                    negocio.modificar(clasif);
                }
                else
                {
                    negocio.agregar(clasif);
                }
                Response.Redirect("Clasificaciones.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                long id = long.Parse(Request.QueryString["id"]);
                NegocioClasificacion negocio = new NegocioClasificacion();
                negocio.eliminarLogico(id, false);
                Response.Redirect("Clasificaciones.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Clasificaciones.aspx", false);
        }
    }
}