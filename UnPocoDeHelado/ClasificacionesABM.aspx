<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClasificacionesABM.aspx.cs" Inherits="UnPocoDeHelado.ClasificacionesABM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <h2 id="titulo" runat="server">Nueva Clasificación</h2>
                <hr />
                <div class="mb-3">
                    <label class="form-label">Nombre</label>
                    <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label class="form-label">Tipo</label>
                    <asp:DropDownList ID="ddlTipo" CssClass="form-select" runat="server">
                        <asp:ListItem Value="True">Marca</asp:ListItem>
                        <asp:ListItem Value="False">Categoría</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="mb-3 form-check">
                    <asp:CheckBox ID="chkActivo" CssClass="form-check-input" Text="Activo" runat="server" Checked="true" />
                </div>
                <div class="mb-3">
                    <asp:Button ID="btnGuardar" CssClass="btn btn-primary" Text="Guardar" runat="server" OnClick="btnGuardar_Click" />
                    <asp:Button ID="btnEliminar" CssClass="btn btn-danger" Text="Eliminar" runat="server" OnClick="btnEliminar_Click" Visible="false" />
                    <asp:Button ID="btnCancelar" CssClass="btn btn-secondary" Text="Cancelar" runat="server" OnClick="btnCancelar_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
