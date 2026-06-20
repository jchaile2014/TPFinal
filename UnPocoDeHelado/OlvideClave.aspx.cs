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
                Usuario u = negocio.verificarIdentidad(txtUsuarioPaso1.Text.Trim(), txtDNI.Text.Trim());

                if (u != null)
                {
                    ViewState["idUsuario"] = u.Id;
                    ViewState["nombreUsuario"] = u.NombreUsuario;
                    paso = 2;
                    MostrarPaso(2);
                    MostrarAlerta("success", $"<i class=\"bi bi-check-circle me-2\"></i>Identidad verificada. ¡Hola, {u.Nombre}! Podes ingresar tu nueva clave.");
                }
                else
                {
                    MostrarAlerta("danger", "<i class=\"bi bi-exclamation-triangle me-2\"></i>No encontramos una cuenta activa con ese usuario y DNI. Verifica los datos ingresados.");
                }
            }
            catch (Exception ex)
            {
                MostrarAlerta("danger", "<i class=\"bi bi-exclamation-triangle me-2\"></i>Ocurrio un error inesperado: " + ex.Message);
            }
        }

        protected void btnCambiarPass_Click(object sender, EventArgs e)
        {
            OcultarAlerta();

            paso = 2;
            MostrarPaso(2);

            if (ViewState["idUsuario"] == null)
            {
                paso = 1;
                MostrarPaso(1);
                MostrarAlerta("warning", "<i class=\"bi bi-exclamation-triangle me-2\"></i>La sesión expiro, por favor comenza de nuevo.");
                return;
            }

            if (string.IsNullOrWhiteSpace(txtNuevaPass.Text))
            {
                MostrarAlerta("danger", "<i class=\"bi bi-exclamation-triangle me-2\"></i>La nueva clave es requerida.");
                return;
            }

            if (txtNuevaPass.Text.Length < 6)
            {
                MostrarAlerta("danger", "<i class=\"bi bi-exclamation-triangle me-2\"></i>La clave debe tener al menos 6 caracteres.");
                return;
            }

            if (txtNuevaPass.Text != txtConfirmarPass.Text)
            {
                MostrarAlerta("danger", "<i class=\"bi bi-exclamation-triangle me-2\"></i>Las claves no coinciden. Por favor verifica que hayas escrito lo mismo en ambos campos.");
                return;
            }

            try
            {
                long idUsuario = (long)ViewState["idUsuario"];
                NegocioUsuario negocio = new NegocioUsuario();
                negocio.cambiarPassword(idUsuario, txtNuevaPass.Text);

                paso = 3;
                MostrarPaso(3);
            }
            catch (Exception ex)
            {
                MostrarAlerta("danger", "<i class=\"bi bi-exclamation-triangle me-2\"></i>Error al guardar la clave: " + ex.Message);
            }
        }

        protected void btnVolverPaso1_Click(object sender, EventArgs e)
        {
            OcultarAlerta();
            paso = 1;
            MostrarPaso(1);
            ViewState["idUsuario"] = null;
            ViewState["nombreUsuario"] = null;
        }

        private void MostrarPaso(int numeroPaso)
        {
            pnlPaso1.Visible = (numeroPaso == 1);
            pnlPaso2.Visible = (numeroPaso == 2);
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
