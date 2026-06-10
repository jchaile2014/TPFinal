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
    public partial class OperacionesABM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    long id = long.Parse(Request.QueryString["id"]);
                    NegocioOperacion negocio = new NegocioOperacion();
                    Operacion op = negocio.obtenerPorId(id);

                    titulo.InnerText = "Ver Operación #" + op.Id;
                    ddlTipo.SelectedValue = op.SeOpera.ToString();
                    txtFecha.Text = op.Fecha.ToString("yyyy-MM-dd");
                    txtTotal.Text = op.Total.ToString();

                    dgvDetalle.DataSource = op.Detalles;
                    dgvDetalle.DataBind();

                    ddlTipo.Enabled = false;
                    ddlCliente.Enabled = false;
                    ddlProveedor.Enabled = false;
                    ddlMedioPago.Enabled = false;
                    txtFecha.Enabled = false;
                    ddlProducto.Enabled = false;
                    txtCantidad.Enabled = false;
                    btnAgregarDetalle.Visible = false;
                    btnGuardar.Visible = false;
                }
            }
        }

        protected void btnAgregarDetalle_Click(object sender, EventArgs e)
        {
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Operaciones.aspx");
        }
    }
}