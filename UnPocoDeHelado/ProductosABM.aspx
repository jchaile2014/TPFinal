<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductosABM.aspx.cs" Inherits="UnPocoDeHelado.ProductosABM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <h2 id="titulo" runat="server">Nuevo Producto</h2>
                <hr />

                <div class="mb-3">
                    <label class="form-label">Nombre</label>
                    <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label">Categoría</label>
                    <asp:DropDownList ID="ddlCategoria" CssClass="form-select" runat="server"></asp:DropDownList>
                </div>

                <div class="mb-3">
                    <label class="form-label">Marca</label>
                    <asp:TextBox ID="txtMarca" CssClass="form-control" runat="server"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label">Precio Venta</label>
                    <asp:TextBox ID="txtPrecioVenta" CssClass="form-control" TextMode="Number" runat="server"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label">Descripción</label>
                    <asp:TextBox ID="txtDescripcion" CssClass="form-control" TextMode="MultiLine" Rows="3" runat="server"></asp:TextBox>
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
