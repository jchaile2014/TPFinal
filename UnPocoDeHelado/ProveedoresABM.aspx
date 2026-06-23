<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProveedoresABM.aspx.cs" Inherits="UnPocoDeHelado.ProveedoresABM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-8">

                <div class="form-card">
                    <div class="text-center mb-5">
                        <i class="bi bi-truck" style="font-size: 3rem; color: #ff7eb3;"></i>
                        <h2 id="titulo" runat="server" class="form-title mt-2">Nuevo Proveedor</h2>
                        <p class="text-muted">Completa los datos del proveedor para registrarlo en el sistema</p>
                    </div>

                    <div class="row g-4">
                        <div class="col-12">
                            <label class="form-label">Nombre</label>
                            <asp:TextBox ID="txtNombre" CssClass="form-control form-control-custom" placeholder="Nombre del proveedor" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre" CssClass="text-danger" Display="Dynamic" ErrorMessage="El nombre es obligatorio." />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">CUIT</label>
                            <asp:TextBox ID="txtCUIT" CssClass="form-control form-control-custom" placeholder="XX-XXXXXXXX-X" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCUIT" CssClass="text-danger" Display="Dynamic" ErrorMessage="El CUIT es obligatorio." />
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtCUIT" ValidationExpression="\d{2}-\d{8}-\d{1}" CssClass="text-danger" Display="Dynamic" ErrorMessage="Formato de CUIT inválido (XX-XXXXXXXX-X)." />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Telefono</label>
                            <asp:TextBox ID="txtTelefono" CssClass="form-control form-control-custom" placeholder="Ej. 11 12345678" runat="server"></asp:TextBox>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Email</label>
                            <asp:TextBox ID="txtEmail" CssClass="form-control form-control-custom" TextMode="Email" placeholder="proveedor@ejemplo.com" runat="server"></asp:TextBox>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Rubro</label>
                            <asp:TextBox ID="txtRubro" CssClass="form-control form-control-custom" placeholder="Ej. Lácteos" runat="server"></asp:TextBox>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Direccion</label>
                            <asp:TextBox ID="txtDireccion" CssClass="form-control form-control-custom" placeholder="Calle y numero" runat="server"></asp:TextBox>
                        </div>

                        <div class="col-12 mt-4">
                            <div class="form-check mb-1">
                                <asp:CheckBox ID="chkActivo" CssClass="form-check-input" runat="server" Checked="true" />
                                <label class="form-check-label fw-bold text-secondary" style="font-size: 1rem; cursor: pointer;">Proveedor Activo</label>
                            </div>
                            <small class="text-muted d-block">Si se desactiva, el proveedor no figurara en listados operativos.</small>
                        </div>
                    </div>

                    <hr class="my-5" style="border-color: #fecfef;" />

                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <asp:Button ID="btnEliminar" CssClass="btn btn-danger-custom shadow-sm" Text="Inactivar" runat="server" OnClick="btnEliminar_Click" Visible="false" CausesValidation="false" OnClientClick="return confirm('¿Estás seguro de inactivar este proveedor?');" />
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
