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
            {
                cargarGrilla();
            }
        }
        private void cargarGrilla()
        {
            NegocioCliente negocio = new NegocioCliente();
            dgvClientes.DataSource = negocio.listar(); 
            dgvClientes.DataBind();                   
        }
        protected void dgvClientes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvClientes.PageIndex = e.NewPageIndex;
            cargarGrilla();
        }
        protected void dgvClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvClientes.SelectedDataKey.Value.ToString();
            Response.Redirect("ClientesABM.aspx?id=" + id);
        }
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ClientesABM.aspx");
        }
    }
}