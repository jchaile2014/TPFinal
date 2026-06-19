using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace UnPocoDeHelado
{
    public partial class OperacionesABM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.sesionActiva(Session["usuario"]))
            {
                Response.Redirect("default.aspx", false);
                return;
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    cargarOperacion(long.Parse(Request.QueryString["id"]));
                }
                else if (Request.QueryString["tipo"] == "compra")
                {
                    if (!Seguridad.esAdmin(Session["usuario"]))
                    {
                        Session.Add("error", "Solo el administrador puede registrar compras.");
                        Response.Redirect("Error.aspx", false);
                        return;
                    }
                    titulo.InnerText = "Nueva Compra";
                    cargarCombos();
                    Session["carritoCompra"] = new List<DetalleOperacion>();
                    refrescarCarrito();
                }
                else
                {
                    Session.Add("error", "El registro de ventas se implementa en la proxima etapa.");
                    Response.Redirect("Error.aspx", false);
                }
            }
        }

        private void cargarCombos()
        {
            NegocioProveedor negProv = new NegocioProveedor();
            ddlProveedor.DataSource = negProv.listar();
            ddlProveedor.DataValueField = "Id";
            ddlProveedor.DataTextField = "Nombre";
            ddlProveedor.DataBind();

            cargarProductosDeProveedor();
        }

        private void cargarProductosDeProveedor()
        {
            Usuario u = (Usuario)Session["usuario"];
            long idProv = long.Parse(ddlProveedor.SelectedValue);

            NegocioProducto negProd = new NegocioProducto();
            List<Producto> productos = negProd.listarPorProveedor(idProv, u.IdSucursal);
            Session["productosCompra"] = productos;

            ddlProducto.DataSource = productos;
            ddlProducto.DataValueField = "Id";
            ddlProducto.DataTextField = "Nombre";
            ddlProducto.DataBind();

            mostrarDatosProducto();
        }

        private void mostrarDatosProducto()
        {
            List<Producto> productos = (List<Producto>)Session["productosCompra"];
            if (productos == null || productos.Count == 0 || string.IsNullOrEmpty(ddlProducto.SelectedValue))
            {
                txtStock.Text = "";
                txtPrecioCompra.Text = "";
                return;
            }

            long idProd = long.Parse(ddlProducto.SelectedValue);
            Producto prod = productos.Find(x => x.Id == idProd);
            if (prod != null)
            {
                txtStock.Text = prod.Cantidad.ToString();
                txtPrecioCompra.Text = prod.PrecioCompraActual.ToString(CultureInfo.InvariantCulture);
            }
        }

        private void cargarOperacion(long id)
        {
            NegocioOperacion negocio = new NegocioOperacion();
            Operacion op = negocio.obtenerPorId(id);
            titulo.InnerText = (op.SeOpera ? "Venta" : "Compra") + " #" + op.Id;
            pnlCarga.Visible = false;
            btnGuardar.Visible = false;
            dgvDetalle.DataSource = op.Detalles;
            dgvDetalle.DataBind();
            lblTotal.Text = op.Total.ToString("C");
        }

        protected void ddlProveedor_SelectedIndexChanged(object sender, EventArgs e)
        {
            cargarProductosDeProveedor();
        }

        protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
        {
            mostrarDatosProducto();
        }

        protected void btnAgregarDetalle_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlProducto.SelectedValue))
                return;

            List<DetalleOperacion> carrito = (List<DetalleOperacion>)Session["carritoCompra"];

            DetalleOperacion det = new DetalleOperacion();
            det.Producto = new Producto();
            det.Producto.Id = long.Parse(ddlProducto.SelectedValue);
            det.Producto.Nombre = ddlProducto.SelectedItem.Text;
            det.Proveedor = new Proveedor();
            det.Proveedor.Id = long.Parse(ddlProveedor.SelectedValue);
            det.Proveedor.Nombre = ddlProveedor.SelectedItem.Text;
            det.Cantidad = int.Parse(txtCantidad.Text);
            det.PrecioUnitario = decimal.Parse(txtPrecioCompra.Text, CultureInfo.InvariantCulture);
            det.Subtotal = det.Cantidad * det.PrecioUnitario;

            carrito.Add(det);
            Session["carritoCompra"] = carrito;

            txtCantidad.Text = "";
            refrescarCarrito();
        }

        private void refrescarCarrito()
        {
            List<DetalleOperacion> carrito = (List<DetalleOperacion>)Session["carritoCompra"];
            dgvDetalle.DataSource = carrito;
            dgvDetalle.DataBind();
            lblTotal.Text = carrito.Sum(x => x.Subtotal).ToString("C");
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                List<DetalleOperacion> carrito = (List<DetalleOperacion>)Session["carritoCompra"];
                if (carrito == null || carrito.Count == 0)
                {
                    Session.Add("error", "Agrega al menos un producto a la compra.");
                    Response.Redirect("Error.aspx", false);
                    return;
                }

                Usuario u = (Usuario)Session["usuario"];
                Operacion compra = new Operacion();
                compra.SeOpera = false;
                compra.Fecha = DateTime.Now;
                compra.IdSucursal = u.IdSucursal;
                compra.Empleado = u;
                compra.Estado = "Finalizado";
                compra.Total = carrito.Sum(x => x.Subtotal);
                compra.Detalles = carrito;

                NegocioOperacion negocio = new NegocioOperacion();
                negocio.registrarCompra(compra);

                Session.Remove("carritoCompra");
                Response.Redirect("Operaciones.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Session.Remove("carritoCompra");
            Response.Redirect("Operaciones.aspx");
        }
    }
}
