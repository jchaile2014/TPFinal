<%@ Page Title="Balances" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Balances.aspx.cs" Inherits="UnPocoDeHelado.Balances" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row mb-4 align-items-center">
            <div class="col-md-8">
                <h2 class="fw-bold" style="background: linear-gradient(45deg, #ff9a9e 0%, #ff7eb3 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                    <i class="bi bi-graph-up-arrow me-2" style="color: #ff7eb3;"></i>Balances y Reportes
                </h2>
                <p class="text-muted mb-0">Indicadores de tu sucursal</p>
            </div>
        </div>
        <hr class="mb-4" style="border-color: #fecfef; border-width: 2px;" />

        <div class="card shadow-sm border-0 rounded-4 p-4 mb-5">
            <h5 class="fw-bold mb-3" style="color: #ff758c;"><i class="bi bi-calendar-range me-2"></i>Ventas por periodo</h5>
            <div class="row g-3 align-items-end">
                <div class="col-md-3">
                    <label class="form-label">Desde</label>
                    <asp:TextBox ID="txtDesde" runat="server" TextMode="Date" CssClass="form-control" style="border-radius: 12px;" />
                </div>
                <div class="col-md-3">
                    <label class="form-label">Hasta</label>
                    <asp:TextBox ID="txtHasta" runat="server" TextMode="Date" CssClass="form-control" style="border-radius: 12px;" />
                </div>
                <div class="col-md-3">
                    <asp:Button ID="btnConsultar" runat="server" Text="Consultar" OnClick="btnConsultar_Click" CssClass="btn px-4 py-2 text-white fw-bold shadow-sm w-100" style="background: linear-gradient(to right, #ff758c 0%, #ff7eb3 100%); border: none; border-radius: 12px;" />
                </div>
                <div class="col-md-3 text-md-end">
                    <span class="text-muted d-block">Total cobrado</span>
                    <h4 class="fw-bold mb-0" style="color: #ff758c;"><asp:Label ID="lblTotalVentas" runat="server">$0,00</asp:Label></h4>
                </div>
            </div>
            <hr class="my-4" style="border-color: #fecfef;" />
            <h6 class="fw-bold mb-3" style="color: #ff758c;"><i class="bi bi-list-ul me-2"></i>Detalle de articulos vendidos</h6>
            <asp:GridView ID="dgvDetalleVentas" runat="server" CssClass="table table-striped align-middle" AutoGenerateColumns="false" GridLines="None" EmptyDataText="No hubo ventas cobradas en el periodo seleccionado.">
                <Columns>
                    <asp:BoundField DataField="Producto" HeaderText="Producto" />
                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad vendida" />
                    <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" />
                </Columns>
            </asp:GridView>
        </div>

        <div class="card shadow-sm border-0 rounded-4 p-4 mb-5">
            <h5 class="fw-bold mb-3" style="color: #ff758c;"><i class="bi bi-exclamation-triangle me-2"></i>Stock critico</h5>
            <asp:GridView ID="dgvStockCritico" runat="server" CssClass="table table-striped align-middle" AutoGenerateColumns="false" GridLines="None" EmptyDataText="No hay productos por debajo del stock minimo.">
                <Columns>
                    <asp:BoundField DataField="Producto" HeaderText="Producto" />
                    <asp:BoundField DataField="Categoria" HeaderText="Categoria" />
                    <asp:BoundField DataField="StockActual" HeaderText="Stock" />
                    <asp:BoundField DataField="StockMinimo" HeaderText="Minimo" />
                    <asp:BoundField DataField="PrecioCompraActual" HeaderText="P. Compra" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="ProveedoresDisponibles" HeaderText="Proveedores" />
                </Columns>
            </asp:GridView>
        </div>

        <div class="card shadow-sm border-0 rounded-4 p-4 mb-5">
            <h5 class="fw-bold mb-3" style="color: #ff758c;"><i class="bi bi-trophy me-2"></i>Productos mas vendidos</h5>
            <asp:GridView ID="dgvTop" runat="server" CssClass="table table-striped align-middle" AutoGenerateColumns="false" GridLines="None" EmptyDataText="Todavia no hay ventas registradas.">
                <Columns>
                    <asp:BoundField DataField="Producto" HeaderText="Producto" />
                    <asp:BoundField DataField="Categoria" HeaderText="Categoria" />
                    <asp:BoundField DataField="Marca" HeaderText="Marca" />
                    <asp:BoundField DataField="UnidadesVendidas" HeaderText="Unidades" />
                    <asp:BoundField DataField="TotalFacturado" HeaderText="Facturado" DataFormatString="{0:C}" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
