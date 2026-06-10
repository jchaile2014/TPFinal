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
    public partial class Clientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                cargarClientes();
        }

        private void cargarClientes()
        {
            try
            {
                NegocioCliente negocio = new NegocioCliente();
                List<Cliente> lista = negocio.listar();
                Session["listaDeClientes"] = lista;
                dgvClientes.DataSource = lista;
                dgvClientes.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void dgvClientes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            List<Cliente> lista = (List<Cliente>)Session["listaDeClientes"];
            dgvClientes.DataSource = lista;
            dgvClientes.PageIndex = e.NewPageIndex;
            dgvClientes.DataBind();
        }

        protected void dgvClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvClientes.SelectedDataKey.Value.ToString();
            Response.Redirect("ClientesABM.aspx?id=" + id, false);
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ClientesABM.aspx", false);
        }
    }
}