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
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] != null)
            {
                Usuario u = (Usuario)Session["usuario"];
                pnlLogin.Visible = false;
                pnlLogueado.Visible = true;
                lblUsuario.Text = u.NombreUsuario;
                lblRol.Text = u.Rol == 1 ? "Administrador" : "Vendedor";
            }
        }

        protected void btnSalirDefault_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("default.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                NegocioUsuario negocio = new NegocioUsuario();
                Usuario u = negocio.login(txtUsuario.Text, txtPassword.Text);
                if (u != null)
                {
                    Session["usuario"] = u;
                    Response.Redirect("Operaciones.aspx", false);
                }
                else
                {
                    Session.Add("error", "Usuario o contraseña incorrectos");
                    Response.Redirect("Error.aspx", false);
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }
    }
}