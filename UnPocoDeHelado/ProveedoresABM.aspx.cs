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
    public partial class ProveedoresABM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    long id = long.Parse(Request.QueryString["id"]);
                    titulo.InnerText = "Modificar Proveedor";
                    cargarProveedor(id);
                    btnEliminar.Visible = true;
                }
                else
                {
                    titulo.InnerText = "Nuevo Proveedor";
                    btnEliminar.Visible = false;
                }
            }
        }

        private void cargarProveedor(long id)
        {
            try
            {
                NegocioProveedor negocio = new NegocioProveedor();
                List<Proveedor> lista = negocio.listar();
                Proveedor prov = lista.Find(x => x.Id == id);
                if (prov != null)
                {
                    txtNombre.Text = prov.Nombre;
                    txtCUIT.Text = prov.CUIT;
                    txtTelefono.Text = prov.Telefono ?? "";
                    txtEmail.Text = prov.Email ?? "";
                    txtDireccion.Text = prov.Direccion ?? "";
                    txtRubro.Text = prov.Rubro ?? "";
                    chkActivo.Checked = prov.Activo;
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
            try
            {
                Proveedor prov = new Proveedor();
                prov.Nombre = txtNombre.Text;
                prov.CUIT = txtCUIT.Text;
                prov.Telefono = string.IsNullOrEmpty(txtTelefono.Text) ? null : txtTelefono.Text;
                prov.Email = string.IsNullOrEmpty(txtEmail.Text) ? null : txtEmail.Text;
                prov.Direccion = string.IsNullOrEmpty(txtDireccion.Text) ? null : txtDireccion.Text;
                prov.Rubro = string.IsNullOrEmpty(txtRubro.Text) ? null : txtRubro.Text;
                prov.Activo = chkActivo.Checked;

                NegocioProveedor negocio = new NegocioProveedor();
                if (Request.QueryString["id"] != null)
                {
                    prov.Id = long.Parse(Request.QueryString["id"]);
                    negocio.modificar(prov);
                }
                else
                {
                    negocio.agregar(prov);
                }
                Response.Redirect("Proveedores.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                long id = long.Parse(Request.QueryString["id"]);
                NegocioProveedor negocio = new NegocioProveedor();
                negocio.eliminarLogico(id, false);
                Response.Redirect("Proveedores.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Proveedores.aspx", false);
        }
    }
}