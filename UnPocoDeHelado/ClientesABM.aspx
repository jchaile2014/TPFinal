<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClientesABM.aspx.cs" Inherits="UnPocoDeHelado.ClientesABM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="container mt-5">
        <div class="row"><div class="col-md-6 offset-md-3">
            <h2 id="titulo" runat="server" class="fw-bold" style="background: linear-gradient(45deg, #ff9a9e 0%, #ff7eb3 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Nuevo Cliente</h2>
            <hr style="border-color: #fecfef; border-width: 2px;" />
            <div class="mb-3"><label class="form-label">Nombre</label>
                <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre" CssClass="text-danger" Display="Dynamic" ErrorMessage="El nombre es obligatorio." /></div>
            <div class="mb-3"><label class="form-label">Apellido</label>
                <asp:TextBox ID="txtApellido" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtApellido" CssClass="text-danger" Display="Dynamic" ErrorMessage="El apellido es obligatorio." /></div>
            <div class="mb-3"><label class="form-label">DNI</label>
                <asp:TextBox ID="txtDNI" CssClass="form-control" runat="server"></asp:TextBox></div>
            <div class="mb-3"><label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" CssClass="form-control" TextMode="Email" runat="server"></asp:TextBox></div>
            <div class="mb-3"><label class="form-label">Teléfono</label>
                <asp:TextBox ID="txtTelefono" CssClass="form-control" runat="server"></asp:TextBox></div>
            <div class="mb-3">
                <asp:Button ID="btnGuardar" CssClass="btn px-4 py-2 text-white fw-bold shadow-sm" style="background: linear-gradient(to right, #ff758c 0%, #ff7eb3 100%); border: none; border-radius: 12px;" Text="Guardar" runat="server" OnClick="btnGuardar_Click" />
                <asp:Button ID="btnCancelar" CssClass="btn btn-light fw-bold" style="border: 2px solid #ff7eb3; color: #ff7eb3; border-radius: 12px;" Text="Cancelar" runat="server" OnClick="btnCancelar_Click" CausesValidation="false" />
            </div>
        </div></div>
    </div>
</asp:Content>
