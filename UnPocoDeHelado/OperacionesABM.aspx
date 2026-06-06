<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OperacionesABM.aspx.cs" Inherits="UnPocoDeHelado.OperacionesABM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row"><div class="col-md-8 offset-md-2">
            <h2 id="titulo" runat="server">Nueva Operación</h2><hr />
            <div class="mb-3"><label class="form-label">Tipo</label>
                <asp:DropDownList ID="ddlTipo" CssClass="form-select" runat="server">
                    <asp:ListItem Value="True">Venta</asp:ListItem>
                    <asp:ListItem Value="False">Compra</asp:ListItem>
                </asp:DropDownList></div>
            <div class="mb-3"><label class="form-label">Cliente</label>
                <asp:DropDownList ID="ddlCliente" CssClass="form-select" runat="server"></asp:DropDownList></div>
            <div class="mb-3"><label class="form-label">Proveedor</label>
                <asp:DropDownList ID="ddlProveedor" CssClass="form-select" runat="server"></asp:DropDownList></div>
            <div class="mb-3"><label class="form-label">Medio de Pago</label>
                <asp:DropDownList ID="ddlMedioPago" CssClass="form-select" runat="server"></asp:DropDownList></div>
            <div class="mb-3"><label class="form-label">Fecha</label>
                <asp:TextBox ID="txtFecha" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox></div>
            <h5>Detalle</h5>
            <div class="row g-2 mb-2">
                <div class="col"><asp:DropDownList ID="ddlProducto" CssClass="form-select" runat="server"></asp:DropDownList></div>
                <div class="col"><asp:TextBox ID="txtCantidad" CssClass="form-control" TextMode="Number" placeholder="Cantidad" runat="server"></asp:TextBox></div>
                <div class="col-auto"><asp:Button ID="btnAgregarDetalle" CssClass="btn btn-outline-secondary" Text="Agregar" runat="server" OnClick="btnAgregarDetalle_Click" /></div>
            </div>
            <asp:GridView ID="dgvDetalle" CssClass="table table-sm" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="Producto" HeaderText="Producto" />
                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                    <asp:BoundField DataField="PrecioUnitario" HeaderText="P. Unit." DataFormatString="{0:C}" />
                    <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C}" />
                </Columns>
            </asp:GridView>
            <div class="mb-3"><label class="form-label">Total</label>
                <asp:TextBox ID="txtTotal" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox></div>
            <div class="mb-3">
                <asp:Button ID="btnGuardar" CssClass="btn btn-primary" Text="Confirmar" runat="server" OnClick="btnGuardar_Click" />
                <asp:Button ID="btnCancelar" CssClass="btn btn-secondary" Text="Cancelar" runat="server" OnClick="btnCancelar_Click" />
            </div>
        </div></div>
    </div>
</asp:Content>
