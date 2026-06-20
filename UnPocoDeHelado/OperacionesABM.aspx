<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OperacionesABM.aspx.cs" Inherits="UnPocoDeHelado.OperacionesABM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row mb-3">
            <div class="col-12">
                <h2 id="titulo" runat="server" class="fw-bold" style="background: linear-gradient(45deg, #ff9a9e 0%, #ff7eb3 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Operacion</h2>
                <hr style="border-color: #fecfef; border-width: 2px;" />
            </div>
        </div>

        <asp:Panel ID="pnlCarga" runat="server">
            <div class="row g-3 mb-3">
                <asp:Panel ID="pnlProveedor" runat="server" CssClass="col-md-4">
                    <label class="form-label">Proveedor</label>
                    <asp:DropDownList ID="ddlProveedor" CssClass="form-select" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlProveedor_SelectedIndexChanged"></asp:DropDownList>
                </asp:Panel>
                <asp:Panel ID="pnlCliente" runat="server" CssClass="col-md-4">
                    <label class="form-label">Cliente</label>
                    <asp:DropDownList ID="ddlCliente" CssClass="form-select" runat="server"></asp:DropDownList>
                </asp:Panel>
                <div class="col-md-4">
                    <label class="form-label">Producto</label>
                    <asp:DropDownList ID="ddlProducto" CssClass="form-select" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Stock actual</label>
                    <asp:TextBox ID="txtStock" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                </div>
            </div>
            <div class="row g-3 mb-2 align-items-end">
                <div class="col-md-3">
                    <label class="form-label">Cantidad</label>
                    <asp:TextBox ID="txtCantidad" CssClass="form-control" TextMode="Number" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Precio</label>
                    <asp:TextBox ID="txtPrecioUnit" CssClass="form-control" TextMode="Number" runat="server"></asp:TextBox>
                </div>
                <asp:Panel ID="pnlMedioPago" runat="server" CssClass="col-md-3">
                    <label class="form-label">Medio de pago</label>
                    <asp:DropDownList ID="ddlMedioPago" CssClass="form-select" runat="server"></asp:DropDownList>
                </asp:Panel>
                <div class="col-md-3">
                    <asp:Button ID="btnAgregarDetalle" CssClass="btn w-100 fw-bold" style="background-color: white; border: 2px solid #ff7eb3; color: #ff7eb3; border-radius: 12px;" Text="Agregar al detalle" runat="server" OnClick="btnAgregarDetalle_Click" />
                </div>
            </div>
            <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger fw-bold"></asp:Label>
        </asp:Panel>

        <asp:GridView ID="dgvDetalle" CssClass="table table-striped align-middle mt-3" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:TemplateField HeaderText="Producto"><ItemTemplate><%# Eval("Producto.Nombre") %></ItemTemplate></asp:TemplateField>
                <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                <asp:BoundField DataField="PrecioUnitario" HeaderText="P. Unit." DataFormatString="{0:C}" />
                <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C}" />
            </Columns>
        </asp:GridView>

        <div class="row mb-3">
            <div class="col-12 text-end">
                <h4 class="fw-bold" style="color: #ff758c;">Total: <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label></h4>
            </div>
        </div>

        <div class="mb-5">
            <asp:Button ID="btnGuardar" CssClass="btn px-4 py-2 text-white fw-bold shadow-sm" style="background: linear-gradient(to right, #ff758c 0%, #ff7eb3 100%); border: none; border-radius: 12px;" Text="Confirmar" runat="server" OnClick="btnGuardar_Click" />
            <asp:Button ID="btnCancelar" CssClass="btn btn-light fw-bold" style="border: 2px solid #ff7eb3; color: #ff7eb3; border-radius: 12px;" Text="Cancelar" runat="server" OnClick="btnCancelar_Click" CausesValidation="false" />
        </div>
    </div>
</asp:Content>
