using Dominio;
using Negocio;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;

namespace UnPocoDeHelado
{
    public partial class Balances : System.Web.UI.Page
    {
        protected string topLabels = "[]";
        protected string topData = "[]";
        protected string detalleLabels = "[]";
        protected string detalleData = "[]";

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
                calcularVentas();
            }
            cargarVistas();
        }

        private void cargarVistas()
        {
            try
            {
                Usuario u = (Usuario)Session["usuario"];
                NegocioReporte negocio = new NegocioReporte();
                dgvStockCritico.DataSource = negocio.stockCritico(u.IdSucursal);
                dgvStockCritico.DataBind();
                DataTable top = negocio.topProductosVendidos();
                dgvTop.DataSource = top;
                dgvTop.DataBind();
                ArmarSerie(top, "Producto", "UnidadesVendidas", 8, out topLabels, out topData);
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
                DataTable detalle = negocio.detalleVendidoPorPeriodo(u.IdSucursal, desde, hasta);
                dgvDetalleVentas.DataSource = detalle;
                dgvDetalleVentas.DataBind();
                ArmarSerie(detalle, "Producto", "Cantidad", 10, out detalleLabels, out detalleData);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        private void ArmarSerie(DataTable tabla, string colLabel, string colData, int max, out string labels, out string data)
        {
            List<string> ls = new List<string>();
            List<string> ds = new List<string>();
            int i = 0;
            foreach (DataRow row in tabla.Rows)
            {
                if (i++ >= max) break;
                ls.Add("\"" + row[colLabel].ToString().Replace("\\", "").Replace("\"", "'") + "\"");
                ds.Add(Convert.ToString(row[colData], CultureInfo.InvariantCulture));
            }
            labels = "[" + string.Join(",", ls) + "]";
            data = "[" + string.Join(",", ds) + "]";
        }

        protected void btnConsultar_Click(object sender, EventArgs e)
        {
            calcularVentas();
        }
    }
}
