using System;
using System.Configuration;
using System.Net;
using System.Net.Mail;

namespace Negocio
{
    public class ServicioCorreo
    {
        public void enviar(string destino, string asunto, string cuerpoHtml)
        {
            string remitente = ConfigurationManager.AppSettings["CorreoRemitente"];
            string clave = ConfigurationManager.AppSettings["CorreoClave"];
            string host = ConfigurationManager.AppSettings["CorreoHost"];
            int puerto = int.Parse(ConfigurationManager.AppSettings["CorreoPuerto"]);

            MailMessage mensaje = new MailMessage();
            mensaje.From = new MailAddress(remitente, "Un Poco De Helado");
            mensaje.To.Add(destino);
            mensaje.Subject = asunto;
            mensaje.Body = cuerpoHtml;
            mensaje.IsBodyHtml = true;

            using (SmtpClient smtp = new SmtpClient(host, puerto))
            {
                smtp.EnableSsl = true;
                smtp.Credentials = new NetworkCredential(remitente, clave);
                smtp.Send(mensaje);
            }
        }
    }
}
