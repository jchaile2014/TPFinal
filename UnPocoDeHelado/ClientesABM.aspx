<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClientesABM.aspx.cs" Inherits="UnPocoDeHelado.ClientesABM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-8">

                <div class="form-card">
                    <div class="text-center mb-5">
                        <i class="bi bi-people" style="font-size: 3rem; color: #ff7eb3;"></i>
                        <h2 id="titulo" runat="server" class="form-title mt-2">Nuevo Cliente</h2>
                        <p class="text-muted">Completa los datos del cliente para registrarlo en el sistema</p>
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
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDNI" ValidationExpression="\d{7,8}" CssClass="text-danger" Display="Dynamic" ErrorMessage="El DNI debe tener 7 u 8 digitos." />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Telefono</label>
                            <asp:TextBox ID="txtTelefono" CssClass="form-control form-control-custom" placeholder="Ej. 11 12345678" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtTelefono" ValidationExpression="[\d\s\-]{6,20}" CssClass="text-danger" Display="Dynamic" ErrorMessage="Telefono invalido (solo numeros, espacios o guiones)." />
                        </div>

                        <div class="col-12">
                            <label class="form-label">Email</label>
                            <asp:TextBox ID="txtEmail" CssClass="form-control form-control-custom" TextMode="Email" placeholder="juan@ejemplo.com" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="text-danger" Display="Dynamic" ErrorMessage="Formato de email invalido." />
                        </div>
                    </div>

                    <hr class="my-5" style="border-color: #fecfef;" />

                    <div class="d-flex justify-content-end gap-3">
                        <asp:Button ID="btnCancelar" CssClass="btn btn-outline-custom" Text="Cancelar" runat="server" OnClick="btnCancelar_Click" CausesValidation="false" />
                        <asp:Button ID="btnGuardar" CssClass="btn btn-gradient shadow-sm" Text="Guardar Cambios" runat="server" OnClick="btnGuardar_Click" />
                    </div>

                </div>

            </div>
        </div>
    </div>
</asp:Content>
