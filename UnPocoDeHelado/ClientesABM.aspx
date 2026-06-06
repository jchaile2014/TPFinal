<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClientesABM.aspx.cs" Inherits="UnPocoDeHelado.ClientesABM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container mt-5">
        <div class="row"><div class="col-md-6 offset-md-3">
            <h2 id="titulo" runat="server">Nuevo Cliente</h2><hr />
            <div class="mb-3"><label class="form-label">Nombre</label>
                <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server"></asp:TextBox></div>
            <div class="mb-3"><label class="form-label">Apellido</label>
                <asp:TextBox ID="txtApellido" CssClass="form-control" runat="server"></asp:TextBox></div>
            <div class="mb-3"><label class="form-label">DNI</label>
                <asp:TextBox ID="txtDNI" CssClass="form-control" runat="server"></asp:TextBox></div>
            <div class="mb-3"><label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" CssClass="form-control" TextMode="Email" runat="server"></asp:TextBox></div>
            <div class="mb-3"><label class="form-label">Teléfono</label>
                <asp:TextBox ID="txtTelefono" CssClass="form-control" runat="server"></asp:TextBox></div>
            <div class="mb-3">
                <asp:Button ID="btnGuardar" CssClass="btn btn-primary" Text="Guardar" runat="server" OnClick="btnGuardar_Click" />
                <asp:Button ID="btnEliminar" CssClass="btn btn-danger" Text="Eliminar" runat="server" OnClick="btnEliminar_Click" Visible="false" />
                <asp:Button ID="btnCancelar" CssClass="btn btn-secondary" Text="Cancelar" runat="server" OnClick="btnCancelar_Click" />
            </div>
        </div></div>
    </div>
</asp:Content>
