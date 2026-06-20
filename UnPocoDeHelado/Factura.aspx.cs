using Dominio;
using Negocio;
using System;

namespace UnPocoDeHelado
{
    public partial class Factura : System.Web.UI.Page
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
                if (Request.QueryString["id"] == null)
                {
                    Response.Redirect("Operaciones.aspx", false);
                    return;
                }

                long id = long.Parse(Request.QueryString["id"]);
                NegocioOperacion negocio = new NegocioOperacion();
                Operacion op = negocio.obtenerPorId(id);

                lblNumero.Text = op.NumeroFactura ?? "-";
                lblFecha.Text = op.Fecha.ToString("dd/MM/yyyy HH:mm");
                lblCliente.Text = op.Cliente != null ? op.Cliente.Nombre : "Consumidor Final";
                dgvDetalle.DataSource = op.Detalles;
                dgvDetalle.DataBind();
                lblTotal.Text = op.Total.ToString("C");
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Operaciones.aspx");
        }
    }
}
