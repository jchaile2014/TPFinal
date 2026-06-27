<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmpleadosABM.aspx.cs" Inherits="UnPocoDeHelado.EmpleadosABM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-8">
                
                <div class="form-card">
                    <div class="text-center mb-5">
                        <i class="bi bi-person-badge" style="font-size: 3rem; color: #ff7eb3;"></i>
                        <h2 id="titulo" runat="server" class="form-title mt-2">Nuevo Empleado</h2>
                        <p class="text-muted">Completa los datos del empleado para registrarlo en el sistema</p>
                    </div>

                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label">Nombre</label>
                            <asp:TextBox ID="txtNombre" CssClass="form-control form-control-custom" placeholder="Ej. Juan" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre" CssClass="text-danger" Display="Dynamic" ErrorMessage="El nombre es obligatorio." />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Apellido</label>
                            <asp:TextBox ID="txtApellido" CssClass="form-control form-control-custom" placeholder="Ej. Perez" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtApellido" CssClass="text-danger" Display="Dynamic" ErrorMessage="El apellido es obligatorio." />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">DNI</label>
                            <asp:TextBox ID="txtDNI" CssClass="form-control form-control-custom" placeholder="Sin puntos ni espacios" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDNI" CssClass="text-danger" Display="Dynamic" ErrorMessage="El DNI es obligatorio." />
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDNI" ValidationExpression="\d{7,8}" CssClass="text-danger" Display="Dynamic" ErrorMessage="El DNI debe tener 7 u 8 dígitos." />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Teléfono</label>
                            <asp:TextBox ID="txtTelefono" CssClass="form-control form-control-custom" placeholder="Ej. 11 12345678" runat="server"></asp:TextBox>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Correo Electrónico</label>
                            <asp:TextBox ID="txtEmail" CssClass="form-control form-control-custom" TextMode="Email" placeholder="juan@ejemplo.com" runat="server"></asp:TextBox>
                        </div>

                        <asp:Panel ID="pnlUsuario" runat="server" CssClass="col-12">
                            <label class="form-label">Nombre de usuario</label>
                            <asp:TextBox ID="txtUsuario" CssClass="form-control form-control-custom" placeholder="Ej. jperez" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsuario" CssClass="text-danger" Display="Dynamic" ErrorMessage="El nombre de usuario es obligatorio." />
                            <small class="text-muted d-block"><i class="bi bi-envelope me-1"></i>Se le enviará una clave temporal al correo para que pueda ingresar. </small>
                        </asp:Panel>

                        <div class="col-md-6">
                            <label class="form-label">Rol</label>
                            <asp:DropDownList ID="ddlRol" CssClass="form-select form-select-custom" runat="server"></asp:DropDownList>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Fecha Ingreso</label>
                            <asp:TextBox ID="txtFechaIngreso" CssClass="form-control form-control-custom" TextMode="Date" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFechaIngreso" CssClass="text-danger" Display="Dynamic" ErrorMessage="La fecha de ingreso es obligatoria." />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Salario</label>
                            <div class="input-group">
                                <span class="input-group-text" style="border-radius: 10px 0 0 10px; border: 1px solid #e0e0e0; background-color: #fdfbfb;">$</span>
                                <asp:TextBox ID="txtSalario" CssClass="form-control form-control-custom" style="border-radius: 0 10px 10px 0;" TextMode="Number" placeholder="0.00" runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-12 mt-4">
                            <div class="form-check mb-1">
                                <asp:CheckBox ID="chkActivo" CssClass="form-check-input" runat="server" Checked="true" />
                                <label class="form-check-label fw-bold text-secondary" style="font-size: 1rem; cursor: pointer;">Empleado Activo</label>
                            </div>
                            <small class="text-muted d-block">Si se desactiva, el empleado no podrá ingresar al sistema ni figurará en listados operativos.</small>
                        </div>
                    </div>

                    <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger fw-semibold d-block mt-3" />

                    <hr class="my-5" style="border-color: #fecfef;" />

                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <asp:Button ID="btnEliminar" CssClass="btn btn-danger-custom shadow-sm" Text="Eliminar" runat="server" OnClick="btnEliminar_Click" Visible="false" CausesValidation="false" OnClientClick="return confirm('¿Estás seguro de eliminar este empleado?');" />
                        </div>
                        <div class="d-flex gap-3">
                            <asp:Button ID="btnCancelar" CssClass="btn btn-outline-custom" Text="Cancelar" runat="server" OnClick="btnCancelar_Click" CausesValidation="false" />
                            <asp:Button ID="btnGuardar" CssClass="btn btn-gradient shadow-sm" Text="Guardar Cambios" runat="server" OnClick="btnGuardar_Click" />
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>
</asp:Content>
