<%@ Page Title="Olvide mi Clave" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OlvideClave.aspx.cs" Inherits="UnPocoDeHelado.OlvideClave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .recover-wrapper {
            min-height: 75vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }
        .recover-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 15px 40px rgba(255, 117, 140, 0.15);
            border: 1px solid rgba(255, 126, 179, 0.2);
            width: 100%;
            max-width: 450px;
        }
        .recover-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, #ff758c, #ff7eb3);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 1.8rem;
            color: white;
            box-shadow: 0 8px 20px rgba(255, 117, 140, 0.35);
        }
        .recover-title {
            font-size: 1.6rem;
            font-weight: 700;
            color: #4a4a4a;
            text-align: center;
            margin-bottom: 0.3rem;
        }
        .recover-subtitle {
            color: #9a9a9a;
            font-size: 0.9rem;
            text-align: center;
            margin-bottom: 2rem;
        }
        .step-indicator {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0;
            margin-bottom: 2rem;
        }
        .step-dot {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: 600;
            transition: all 0.3s;
        }
        .step-dot.active {
            background: linear-gradient(135deg, #ff758c, #ff7eb3);
            color: white;
            box-shadow: 0 4px 12px rgba(255, 117, 140, 0.4);
        }
        .step-dot.done {
            background: #28a745;
            color: white;
        }
        .step-dot.inactive {
            background: #e9ecef;
            color: #9a9a9a;
        }
        .step-line {
            width: 60px;
            height: 3px;
            background: #e9ecef;
            border-radius: 2px;
            transition: background 0.3s;
        }
        .step-line.done {
            background: linear-gradient(to right, #ff758c, #ff7eb3);
        }
        .form-label-custom {
            font-weight: 600;
            color: #6c757d;
            font-size: 0.88rem;
            margin-bottom: 0.4rem;
        }
        .form-control-custom {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            border: 1.5px solid #e0e0e0;
            font-size: 0.95rem;
            transition: all 0.3s;
        }
        .form-control-custom:focus {
            border-color: #ff7eb3;
            box-shadow: 0 0 0 0.2rem rgba(255, 126, 179, 0.2);
        }
        .btn-recover {
            background: linear-gradient(to right, #ff758c 0%, #ff7eb3 100%);
            border: none;
            color: white;
            font-weight: 600;
            padding: 0.8rem;
            border-radius: 10px;
            transition: all 0.3s ease;
            width: 100%;
            font-size: 1rem;
        }
        .btn-recover:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(255, 117, 140, 0.4);
            color: white;
        }
        .btn-back {
            background: transparent;
            border: 1.5px solid #e0e0e0;
            color: #9a9a9a;
            font-weight: 500;
            padding: 0.7rem;
            border-radius: 10px;
            transition: all 0.3s ease;
            width: 100%;
            font-size: 0.9rem;
            text-decoration: none;
            display: block;
            text-align: center;
            margin-top: 0.75rem;
        }
        .btn-back:hover {
            border-color: #ff7eb3;
            color: #ff7eb3;
        }
        .alert-recover {
            border-radius: 10px;
            font-size: 0.9rem;
            border: none;
            padding: 0.75rem 1rem;
        }
        .success-checkmark {
            font-size: 4rem;
            color: #28a745;
            text-align: center;
            display: block;
            margin-bottom: 1rem;
            animation: bounceIn 0.5s ease;
        }
        @keyframes bounceIn {
            0% { transform: scale(0); opacity: 0; }
            60% { transform: scale(1.1); }
            100% { transform: scale(1); opacity: 1; }
        }
        .password-wrapper {
            position: relative;
        }
        .toggle-pass {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #aaa;
            cursor: pointer;
            font-size: 1rem;
            padding: 0;
            transition: color 0.2s;
        }
        .toggle-pass:hover { color: #ff7eb3; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="recover-wrapper">
        <div class="recover-card">

            <div class="recover-icon">
                <i class="bi bi-shield-lock"></i>
            </div>
            <h1 class="recover-title">Recuperar Clave</h1>
            <p class="recover-subtitle">Te enviaremos una clave temporal a tu correo registrado</p>

            <div class="step-indicator">
                <div class="step-dot <%= paso == 1 ? "active" : "done" %>">1</div>
                <div class="step-line <%= paso > 1 ? "done" : "" %>"></div>
                <div class="step-dot <%= paso == 3 ? "active" : "inactive" %>"><i class="bi bi-check"></i></div>
            </div>

            <asp:Panel ID="pnlAlerta" runat="server" Visible="false">
                <div id="divAlerta" runat="server" class="alert alert-recover mb-3"></div>
            </asp:Panel>

            <asp:Panel ID="pnlPaso1" runat="server">
                <p class="text-muted small mb-3"><i class="bi bi-info-circle me-1" style="color:#ff7eb3;"></i> Ingresá tu correo electrónico registrado y te enviaremos una clave temporal.</p>
                <div class="mb-4">
                    <label class="form-label-custom">Correo electrónico</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control form-control-custom" TextMode="Email" placeholder="tucorreo@ejemplo.com" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                        ControlToValidate="txtEmail"
                        ErrorMessage="El correo es requerido."
                        CssClass="text-danger small"
                        ValidationGroup="vgPaso1"
                        Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server"
                        ControlToValidate="txtEmail"
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        ErrorMessage="Formato de correo inválido."
                        CssClass="text-danger small"
                        ValidationGroup="vgPaso1"
                        Display="Dynamic" />
                </div>
                <asp:Button ID="btnVerificar" runat="server" Text="Enviar clave temporal"
                    CssClass="btn btn-recover"
                    OnClick="btnVerificar_Click"
                    ValidationGroup="vgPaso1" />
                <a href="default.aspx" class="btn-back"><i class="bi bi-arrow-left me-1"></i>Volver al inicio</a>
            </asp:Panel>

            <asp:Panel ID="pnlExito" runat="server" Visible="false">
                <div class="text-center">
                    <i class="bi bi-envelope-check-fill success-checkmark"></i>
                    <h4 class="fw-bold" style="color:#4a4a4a;">Correo enviado</h4>
                    <p class="text-muted mb-4">Te enviamos una clave temporal a tu correo. Revisá tu bandeja de entrada (y la carpeta de spam), ingresá con esa clave y cambiala apenas puedas.</p>
                    <a href="default.aspx" class="btn btn-recover text-decoration-none">
                        <i class="bi bi-box-arrow-in-right me-2"></i>Ir al inicio de sesión
                    </a>
                </div>
            </asp:Panel>

        </div>
    </div>

    <script type="text/javascript">
        function togglePass(inputId, btn) {
            var input = document.getElementById(inputId) ||
                        document.querySelector("input[id$='" + inputId + "']");
            if (!input) return;
            var icon = btn.querySelector('i');
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
            }
        }
    </script>
</asp:Content>
