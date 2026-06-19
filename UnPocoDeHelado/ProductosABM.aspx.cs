using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Globalization;
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
            if (!Seguridad.esAdmin(Session["usuario"]))
            {
                Session.Add("error", "No tenés permisos para acceder a esta sección.");
                Response.Redirect("Error.aspx", false);
                return;
            }
            if (!IsPostBack)
            {
                cargarCombos();
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

        private void cargarCombos()
        {
            NegocioClasificacion negocio = new NegocioClasificacion();
            ddlMarca.DataSource = negocio.listar(true);
            ddlMarca.DataValueField = "Id";
            ddlMarca.DataTextField = "Nombre";
            ddlMarca.DataBind();

            ddlCategoria.DataSource = negocio.listar(false);
            ddlCategoria.DataValueField = "Id";
            ddlCategoria.DataTextField = "Nombre";
            ddlCategoria.DataBind();
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
                    txtDescripcion.Text = prod.Descripcion ?? "";
                    if (prod.Marca != null) ddlMarca.SelectedValue = prod.Marca.Id.ToString();
                    if (prod.Categoria != null) ddlCategoria.SelectedValue = prod.Categoria.Id.ToString();
                    txtCantidad.Text = prod.Cantidad.ToString();
                    txtStockMinimo.Text = prod.StockMinimo.ToString();
                    txtPorcentaje.Text = prod.PorcentajeGanancia.ToString(CultureInfo.InvariantCulture);
                    txtPrecioCompra.Text = prod.PrecioCompraActual.ToString(CultureInfo.InvariantCulture);
                    chkActivo.Checked = prod.Activo;
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
                Producto prod = new Producto();
                prod.Nombre = txtNombre.Text;
                prod.Descripcion = string.IsNullOrEmpty(txtDescripcion.Text) ? null : txtDescripcion.Text;
                prod.Marca = new Clasificacion();
                prod.Marca.Id = long.Parse(ddlMarca.SelectedValue);
                prod.Categoria = new Clasificacion();
                prod.Categoria.Id = long.Parse(ddlCategoria.SelectedValue);
                prod.Cantidad = int.Parse(txtCantidad.Text);
                prod.StockMinimo = int.Parse(txtStockMinimo.Text);
                prod.PorcentajeGanancia = decimal.Parse(txtPorcentaje.Text, CultureInfo.InvariantCulture);
                prod.PrecioCompraActual = decimal.Parse(txtPrecioCompra.Text, CultureInfo.InvariantCulture);
                prod.IdSucursal = ((Usuario)Session["usuario"]).IdSucursal;
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
                Session.Add("error", ex.ToString());
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
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Productos.aspx", false);
        }
    }
}