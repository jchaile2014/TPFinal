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
    public partial class ListaDeEmpleados : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarEmpleados();
            }
        }

        private void cargarEmpleados()
        {
            try
            {
                NegocioEmpleado negocio = new NegocioEmpleado();
                List<Empleado> lista = negocio.listar();
                Session["listaDeEmpleados"] = lista;
                dgvEmpleados.DataSource = lista;
                dgvEmpleados.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx");
            }
        }

        protected void dgvEmpleados_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            List<Empleado> lista = (List<Empleado>)Session["listaDeEmpleados"];
            dgvEmpleados.DataSource = lista;
            dgvEmpleados.PageIndex = e.NewPageIndex;
            dgvEmpleados.DataBind();
        }

        protected void dgvEmpleados_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvEmpleados.SelectedDataKey.Value.ToString();
            Response.Redirect("EmpleadosABM.aspx?id=" + id, false);
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("EmpleadosABM.aspx", false);
        }
    }
}