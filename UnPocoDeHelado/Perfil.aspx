<%@ Page Title="Mi Perfil" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="UnPocoDeHelado.Perfil" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .perfil-dato { margin-bottom: 1.1rem; }
        .perfil-dato .etiqueta { font-size: 0.78rem; font-weight: 700; color: #aaa; text-transform: uppercase; letter-spacing: 0.04em; }
        .perfil-dato .valor { font-size: 1rem; font-weight: 600; color: #444; }
        .perfil-avatar {
            width: 90px; height: 90px; border-radius: 50%;
            background: linear-gradient(135deg, #ff758c, #ff7eb3);
            display: flex; align-items: center; justify-content: center;
            font-size: 2.6rem; color: white; margin: 0 auto 1rem;
            box-shadow: 0 8px 20px rgba(255,117,140,0.35);
        }
        .password-wrapper { position: relative; }
        .toggle-pass {
            position: absolute; right: 12px; top: 50%; transform: translateY(-50%);
            background: none; border: none; color: #aaa; cursor: pointer; font-size: 1rem; padding: 0;
            transition: color 0.2s;
        }
        .toggle-pass:hover { color: #ff7eb3; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">

        <div class="page-hero d-flex align-items-center gap-3 flex-wrap mb-4">
            <div class="d-flex align-items-center gap-3" style="z-index:1; position:relative;">
                <i class="bi bi-person-circle page-hero-icon"></i>
                <div>
                    <h2 class="page-hero-title">Mi Perfil</h2>
                    <p class="page-hero-sub">Tus datos y seguridad de la cuenta</p>
                </div>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-9">

                <div class="form-card">
                    <div class="perfil-avatar"><i class="bi bi-person-fill"></i></div>
                    <h4 class="form-title text-center mb-4">Mis datos</h4>

                    <div class="row mb-2">
                        <div class="col-md-6 perfil-dato">
                            <div class="etiqueta">Rol</div>
                            <div class="valor"><asp:Label ID="lblRol" runat="server" /></div>
                        </div>
                    </div>

                    <hr class="my-4" style="border-color: #fecfef;" />

                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label">Nombre de usuario</label>
                            <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control form-control-custom" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsuario" ValidationGroup="vgDatos"
                                ErrorMessage="El usuario es obligatorio." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">DNI</label>
                            <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control form-control-custom" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDNI" ValidationGroup="vgDatos"
                                ErrorMessage="El DNI es obligatorio." CssClass="text-danger small" Display="Dynamic" />
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDNI" ValidationGroup="vgDatos"
                                ValidationExpression="\d{7,8}" ErrorMessage="El DNI debe tener 7 u 8 dígitos." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Nombre</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control form-control-custom" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre" ValidationGroup="vgDatos"
                                ErrorMessage="El nombre es obligatorio." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Apellido</label>
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control form-control-custom" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtApellido" ValidationGroup="vgDatos"
                                ErrorMessage="El apellido es obligatorio." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Correo electrónico</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control form-control-custom" TextMode="Email" placeholder="tucorreo@ejemplo.com" />
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ValidationGroup="vgDatos"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                ErrorMessage="Formato de correo inválido." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Teléfono</label>
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control form-control-custom" placeholder="Ej. 11 12345678" />
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtTelefono" ValidationGroup="vgDatos"
                                ValidationExpression="[\d\s\-]{6,20}"
                                ErrorMessage="Teléfono inválido (solo números, espacios o guiones)." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mt-4">
                        <asp:Label ID="lblMsgDatos" runat="server" CssClass="fw-semibold" />
                        <asp:Button ID="btnGuardarDatos" runat="server" Text="Guardar cambios" CssClass="btn btn-gradient shadow-sm"
                            OnClick="btnGuardarDatos_Click" ValidationGroup="vgDatos" />
                    </div>
                </div>

                <div class="form-card">
                    <h4 class="form-title mb-4"><i class="bi bi-shield-lock me-2"></i>Cambiar contraseña</h4>
                    <div class="row g-4">
                        <div class="col-md-4">
                            <label class="form-label">Clave actual</label>
                            <div class="password-wrapper">
                                <asp:TextBox ID="txtClaveActual" runat="server" CssClass="form-control form-control-custom" TextMode="Password" style="padding-right:2.5rem;" />
                                <button type="button" class="toggle-pass" onclick="togglePass('txtClaveActual', this)"><i class="bi bi-eye"></i></button>
                            </div>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtClaveActual" ValidationGroup="vgClave"
                                ErrorMessage="Ingresá tu clave actual." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Nueva clave</label>
                            <div class="password-wrapper">
                                <asp:TextBox ID="txtNuevaClave" runat="server" CssClass="form-control form-control-custom" TextMode="Password" placeholder="Mínimo 6 caracteres" style="padding-right:2.5rem;" />
                                <button type="button" class="toggle-pass" onclick="togglePass('txtNuevaClave', this)"><i class="bi bi-eye"></i></button>
                            </div>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNuevaClave" ValidationGroup="vgClave"
                                ErrorMessage="La nueva clave es requerida." CssClass="text-danger small" Display="Dynamic" />
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtNuevaClave" ValidationGroup="vgClave"
                                ValidationExpression=".{6,}" ErrorMessage="Debe tener al menos 6 caracteres." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Confirmar clave</label>
                            <div class="password-wrapper">
                                <asp:TextBox ID="txtConfirmarClave" runat="server" CssClass="form-control form-control-custom" TextMode="Password" style="padding-right:2.5rem;" />
                                <button type="button" class="toggle-pass" onclick="togglePass('txtConfirmarClave', this)"><i class="bi bi-eye"></i></button>
                            </div>
                            <asp:CompareValidator runat="server" ControlToValidate="txtConfirmarClave" ControlToCompare="txtNuevaClave"
                                ValidationGroup="vgClave" ErrorMessage="Las claves no coinciden." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mt-4">
                        <asp:Label ID="lblMsgClave" runat="server" CssClass="fw-semibold" />
                        <asp:Button ID="btnCambiarClave" runat="server" Text="Cambiar contraseña" CssClass="btn btn-gradient shadow-sm"
                            OnClick="btnCambiarClave_Click" ValidationGroup="vgClave" />
                    </div>
                </div>

            </div>
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
