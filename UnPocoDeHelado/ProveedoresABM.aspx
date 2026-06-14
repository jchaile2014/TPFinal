<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProveedoresABM.aspx.cs" Inherits="UnPocoDeHelado.ProveedoresABM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row"><div class="col-md-6 offset-md-3">
            <h2 id="titulo" runat="server" class="fw-bold" style="background: linear-gradient(45deg, #ff9a9e 0%, #ff7eb3 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Nuevo Proveedor</h2>
            <hr style="border-color: #fecfef; border-width: 2px;" />
            <div class="mb-3"><label class="form-label">Nombre</label>
                <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre" CssClass="text-danger" Display="Dynamic" ErrorMessage="El nombre es obligatorio." /></div>
            <div class="mb-3"><label class="form-label">CUIT</label>
                <asp:TextBox ID="txtCUIT" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCUIT" CssClass="text-danger" Display="Dynamic" ErrorMessage="El CUIT es obligatorio." />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtCUIT" ValidationExpression="\d{2}-\d{8}-\d{1}" CssClass="text-danger" Display="Dynamic" ErrorMessage="Formato de CUIT inválido (XX-XXXXXXXX-X)." /></div>
            <div class="mb-3"><label class="form-label">Teléfono</label>
                <asp:TextBox ID="txtTelefono" CssClass="form-control" runat="server"></asp:TextBox></div>
            <div class="mb-3"><label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" CssClass="form-control" TextMode="Email" runat="server"></asp:TextBox></div>
            <div class="mb-3"><label class="form-label">Dirección</label>
                <asp:TextBox ID="txtDireccion" CssClass="form-control" runat="server"></asp:TextBox></div>
            <div class="mb-3"><label class="form-label">Rubro</label>
                <asp:TextBox ID="txtRubro" CssClass="form-control" runat="server"></asp:TextBox></div>
            <div class="mb-3 form-check">
                <asp:CheckBox ID="chkActivo" CssClass="form-check-input" Text="Activo" runat="server" Checked="true" />
            </div>
            <div class="mb-3">
                <asp:Button ID="btnGuardar" CssClass="btn px-4 py-2 text-white fw-bold shadow-sm" style="background: linear-gradient(to right, #ff758c 0%, #ff7eb3 100%); border: none; border-radius: 12px;" Text="Guardar" runat="server" OnClick="btnGuardar_Click" />
                <asp:Button ID="btnEliminar" CssClass="btn btn-danger fw-bold" style="border-radius: 12px;" Text="Inactivar" runat="server" OnClick="btnEliminar_Click" Visible="false" CausesValidation="false" />
                <asp:Button ID="btnCancelar" CssClass="btn btn-light fw-bold" style="border: 2px solid #ff7eb3; color: #ff7eb3; border-radius: 12px;" Text="Cancelar" runat="server" OnClick="btnCancelar_Click" CausesValidation="false" />
            </div>
        </div></div>
    </div>
</asp:Content>
