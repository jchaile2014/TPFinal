<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductosABM.aspx.cs" Inherits="UnPocoDeHelado.ProductosABM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row"><div class="col-md-6 offset-md-3">
            <h2 id="titulo" runat="server" class="fw-bold" style="background: linear-gradient(45deg, #ff9a9e 0%, #ff7eb3 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Nuevo Producto</h2>
            <hr style="border-color: #fecfef; border-width: 2px;" />
            <div class="mb-3"><label class="form-label">Nombre</label>
                <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre" CssClass="text-danger" Display="Dynamic" ErrorMessage="El nombre es obligatorio." /></div>
            <div class="mb-3"><label class="form-label">Descripción</label>
                <asp:TextBox ID="txtDescripcion" CssClass="form-control" TextMode="MultiLine" Rows="3" runat="server"></asp:TextBox></div>
            <div class="mb-3"><label class="form-label">Marca</label>
                <asp:DropDownList ID="ddlMarca" CssClass="form-select" runat="server"></asp:DropDownList></div>
            <div class="mb-3"><label class="form-label">Categoría</label>
                <asp:DropDownList ID="ddlCategoria" CssClass="form-select" runat="server"></asp:DropDownList></div>
            <div class="mb-3"><label class="form-label">Cantidad (stock)</label>
                <asp:TextBox ID="txtCantidad" CssClass="form-control" TextMode="Number" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCantidad" CssClass="text-danger" Display="Dynamic" ErrorMessage="La cantidad es obligatoria." />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtCantidad" ValidationExpression="\d+" CssClass="text-danger" Display="Dynamic" ErrorMessage="La cantidad debe ser un numero entero." /></div>
            <div class="mb-3"><label class="form-label">Stock mínimo</label>
                <asp:TextBox ID="txtStockMinimo" CssClass="form-control" TextMode="Number" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStockMinimo" CssClass="text-danger" Display="Dynamic" ErrorMessage="El stock mínimo es obligatorio." />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtStockMinimo" ValidationExpression="\d+" CssClass="text-danger" Display="Dynamic" ErrorMessage="El stock mínimo debe ser un numero entero." /></div>
            <div class="mb-3"><label class="form-label">% Ganancia</label>
                <asp:TextBox ID="txtPorcentaje" CssClass="form-control" TextMode="Number" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPorcentaje" CssClass="text-danger" Display="Dynamic" ErrorMessage="El % de ganancia es obligatorio." />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPorcentaje" ValidationExpression="\d+([.,]\d{1,2})?" CssClass="text-danger" Display="Dynamic" ErrorMessage="El % de ganancia debe ser un numero válido." /></div>
            <div class="mb-3"><label class="form-label">Precio compra</label>
                <asp:TextBox ID="txtPrecioCompra" CssClass="form-control" TextMode="Number" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPrecioCompra" CssClass="text-danger" Display="Dynamic" ErrorMessage="El precio de compra es obligatorio." />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPrecioCompra" ValidationExpression="\d+([.,]\d{1,2})?" CssClass="text-danger" Display="Dynamic" ErrorMessage="El precio de compra debe ser un numero valido." /></div>
            <div class="mb-3"><label class="form-label">Id Sucursal</label>
                <asp:TextBox ID="txtIdSucursal" CssClass="form-control" TextMode="Number" runat="server" ReadOnly="true"></asp:TextBox></div>
            <div class="mb-3 form-check">
                <asp:CheckBox ID="chkActivo" CssClass="form-check-input" Text="Activo" runat="server" Checked="true" /></div>
            <div class="mb-3">
                <asp:Button ID="btnGuardar" CssClass="btn px-4 py-2 text-white fw-bold shadow-sm" style="background: linear-gradient(to right, #ff758c 0%, #ff7eb3 100%); border: none; border-radius: 12px;" Text="Guardar" runat="server" OnClick="btnGuardar_Click" />
                <asp:Button ID="btnEliminar" CssClass="btn btn-danger fw-bold" style="border-radius: 12px;" Text="Inactivar" runat="server" OnClick="btnEliminar_Click" Visible="false" CausesValidation="false" />
                <asp:Button ID="btnCancelar" CssClass="btn btn-light fw-bold" style="border: 2px solid #ff7eb3; color: #ff7eb3; border-radius: 12px;" Text="Cancelar" runat="server" OnClick="btnCancelar_Click" CausesValidation="false" />
            </div>
        </div></div>
    </div>
</asp:Content>
