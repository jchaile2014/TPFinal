using Dominio;
using Negocio;
using System;
using System.Collections.Generic;

namespace UnPocoDeHelado
{
    public partial class Clientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.sesionActiva(Session["usuario"]))
            {
                Response.Redirect("default.aspx", false);
                return;
            }
            if (!IsPostBack)
                cargarClientes();
        }

        private void cargarClientes()
        {
            try
            {
                NegocioCliente negocio = new NegocioCliente();
                rptClientes.DataSource = negocio.listar();
                rptClientes.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ClientesABM.aspx", false);
        }
    }
}
