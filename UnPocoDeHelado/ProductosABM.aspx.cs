using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UnPocoDeHelado
{
    public partial class ProductosABM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarCategorias();

                if (Request.QueryString["id"] != null)
                {
                    long id = long.Parse(Request.QueryString["id"]);
                    titulo.InnerText = "Modificar Producto";
                    cargarProducto(id);
                    btnEliminar.Visible = true;
                }
                else
                {
                    titulo.InnerText = "Nuevo Producto";
                    btnEliminar.Visible = false;
                }
            }
        }

        private void cargarCategorias()
        {
            ddlCategoria.Items.Add(new ListItem("HeladosDeAgua", "1"));
            ddlCategoria.Items.Add(new ListItem("HeladosDeCrema", "2"));
            ddlCategoria.Items.Add(new ListItem("HeladosPremiun", "3"));
            ddlCategoria.Items.Add(new ListItem("Cafeteria", "4"));
            ddlCategoria.Items.Add(new ListItem("Reposteria", "5"));
        }

        private void cargarProducto(long id)
        {
            try
            {
                NegocioProducto negocio = new NegocioProducto();
                List<Producto> lista = negocio.listar();

                Producto prod = lista.Find(x => x.Id == id);
                if (prod != null)
                {
                    txtNombre.Text = prod.Nombre;
                    ddlCategoria.SelectedValue = prod.Categoria.ToString();
                    txtMarca.Text = prod.Marca ?? "";
                    txtPrecioVenta.Text = prod.PrecioVenta.ToString(System.Globalization.CultureInfo.InvariantCulture);
                    txtDescripcion.Text = prod.Descripcion ?? "";
                    chkActivo.Checked = prod.Activo;
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
                Producto prod = new Producto();
                prod.Nombre = txtNombre.Text;
                prod.Categoria = int.Parse(ddlCategoria.SelectedValue);
                prod.Marca = txtMarca.Text;
                prod.PrecioVenta = decimal.Parse(txtPrecioVenta.Text, System.Globalization.CultureInfo.InvariantCulture);
                prod.Descripcion = txtDescripcion.Text;
                prod.Activo = chkActivo.Checked;

                NegocioProducto negocio = new NegocioProducto();

                if (Request.QueryString["id"] != null)
                {
                    prod.Id = long.Parse(Request.QueryString["id"]);
                    negocio.modificar(prod);
                }
                else
                {
                    negocio.agregar(prod);
                }
                Response.Redirect("Productos.aspx", false);
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
                NegocioProducto negocio = new NegocioProducto();
                negocio.eliminarLogico(id, false);
                Response.Redirect("Productos.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Productos.aspx", false);
        }
    }
}