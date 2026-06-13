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
    public partial class ClientesABM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    long id = long.Parse(Request.QueryString["id"]);
                    titulo.InnerText = "Modificar Cliente";
                    cargarCliente(id);
                }
                else
                {
                    titulo.InnerText = "Nuevo Cliente";
                }
            }
        }

        private void cargarCliente(long id)
        {
            try
            {
                NegocioCliente negocio = new NegocioCliente();
                List<Cliente> lista = negocio.listar();
                Cliente cli = lista.Find(x => x.Id == id);
                if (cli != null)
                {
                    txtNombre.Text = cli.Nombre;
                    txtApellido.Text = cli.Apellido;
                    txtDNI.Text = cli.DNI ?? "";
                    txtEmail.Text = cli.Email ?? "";
                    txtTelefono.Text = cli.Telefono ?? "";
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
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
                Cliente cli = new Cliente();
                cli.Nombre = txtNombre.Text;
                cli.Apellido = txtApellido.Text;
                cli.DNI = string.IsNullOrEmpty(txtDNI.Text) ? null : txtDNI.Text;
                cli.Email = string.IsNullOrEmpty(txtEmail.Text) ? null : txtEmail.Text;
                cli.Telefono = string.IsNullOrEmpty(txtTelefono.Text) ? null : txtTelefono.Text;

                NegocioCliente negocio = new NegocioCliente();
                if (Request.QueryString["id"] != null)
                {
                    cli.Id = long.Parse(Request.QueryString["id"]);
                    negocio.modificar(cli);
                }
                else
                {
                    negocio.agregar(cli);
                }
                Response.Redirect("Clientes.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Clientes.aspx", false);
        }
    }
}