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
    public partial class SucursalesABM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    long id = long.Parse(Request.QueryString["id"]);
                    titulo.InnerText = "Modificar Sucursal";
                    cargarSucursal(id);
                    btnEliminar.Visible = true;
                }
                else
                {
                    titulo.InnerText = "Nueva Sucursal";
                    btnEliminar.Visible = false;
                }
            }
        }

        private void cargarSucursal(long id)
        {
            try
            {
                NegocioSucursal negocio = new NegocioSucursal();
                List<Sucursal> lista = negocio.listar();

                Sucursal suc = lista.Find(x => x.Id == id);
                if (suc != null)
                {
                    txtNombre.Text = suc.Nombre;
                    txtDireccion.Text = suc.Direccion;
                    txtCiudad.Text = suc.Ciudad;
                    txtProvincia.Text = suc.Provincia;
                    txtTelefono.Text = suc.Telefono ?? "";
                    txtEmail.Text = suc.Email ?? "";
                    txtFechaApertura.Text = suc.FechaApertura.ToString("yyyy-MM-dd");
                    chkActiva.Checked = suc.Activa;
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
                Sucursal suc = new Sucursal();
                suc.Nombre = txtNombre.Text;
                suc.Direccion = txtDireccion.Text;
                suc.Ciudad = txtCiudad.Text;
                suc.Provincia = txtProvincia.Text;
                suc.Telefono = txtTelefono.Text;
                suc.Email = txtEmail.Text;
                suc.FechaApertura = DateTime.Parse(txtFechaApertura.Text);
                suc.Activa = chkActiva.Checked;

                NegocioSucursal negocio = new NegocioSucursal();

                if (Request.QueryString["id"] != null)
                {
                    suc.Id = long.Parse(Request.QueryString["id"]);
                    negocio.modificar(suc);
                }
                else
                {
                    negocio.agregar(suc);
                }
                Response.Redirect("Sucursales.aspx", false);
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
                NegocioSucursal negocio = new NegocioSucursal();
                negocio.eliminarLogico(id, false);
                Response.Redirect("Sucursales.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Sucursales.aspx", false);
        }
    }
}