using Dominio;
using Negocio;
using System;
using System.Web.UI;

namespace UnPocoDeHelado
{
    public partial class OlvideClave : System.Web.UI.Page
    {
        protected int paso
        {
            get { return ViewState["paso"] != null ? (int)ViewState["paso"] : 1; }
            set { ViewState["paso"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] != null)
                Response.Redirect("Operaciones.aspx", false);

            if (!IsPostBack)
            {
                paso = 1;
                MostrarPaso(1);
            }
        }

        protected void btnVerificar_Click(object sender, EventArgs e)
        {
            OcultarAlerta();
            try
            {
                NegocioUsuario negocio = new NegocioUsuario();
                Usuario u = negocio.obtenerPorEmail(txtEmail.Text.Trim());

                if (u == null)
                {
                    MostrarAlerta("danger", "<i class=\"bi bi-exclamation-triangle me-2\"></i>No encontramos una cuenta activa con ese correo.");
                    return;
                }

                string claveTemporal = negocio.restablecerClaveTemporal(u.Id);

                ServicioCorreo correo = new ServicioCorreo();
                correo.enviar(
                    u.Email,
                    "Recuperación de clave - Un Poco De Helado",
                    "<p>Hola " + u.Nombre + ",</p>" +
                    "<p>Tu clave temporal es: <b style=\"font-size:1.2rem; color:#ff758c;\">" + claveTemporal + "</b></p>" +
                    "<p>Ingresá al sistema con esta clave y cambiala apenas puedas.</p>" +
                    "<p style=\"color:#999; font-size:0.85rem;\">Si no pediste este cambio, ignorá este correo.</p>");

                paso = 3;
                MostrarPaso(3);
            }
            catch (Exception ex)
            {
                MostrarAlerta("danger", "<i class=\"bi bi-exclamation-triangle me-2\"></i>No se pudo enviar el correo: " + ex.Message);
            }
        }

        private void MostrarPaso(int numeroPaso)
        {
            pnlPaso1.Visible = (numeroPaso == 1);
            pnlExito.Visible = (numeroPaso == 3);
        }

        private void MostrarAlerta(string tipo, string mensaje)
        {
            pnlAlerta.Visible = true;
            divAlerta.InnerHtml = mensaje;
            divAlerta.Attributes["class"] = $"alert alert-{tipo} alert-recover mb-3";
        }

        private void OcultarAlerta()
        {
            pnlAlerta.Visible = false;
        }
    }
}
