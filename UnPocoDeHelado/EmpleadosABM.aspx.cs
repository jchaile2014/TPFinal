using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Dominio;

namespace UnPocoDeHelado
{
    public partial class EmpleadosABM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarDropdowns();

                if (Request.QueryString["id"] != null)
                {
                    long id = long.Parse(Request.QueryString["id"]);
                    titulo.InnerText = "Modificar Empleado";
                    cargarEmpleado(id);
                    btnEliminar.Visible = true;
                }
                else
                {
                    titulo.InnerText = "Nuevo Empleado";
                    btnEliminar.Visible = false;
                }
            }
        }

        private void cargarDropdowns()
        {
            try
            {
                NegocioSucursal negSucursal = new NegocioSucursal();
                List<Sucursal> listaSucursales = negSucursal.listar();
                ddlSucursal.DataSource = listaSucursales;
                ddlSucursal.DataTextField = "Nombre";
                ddlSucursal.DataValueField = "Id";
                ddlSucursal.DataBind();
                ddlRol.Items.Add(new System.Web.UI.WebControls.ListItem("Dueño", "1"));
                ddlRol.Items.Add(new System.Web.UI.WebControls.ListItem("Gerente", "2"));
                ddlRol.Items.Add(new System.Web.UI.WebControls.ListItem("Heladero", "3"));
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        private void cargarEmpleado(long id)
        {
            try
            {
                NegocioEmpleado negocio = new NegocioEmpleado();
                List<Empleado> lista = negocio.listar();

                Empleado emp = lista.Find(x => x.Id == id);
                if (emp != null)
                {
                    txtNombre.Text = emp.Nombre;
                    txtApellido.Text = emp.Apellido;
                    txtDNI.Text = emp.DNI;
                    txtEmail.Text = emp.Email ?? "";
                    txtTelefono.Text = emp.Telefono ?? "";
                    ddlSucursal.SelectedValue = emp.Sucursal.Id.ToString();
                    ddlRol.SelectedValue = emp.Rol.ToString();
                    txtFechaIngreso.Text = emp.FechaIngreso.ToString("yyyy-MM-dd");
                    txtSalario.Text = emp.Salario.HasValue ? emp.Salario.Value.ToString(System.Globalization.CultureInfo.InvariantCulture) : "";
                    chkActivo.Checked = emp.Activo;
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
            try
            {
                Empleado emp = new Empleado();
                emp.Nombre = txtNombre.Text;
                emp.Apellido = txtApellido.Text;
                emp.DNI = txtDNI.Text;
                emp.Email = txtEmail.Text;
                emp.Telefono = txtTelefono.Text;
                emp.Sucursal = new Sucursal { Id = long.Parse(ddlSucursal.SelectedValue) };
                emp.Rol = int.Parse(ddlRol.SelectedValue);
                emp.FechaIngreso = DateTime.Parse(txtFechaIngreso.Text);
                emp.Salario = string.IsNullOrEmpty(txtSalario.Text) ? null : (decimal?)decimal.Parse(txtSalario.Text, System.Globalization.CultureInfo.InvariantCulture);
                emp.Activo = chkActivo.Checked;

                NegocioEmpleado negocio = new NegocioEmpleado();

                if (Request.QueryString["id"] != null)
                {
                    emp.Id = long.Parse(Request.QueryString["id"]);
                    negocio.modificar(emp);
                }
                else
                {
                    negocio.agregar(emp);
                }
                Response.Redirect("Empleados.aspx", false);
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
                NegocioEmpleado negocio = new NegocioEmpleado();
                negocio.eliminarLogico(id, false);
                Response.Redirect("Empleados.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Empleados.aspx", false);
        }
    }
}