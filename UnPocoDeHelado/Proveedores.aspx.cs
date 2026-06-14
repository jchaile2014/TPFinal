using Dominio;
using Negocio;
using System;
using System.Collections.Generic;

namespace UnPocoDeHelado
{
    public partial class Proveedores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                cargarProveedores();
        }

        private void cargarProveedores()
        {
            try
            {
                NegocioProveedor negocio = new NegocioProveedor();
                rptProveedores.DataSource = negocio.listar();
                rptProveedores.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProveedoresABM.aspx", false);
        }
    }
}
