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
                    titulo.InnerText = "Modificar Proveedor";
                    btnEliminar.Visible = true;

                    long id = long.Parse(Request.QueryString["id"]);
                    NegocioProveedor negocio = new NegocioProveedor();

                    Proveedor prov = negocio.listar().FirstOrDefault(x => x.Id == id);

                    if (prov != null)
                    {
                        txtNombre.Text = prov.Nombre;
                        txtCUIT.Text = prov.CUIT;
                        txtTelefono.Text = prov.Telefono;
                        txtEmail.Text = prov.Email;
                        txtDireccion.Text = prov.Direccion;
                        txtRubro.Text = prov.Rubro;
                        chkActivo.Checked = prov.Activo;
                    }
                }
            }
        }
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                Proveedor prov = new Proveedor();
                prov.Nombre = txtNombre.Text;
                prov.CUIT = txtCUIT.Text;
                prov.Telefono = txtTelefono.Text;
                prov.Email = txtEmail.Text;
                prov.Direccion = txtDireccion.Text;
                prov.Rubro = txtRubro.Text;
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
                    NegocioProveedor negocio = new NegocioProveedor();
                    negocio.eliminar(id);
                    Response.Redirect("Proveedores.aspx", false);
                }
        }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Proveedores.aspx");
        }
    }
}