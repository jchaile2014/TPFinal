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
    public partial class Empleados : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.esAdmin(Session["usuario"]))
            {
                Session.Add("error", "No tenés permisos para acceder a esta sección.");
                Response.Redirect("Error.aspx", false);
                return;
            }
            if (!IsPostBack)
            {
                cargarLista();
            }
        }

        private void cargarLista()
        {
            NegocioEmpleado negocio = new NegocioEmpleado();
            int idSucursal = int.Parse(ddlSucursal.SelectedValue);
            repEmpleados.DataSource = negocio.listar().FindAll(x => x.IdSucursal == idSucursal);
            repEmpleados.DataBind();
        }

        protected void repEmpleados_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                string id = e.CommandArgument.ToString();
                Response.Redirect("EmpleadosABM.aspx?id=" + id);
            }
        }

        protected void ddlSucursal_SelectedIndexChanged(object sender, EventArgs e)
        {
            cargarLista();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("EmpleadosABM.aspx");
        }
    }
}