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
                ddlSucursal.Items.Add(new ListItem("Sucursal Centro (1)", "1"));
                ddlSucursal.Items.Add(new ListItem("Sucursal Norte (2)", "2"));

                ddlRol.Items.Add(new ListItem("Vendedor", "1"));
                ddlRol.Items.Add(new ListItem("Gerente", "2"));
                ddlRol.Items.Add(new ListItem("Administrador", "3"));

                string id = Request.QueryString["id"];
                if (id != null)
                {
                    titulo.InnerText = "Editar Empleado";
                    btnEliminar.Visible = true;

                    NegocioEmpleado negocio = new NegocioEmpleado();
                    Empleado emp = negocio.listar().Find(x => x.Id == long.Parse(id));

                    if (emp != null)
                    {
                        txtNombre.Text = emp.Nombre;
                        txtApellido.Text = emp.Apellido;
                        txtDNI.Text = emp.DNI;
                        txtEmail.Text = emp.Email;
                        txtTelefono.Text = emp.Telefono;
                        
                        if (ddlSucursal.Items.FindByValue(emp.IdSucursal.ToString()) != null)
                            ddlSucursal.SelectedValue = emp.IdSucursal.ToString();
                            
                        if (ddlRol.Items.FindByValue(emp.Rol.ToString()) != null)
                            ddlRol.SelectedValue = emp.Rol.ToString();

                        txtFechaIngreso.Text = emp.FechaIngreso.ToString("yyyy-MM-dd");
                        txtSalario.Text = emp.Salario != null ? emp.Salario.Value.ToString("0.00") : "";
                        chkActivo.Checked = emp.Activo;
                    }
                }
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
                emp.IdSucursal = int.Parse(ddlSucursal.SelectedValue);
                emp.Rol = int.Parse(ddlRol.SelectedValue);
                emp.FechaIngreso = DateTime.Parse(txtFechaIngreso.Text);
                
                if (!string.IsNullOrEmpty(txtSalario.Text))
                    emp.Salario = decimal.Parse(txtSalario.Text);

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
                Session["Error"] = ex.Message;
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["id"] != null)
                {
                    NegocioEmpleado negocio = new NegocioEmpleado();
                    negocio.eliminarLogico(long.Parse(Request.QueryString["id"]), false);
                    Response.Redirect("Empleados.aspx", false);
                }
            }
            catch (Exception ex)
            {
                Session["Error"] = ex.Message;
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Empleados.aspx");
        }
    }
}