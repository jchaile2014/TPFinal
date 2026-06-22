using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI.WebControls;

namespace UnPocoDeHelado
{
    public partial class OperacionesABM : System.Web.UI.Page
    {
        private bool EsVenta
        {
            get { return ViewState["esVenta"] != null && (bool)ViewState["esVenta"]; }
            set { ViewState["esVenta"] = value; }
        }

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
                    return;
                }

                string tipo = Request.QueryString["tipo"];
                if (tipo == "compra")
                {
                    if (!Seguridad.esAdmin(Session["usuario"]))
                    {
                        Session.Add("error", "Solo el administrador puede registrar compras.");
                        Response.Redirect("Error.aspx", false);
                        return;
                    }
                    EsVenta = false;
                    titulo.InnerText = "Nueva Compra";
                    pnlCliente.Visible = false;
                    pnlMedioPago.Visible = false;
                    cargarCombosCompra();
                }
                else
                {
                    EsVenta = true;
                    titulo.InnerText = "Nueva Venta";
                    pnlProveedor.Visible = false;
                    txtPrecioUnit.ReadOnly = true;
                    cargarCombosVenta();
                }

                Session["carritoOperacion"] = new List<DetalleOperacion>();
                refrescarCarrito();
            }
        }

        private void cargarCombosCompra()
        {
            NegocioProveedor negProv = new NegocioProveedor();
            ddlProveedor.DataSource = negProv.listar();
            ddlProveedor.DataValueField = "Id";
            ddlProveedor.DataTextField = "Nombre";
            ddlProveedor.DataBind();
            cargarProductosDeProveedor();
        }

        private void cargarCombosVenta()
        {
            NegocioCliente negCli = new NegocioCliente();
            ddlCliente.DataSource = negCli.listar();
            ddlCliente.DataValueField = "Id";
            ddlCliente.DataTextField = "Nombre";
            ddlCliente.DataBind();

            ddlMedioPago.Items.Clear();
            ddlMedioPago.Items.Add(new ListItem("Efectivo", "1"));
            ddlMedioPago.Items.Add(new ListItem("Tarjeta", "2"));
            ddlMedioPago.Items.Add(new ListItem("Transferencia", "3"));

            Usuario u = (Usuario)Session["usuario"];
            NegocioProducto negProd = new NegocioProducto();
            List<Producto> productos = negProd.listar(u.IdSucursal);
            Session["productosOp"] = productos;
            ddlProducto.DataSource = productos;
            ddlProducto.DataValueField = "Id";
            ddlProducto.DataTextField = "Nombre";
            ddlProducto.DataBind();
            mostrarDatosProducto();
        }

        private void cargarProductosDeProveedor()
        {
            Usuario u = (Usuario)Session["usuario"];
            long idProv = long.Parse(ddlProveedor.SelectedValue);
            NegocioProducto negProd = new NegocioProducto();
            List<Producto> productos = negProd.listarPorProveedor(idProv, u.IdSucursal);
            Session["productosOp"] = productos;
            ddlProducto.DataSource = productos;
            ddlProducto.DataValueField = "Id";
            ddlProducto.DataTextField = "Nombre";
            ddlProducto.DataBind();
            mostrarDatosProducto();
        }

        private void mostrarDatosProducto()
        {
            List<Producto> productos = (List<Producto>)Session["productosOp"];
            if (productos == null || productos.Count == 0 || string.IsNullOrEmpty(ddlProducto.SelectedValue))
            {
                txtStock.Text = "";
                txtPrecioUnit.Text = "";
                return;
            }
            long idProd = long.Parse(ddlProducto.SelectedValue);
            Producto prod = productos.Find(x => x.Id == idProd);
            if (prod != null)
            {
                txtStock.Text = prod.Cantidad.ToString();
                if (EsVenta)
                    txtPrecioUnit.Text = prod.PrecioVenta.ToString("0.00", CultureInfo.InvariantCulture);
                else
                    txtPrecioUnit.Text = prod.PrecioCompraActual.ToString("0.00", CultureInfo.InvariantCulture);
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

        protected void dgvDetalle_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "EliminarItem")
                return;

            int indice = int.Parse(e.CommandArgument.ToString());
            List<DetalleOperacion> carrito = (List<DetalleOperacion>)Session["carritoOperacion"];
            if (carrito != null && indice >= 0 && indice < carrito.Count)
            {
                carrito.RemoveAt(indice);
                Session["carritoOperacion"] = carrito;
                refrescarCarrito();
            }
            lblMensaje.Text = "";
        }

        protected void btnAgregarDetalle_Click(object sender, EventArgs e)
        {
            lblMensaje.Text = "";
            if (string.IsNullOrEmpty(ddlProducto.SelectedValue))
                return;

            int cantidad;
            if (!int.TryParse(txtCantidad.Text, out cantidad) || cantidad <= 0)
            {
                lblMensaje.Text = "Ingresa una cantidad valida.";
                return;
            }

            decimal precio;
            if (!decimal.TryParse(txtPrecioUnit.Text, NumberStyles.Number, CultureInfo.InvariantCulture, out precio) || precio <= 0)
            {
                lblMensaje.Text = "Ingresa un precio valido.";
                return;
            }
            precio = Math.Round(precio, 2);

            long idProd = long.Parse(ddlProducto.SelectedValue);

            List<DetalleOperacion> carrito = (List<DetalleOperacion>)Session["carritoOperacion"];
            DetalleOperacion existente = carrito.Find(x => x.Producto.Id == idProd);
            int cantTotal = cantidad + (existente != null ? existente.Cantidad : 0);

            if (EsVenta && cantTotal > int.Parse(txtStock.Text))
            {
                lblMensaje.Text = "Stock insuficiente. Disponible: " + txtStock.Text;
                return;
            }

            if (existente != null)
            {
                existente.Cantidad = cantTotal;
                existente.PrecioUnitario = precio;
                existente.Subtotal = cantTotal * precio;
            }
            else
            {
                DetalleOperacion det = new DetalleOperacion();
                det.Producto = new Producto();
                det.Producto.Id = idProd;
                det.Producto.Nombre = ddlProducto.SelectedItem.Text;
                if (!EsVenta)
                {
                    det.Proveedor = new Proveedor();
                    det.Proveedor.Id = long.Parse(ddlProveedor.SelectedValue);
                    det.Proveedor.Nombre = ddlProveedor.SelectedItem.Text;
                }
                det.Cantidad = cantidad;
                det.PrecioUnitario = precio;
                det.Subtotal = cantidad * precio;
                carrito.Add(det);
            }

            Session["carritoOperacion"] = carrito;
            txtCantidad.Text = "";
            refrescarCarrito();
        }

        private void refrescarCarrito()
        {
            List<DetalleOperacion> carrito = (List<DetalleOperacion>)Session["carritoOperacion"];
            dgvDetalle.DataSource = carrito;
            dgvDetalle.DataBind();
            lblTotal.Text = carrito.Sum(x => x.Subtotal).ToString("C");
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                List<DetalleOperacion> carrito = (List<DetalleOperacion>)Session["carritoOperacion"];
                if (carrito == null || carrito.Count == 0)
                {
                    lblMensaje.Text = "Agrega al menos un producto.";
                    return;
                }
                if (EsVenta && string.IsNullOrEmpty(ddlCliente.SelectedValue))
                {
                    lblMensaje.Text = "Selecciona un cliente.";
                    return;
                }
                Session.Remove("carritoOperacion");

                Usuario u = (Usuario)Session["usuario"];
                Operacion op = new Operacion();
                op.Fecha = DateTime.Now;
                op.IdSucursal = u.IdSucursal;
                op.Empleado = u;
                op.Total = carrito.Sum(x => x.Subtotal);
                op.Detalles = carrito;

                NegocioOperacion negocio = new NegocioOperacion();

                if (EsVenta)
                {
                    op.SeOpera = true;
                    op.Cliente = new Cliente();
                    op.Cliente.Id = long.Parse(ddlCliente.SelectedValue);
                    op.MedioPago = int.Parse(ddlMedioPago.SelectedValue);
                    op.Estado = "Cobrada";
                    long idVenta = negocio.registrarVenta(op);
                    Response.Redirect("Factura.aspx?id=" + idVenta, false);
                    return;
                }

                op.SeOpera = false;
                op.Estado = "Finalizado";
                negocio.registrarCompra(op);
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
            Session.Remove("carritoOperacion");
            Response.Redirect("Operaciones.aspx");
        }
    }
}
