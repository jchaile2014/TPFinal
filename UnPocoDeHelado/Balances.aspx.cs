using Dominio;
using Negocio;
using System;
using System.Globalization;

namespace UnPocoDeHelado
{
    public partial class Balances : System.Web.UI.Page
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
                txtDesde.Text = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1).ToString("yyyy-MM-dd");
                txtHasta.Text = DateTime.Today.ToString("yyyy-MM-dd");
                cargarVistas();
                calcularVentas();
            }
        }

        private void cargarVistas()
        {
            try
            {
                Usuario u = (Usuario)Session["usuario"];
                NegocioReporte negocio = new NegocioReporte();
                dgvStockCritico.DataSource = negocio.stockCritico(u.IdSucursal);
                dgvStockCritico.DataBind();
                dgvTop.DataSource = negocio.topProductosVendidos();
                dgvTop.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        private void calcularVentas()
        {
            try
            {
                Usuario u = (Usuario)Session["usuario"];
                DateTime desde, hasta;
                if (!DateTime.TryParseExact(txtDesde.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out desde))
                    desde = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
                if (!DateTime.TryParseExact(txtHasta.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out hasta))
                    hasta = DateTime.Today;

                NegocioReporte negocio = new NegocioReporte();
                decimal total = negocio.ventasPorPeriodo(u.IdSucursal, desde, hasta);
                lblTotalVentas.Text = total.ToString("C");
                dgvDetalleVentas.DataSource = negocio.detalleVendidoPorPeriodo(u.IdSucursal, desde, hasta);
                dgvDetalleVentas.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnConsultar_Click(object sender, EventArgs e)
        {
            calcularVentas();
        }
    }
}
