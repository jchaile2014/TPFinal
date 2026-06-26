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
    public partial class Productos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.sesionActiva(Session["usuario"]))
            {
                Response.Redirect("default.aspx", false);
                return;
            }
            if (!Seguridad.esAdmin(Session["usuario"]))
            {
                Session.Add("error", "No tenés permisos para acceder a esta sección.");
                Response.Redirect("Error.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                cargarCategorias();
                cargarProductos();
            }
        }

        private void cargarCategorias()
        {
            try
            {
                NegocioClasificacion negocio = new NegocioClasificacion();
                List<Clasificacion> lista = negocio.listar(false);
                ddlCategoria.DataSource = lista;
                ddlCategoria.DataTextField = "Nombre";
                ddlCategoria.DataValueField = "Id";
                ddlCategoria.DataBind();
                ddlCategoria.Items.Insert(0, new ListItem("Todas las categorías", ""));
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        private void cargarProductos()
        {
            try
            {
                Usuario u = (Usuario)Session["usuario"];
                NegocioProducto negocio = new NegocioProducto();
                List<Producto> lista = negocio.listar(u.IdSucursal);

                if (!string.IsNullOrWhiteSpace(txtFiltro.Text))
                {
                    string filtro = txtFiltro.Text.ToLower();
                    lista = lista.FindAll(x => x.Nombre.ToLower().Contains(filtro));
                }

                if (!string.IsNullOrEmpty(ddlCategoria.SelectedValue))
                {
                    long idCategoria = long.Parse(ddlCategoria.SelectedValue);
                    lista = lista.FindAll(x => x.Categoria != null && x.Categoria.Id == idCategoria);
                }

                if (btnOrdenarStock.CssClass.Contains("active"))
                {
                    lista = lista.OrderByDescending(x => x.Cantidad).ToList();
                }
                else if (btnOrdenarStockMenor.CssClass.Contains("active"))
                {
                    lista = lista.OrderBy(x => x.Cantidad).ToList();
                }
                else
                {
                    lista = lista.OrderBy(x => x.Nombre).ToList();
                }

                rptProductos.DataSource = lista;
                rptProductos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnOrdenPredeterminado_Click(object sender, EventArgs e)
        {
            btnOrdenPredeterminado.CssClass = "filter-pill active";
            btnOrdenarStock.CssClass = "filter-pill";
            btnOrdenarStockMenor.CssClass = "filter-pill";
            cargarProductos();
        }

        protected void btnOrdenarStock_Click(object sender, EventArgs e)
        {
            btnOrdenPredeterminado.CssClass = "filter-pill";
            btnOrdenarStock.CssClass = "filter-pill active";
            btnOrdenarStockMenor.CssClass = "filter-pill";
            cargarProductos();
        }

        protected void btnOrdenarStockMenor_Click(object sender, EventArgs e)
        {
            btnOrdenPredeterminado.CssClass = "filter-pill";
            btnOrdenarStock.CssClass = "filter-pill";
            btnOrdenarStockMenor.CssClass = "filter-pill active";
            cargarProductos();
        }

        protected void Filtro_Changed(object sender, EventArgs e)
        {
            cargarProductos();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProductosABM.aspx", false);
        }
    }
}