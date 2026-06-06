<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Operaciones.aspx.cs" Inherits="UnPocoDeHelado.Operaciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row"><div class="col-12"><h2>Operaciones (Ventas / Compras)</h2><hr /></div></div>
        <div class="row mb-3"><div class="col-12">
            <asp:Button ID="btnNuevaVenta" CssClass="btn btn-success" Text="Nueva Venta" runat="server" OnClick="btnNuevaVenta_Click" />
            <asp:Button ID="btnNuevaCompra" CssClass="btn btn-primary" Text="Nueva Compra" runat="server" OnClick="btnNuevaCompra_Click" />
        </div></div>
        <div class="row"><div class="col-12">
            <asp:GridView ID="dgvOperaciones" CssClass="table table-striped" runat="server"
                AllowPaging="true" PageSize="10" AutoGenerateColumns="false" DataKeyNames="Id"
                OnPageIndexChanging="dgvOperaciones_PageIndexChanging"
                OnSelectedIndexChanged="dgvOperaciones_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" />
                    <asp:CheckBoxField DataField="SeOpera" HeaderText="Es Venta" />
                    <asp:BoundField DataField="NumeroFactura" HeaderText="Factura" />
                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="Estado" HeaderText="Estado" />
                    <asp:CommandField ShowSelectButton="true" SelectText="Ver" />
                </Columns>
            </asp:GridView>
        </div></div>
    </div>
</asp:Content>
