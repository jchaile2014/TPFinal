<%@ Page Title="Balances" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Balances.aspx.cs" Inherits="UnPocoDeHelado.Balances" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .balance-card {
            background: white;
            border-radius: 18px;
            border: none;
            box-shadow: 0 4px 20px rgba(0,0,0,0.07);
            padding: 1.75rem;
            margin-bottom: 1.75rem;
        }
        .balance-card-title {
            font-weight: 700;
            font-size: 1rem;
            color: #ff758c;
            margin-bottom: 1.2rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px dashed #fecfef;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .total-box {
            background: linear-gradient(135deg, #fff0f5, #fff);
            border-radius: 14px;
            padding: 1rem 1.5rem;
            border: 1.5px solid #fecfef;
            text-align: center;
        }
        .total-label { font-size: 0.8rem; font-weight: 700; color: #aaa; text-transform: uppercase; letter-spacing: 0.05em; }
        .total-value { font-size: 2rem; font-weight: 900; background: linear-gradient(45deg, #ff758c, #ff7eb3); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .table { font-size: 0.9rem; }
        .table thead th { background: #fff5f8; color: #c05070; font-weight: 700; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.04em; border: none; padding: 0.9rem 1rem; }
        .table tbody td { padding: 0.8rem 1rem; border-color: #fff0f5; vertical-align: middle; }
        .table tbody tr:hover td { background: #fff8fb; }
        .chart-box { position: relative; height: 300px; }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">

        <div class="page-hero d-flex align-items-center gap-3 flex-wrap">
            <div class="d-flex align-items-center gap-3" style="z-index:1; position:relative;">
                <i class="bi bi-graph-up-arrow page-hero-icon"></i>
                <div>
                    <h2 class="page-hero-title">Balances y Reportes</h2>
                    <p class="page-hero-sub">Indicadores de rendimiento de tu sucursal</p>
                </div>
            </div>
        </div>

        <div class="balance-card">
            <div class="balance-card-title">
                <i class="bi bi-calendar-range"></i> Ventas por período
            </div>
            <div class="row g-3 align-items-end">
                <div class="col-md-3">
                    <label class="form-label">Desde</label>
                    <asp:TextBox ID="txtDesde" runat="server" TextMode="Date" CssClass="form-control form-control-custom" />
                </div>
                <div class="col-md-3">
                    <label class="form-label">Hasta</label>
                    <asp:TextBox ID="txtHasta" runat="server" TextMode="Date" CssClass="form-control form-control-custom" />
                </div>
                <div class="col-md-3">
                    <asp:Button ID="btnConsultar" runat="server" Text="Consultar" OnClick="btnConsultar_Click"
                        CssClass="btn btn-gradient shadow-sm w-100" />
                </div>
                <div class="col-md-3">
                    <div class="total-box">
                        <div class="total-label">Total cobrado</div>
                        <div class="total-value"><asp:Label ID="lblTotalVentas" runat="server">$0,00</asp:Label></div>
                    </div>
                </div>
            </div>
            <hr class="my-4" style="border-color: #fecfef;" />
            <div class="balance-card-title">
                <i class="bi bi-list-ul"></i> Detalle de artículos vendidos
            </div>
            <asp:GridView ID="dgvDetalleVentas" runat="server" CssClass="table" AutoGenerateColumns="false"
                GridLines="None" EmptyDataText="No hubo ventas cobradas en el período seleccionado.">
                <Columns>
                    <asp:BoundField DataField="Producto" HeaderText="Producto" />
                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad vendida" />
                    <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" />
                </Columns>
            </asp:GridView>
            <div class="chart-box mt-4"><canvas id="chartDetalle"></canvas></div>
        </div>

        <div class="balance-card">
            <div class="balance-card-title">
                <i class="bi bi-exclamation-triangle"></i> Stock crítico
            </div>
            <asp:GridView ID="dgvStockCritico" runat="server" CssClass="table" AutoGenerateColumns="false"
                GridLines="None" EmptyDataText="No hay productos por debajo del stock mínimo.">
                <Columns>
                    <asp:BoundField DataField="Producto" HeaderText="Producto" />
                    <asp:BoundField DataField="Categoria" HeaderText="Categoría" />
                    <asp:BoundField DataField="StockActual" HeaderText="Stock actual" />
                    <asp:BoundField DataField="StockMinimo" HeaderText="Mínimo" />
                    <asp:BoundField DataField="PrecioCompraActual" HeaderText="P. Compra" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="ProveedoresDisponibles" HeaderText="Proveedores" />
                </Columns>
            </asp:GridView>
        </div>

        <div class="balance-card">
            <div class="balance-card-title">
                <i class="bi bi-trophy"></i> Productos más vendidos
            </div>
            <div class="chart-box mb-4"><canvas id="chartTop"></canvas></div>
            <asp:GridView ID="dgvTop" runat="server" CssClass="table" AutoGenerateColumns="false"
                GridLines="None" EmptyDataText="Todavía no hay ventas registradas.">
                <Columns>
                    <asp:BoundField DataField="Producto" HeaderText="Producto" />
                    <asp:BoundField DataField="Categoria" HeaderText="Categoría" />
                    <asp:BoundField DataField="Marca" HeaderText="Marca" />
                    <asp:BoundField DataField="UnidadesVendidas" HeaderText="Unidades" />
                    <asp:BoundField DataField="TotalFacturado" HeaderText="Facturado" DataFormatString="{0:C}" />
                </Columns>
            </asp:GridView>
        </div>

    </div>

    <script type="text/javascript">
        (function () {
            var colorPrincipal = '#ff7eb3';
            var paleta = ['#ff7eb3', '#ff9a9e', '#ffc3a0', '#c9a7eb', '#a0d8ef', '#b5ead7', '#ffdac1', '#e2a9f3', '#ffb7b2', '#bde0fe'];

            var ctxTop = document.getElementById('chartTop');
            if (ctxTop && typeof Chart !== 'undefined') {
                new Chart(ctxTop, {
                    type: 'bar',
                    data: { labels: <%= topLabels %>, datasets: [{ label: 'Unidades vendidas', data: <%= topData %>, backgroundColor: colorPrincipal, borderRadius: 6 }] },
                    options: { indexAxis: 'y', responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } } }
                });
            }

            var ctxDet = document.getElementById('chartDetalle');
            if (ctxDet && typeof Chart !== 'undefined') {
                new Chart(ctxDet, {
                    type: 'doughnut',
                    data: { labels: <%= detalleLabels %>, datasets: [{ data: <%= detalleData %>, backgroundColor: paleta }] },
                    options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { position: 'right' } } }
                });
            }
        })();
    </script>
</asp:Content>
