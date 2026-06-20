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
            <p class="recover-subtitle">Vamos a verificar tu identidad para restablecer tu clave</p>

            <div class="step-indicator">
                <div class="step-dot <%= paso == 1 ? "active" : "done" %>" id="dotPaso1">1</div>
                <div class="step-line <%= paso > 1 ? "done" : "" %>"></div>
                <div class="step-dot <%= paso == 2 ? "active" : (paso > 2 ? "done" : "inactive") %>" id="dotPaso2">2</div>
                <div class="step-line <%= paso > 2 ? "done" : "" %>"></div>
                <div class="step-dot <%= paso == 3 ? "active" : "inactive" %>" id="dotPaso3"><i class="bi bi-check"></i></div>
            </div>

            <asp:Panel ID="pnlAlerta" runat="server" Visible="false">
                <div id="divAlerta" runat="server" class="alert alert-recover mb-3"></div>
            </asp:Panel>

            <asp:Panel ID="pnlPaso1" runat="server">
                <p class="text-muted small mb-3"><i class="bi bi-info-circle me-1" style="color:#ff7eb3;"></i> Ingresa tu nombre de usuario y DNI para confirmar tu identidad.</p>
                <div class="mb-3">
                    <label class="form-label-custom">Nombre de usuario</label>
                    <asp:TextBox ID="txtUsuarioPaso1" runat="server" CssClass="form-control form-control-custom" placeholder="Ej. jgarcia" />
                    <asp:RequiredFieldValidator ID="rfvUsuario" runat="server"
                        ControlToValidate="txtUsuarioPaso1"
                        ErrorMessage="El nombre de usuario es requerido."
                        CssClass="text-danger small"
                        ValidationGroup="vgPaso1"
                        Display="Dynamic" />
                </div>
                <div class="mb-4">
                    <label class="form-label-custom">DNI</label>
                    <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control form-control-custom" placeholder="Ej. 12345678" MaxLength="10" />
                    <asp:RequiredFieldValidator ID="rfvDNI" runat="server"
                        ControlToValidate="txtDNI"
                        ErrorMessage="El DNI es requerido."
                        CssClass="text-danger small"
                        ValidationGroup="vgPaso1"
                        Display="Dynamic" />
                </div>
                <asp:Button ID="btnVerificar" runat="server" Text="Verificar identidad"
                    CssClass="btn btn-recover"
                    OnClick="btnVerificar_Click"
                    ValidationGroup="vgPaso1" />
                <a href="default.aspx" class="btn-back"><i class="bi bi-arrow-left me-1"></i>Volver al inicio</a>
            </asp:Panel>

            <asp:Panel ID="pnlPaso2" runat="server" Visible="false">
                <p class="text-muted small mb-3"><i class="bi bi-check-circle me-1" style="color:#28a745;"></i> Identidad verificada. Ahora podes establecer tu nueva clave.</p>
                <div class="mb-3">
                    <label class="form-label-custom">Nueva clave</label>
                    <div class="password-wrapper">
                        <asp:TextBox ID="txtNuevaPass" runat="server" CssClass="form-control form-control-custom" TextMode="Password" placeholder="Minimo 6 caracteres" style="padding-right: 2.5rem;" />
                        <button type="button" class="toggle-pass" onclick="togglePass('txtNuevaPass', this)">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvNuevaPass" runat="server"
                        ControlToValidate="txtNuevaPass"
                        ErrorMessage="La nueva clave es requerida."
                        CssClass="text-danger small"
                        ValidationGroup="vgPaso2"
                        Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revNuevaPass" runat="server"
                        ControlToValidate="txtNuevaPass"
                        ValidationExpression=".{6,}"
                        ErrorMessage="La clave debe tener al menos 6 caracteres."
                        CssClass="text-danger small"
                        ValidationGroup="vgPaso2"
                        Display="Dynamic" />
                </div>
                <div class="mb-4">
                    <label class="form-label-custom">Confirmar clave</label>
                    <div class="password-wrapper">
                        <asp:TextBox ID="txtConfirmarPass" runat="server" CssClass="form-control form-control-custom" TextMode="Password" placeholder="Repeti la clave" style="padding-right: 2.5rem;" />
                        <button type="button" class="toggle-pass" onclick="togglePass('txtConfirmarPass', this)">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvConfirmar" runat="server"
                        ControlToValidate="txtConfirmarPass"
                        ErrorMessage="Por favor confirma la clave."
                        CssClass="text-danger small"
                        ValidationGroup="vgPaso2"
                        Display="Dynamic" />
                    <asp:CompareValidator ID="cvPasswords" runat="server"
                        ControlToValidate="txtConfirmarPass"
                        ControlToCompare="txtNuevaPass"
                        ErrorMessage="Las claves no coinciden."
                        CssClass="text-danger small"
                        ValidationGroup="vgPaso2"
                        Display="Dynamic" />
                </div>
                <asp:Button ID="btnCambiarPass" runat="server" Text="Guardar nueva clave"
                    CssClass="btn btn-recover"
                    OnClick="btnCambiarPass_Click"
                    ValidationGroup="vgPaso2" />
                <asp:LinkButton ID="btnVolverPaso1" runat="server"
                    CssClass="btn-back"
                    OnClick="btnVolverPaso1_Click"
                    CausesValidation="false"><i class="bi bi-arrow-left me-1"></i>Volver</asp:LinkButton>
            </asp:Panel>

            <asp:Panel ID="pnlExito" runat="server" Visible="false">
                <div class="text-center">
                    <i class="bi bi-check-circle-fill success-checkmark"></i>
                    <h4 class="fw-bold" style="color:#4a4a4a;">Clave actualizada</h4>
                    <p class="text-muted mb-4">Tu clave fue cambiada exitosamente. Ya podes iniciar sesion con tu nueva clave.</p>
                    <a href="default.aspx" class="btn btn-recover text-decoration-none">
                        <i class="bi bi-box-arrow-in-right me-2"></i>Ir al inicio de sesion
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
