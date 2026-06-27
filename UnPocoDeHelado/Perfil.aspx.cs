using Dominio;
using Negocio;
using System;
using System.Collections.Generic;

namespace UnPocoDeHelado
{
    public partial class Perfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.sesionActiva(Session["usuario"]))
            {
                Response.Redirect("default.aspx", false);
                return;
            }
            if (!IsPostBack)
                cargarDatos();
        }

        private Empleado obtenerEmpleadoActual()
        {
            Usuario u = (Usuario)Session["usuario"];
            NegocioEmpleado negocio = new NegocioEmpleado();
            List<Empleado> lista = negocio.listar();
            return lista.Find(x => x.Id == u.Id);
        }

        private void cargarDatos()
        {
            try
            {
                Usuario u = (Usuario)Session["usuario"];
                Empleado emp = obtenerEmpleadoActual();

                lblRol.Text = Seguridad.esAdmin(Session["usuario"]) ? "Administrador" : "Vendedor";
                txtUsuario.Text = u.NombreUsuario;
                txtNombre.Text = emp.Nombre;
                txtApellido.Text = emp.Apellido;
                txtDNI.Text = emp.DNI;
                txtEmail.Text = emp.Email;
                txtTelefono.Text = emp.Telefono;
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnGuardarDatos_Click(object sender, EventArgs e)
        {
            Page.Validate("vgDatos");
            if (!Page.IsValid)
                return;
            try
            {
                Usuario u = (Usuario)Session["usuario"];
                string nuevoUsuario = txtUsuario.Text.Trim();

                NegocioUsuario negocioUsuario = new NegocioUsuario();
                if (nuevoUsuario != u.NombreUsuario && negocioUsuario.existeUsuario(nuevoUsuario))
                {
                    lblMsgDatos.Text = "✗ Ese nombre de usuario ya está en uso.";
                    lblMsgDatos.CssClass = "fw-semibold text-danger";
                    return;
                }

                Empleado emp = obtenerEmpleadoActual();
                emp.Nombre = txtNombre.Text.Trim();
                emp.Apellido = txtApellido.Text.Trim();
                emp.DNI = txtDNI.Text.Trim();
                emp.Email = string.IsNullOrWhiteSpace(txtEmail.Text) ? null : txtEmail.Text.Trim();
                emp.Telefono = string.IsNullOrWhiteSpace(txtTelefono.Text) ? null : txtTelefono.Text.Trim();

                NegocioEmpleado negocio = new NegocioEmpleado();
                negocio.modificar(emp);

                if (nuevoUsuario != u.NombreUsuario)
                    negocioUsuario.cambiarNombreUsuario(u.Id, nuevoUsuario);

                u.NombreUsuario = nuevoUsuario;
                u.Nombre = emp.Nombre;
                u.Apellido = emp.Apellido;
                u.Email = emp.Email;
                Session["usuario"] = u;

                lblMsgDatos.Text = "✓ Datos actualizados.";
                lblMsgDatos.CssClass = "fw-semibold text-success";
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnCambiarClave_Click(object sender, EventArgs e)
        {
            Page.Validate("vgClave");
            if (!Page.IsValid)
                return;
            try
            {
                Usuario u = (Usuario)Session["usuario"];
                NegocioUsuario negocio = new NegocioUsuario();

                if (negocio.login(u.NombreUsuario, txtClaveActual.Text) == null)
                {
                    lblMsgClave.Text = "✗ La clave actual es incorrecta.";
                    lblMsgClave.CssClass = "fw-semibold text-danger";
                    return;
                }

                negocio.cambiarPassword(u.Id, txtNuevaClave.Text);

                txtClaveActual.Text = "";
                txtNuevaClave.Text = "";
                txtConfirmarClave.Text = "";
                lblMsgClave.Text = "✓ Contraseña actualizada.";
                lblMsgClave.CssClass = "fw-semibold text-success";
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }
    }
}
