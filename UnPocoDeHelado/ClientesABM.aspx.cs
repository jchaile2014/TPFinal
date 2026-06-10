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
                    titulo.InnerText = "Modificar Cliente";
                    btnEliminar.Visible = true;

                    long id = long.Parse(Request.QueryString["id"]);
                    NegocioCliente negocio = new NegocioCliente();

                    Cliente cli = negocio.listar().FirstOrDefault(x => x.Id == id);

                    if (cli != null)
                    {
                        txtNombre.Text = cli.Nombre;
                        txtApellido.Text = cli.Apellido;
                        txtDNI.Text = cli.DNI;
                        txtEmail.Text = cli.Email;
                        txtTelefono.Text = cli.Telefono;
                    }
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                Cliente cli = new Cliente();
                cli.Nombre = txtNombre.Text;
                cli.Apellido = txtApellido.Text;
                cli.DNI = txtDNI.Text;
                cli.Email = txtEmail.Text;
                cli.Telefono = txtTelefono.Text;

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
                throw ex;
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["id"] != null)
                {
                    long id = long.Parse(Request.QueryString["id"]);
                    NegocioCliente negocio = new NegocioCliente();
                    negocio.eliminar(id);
                    Response.Redirect("Clientes.aspx", false);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Clientes.aspx");
        }
    }
}