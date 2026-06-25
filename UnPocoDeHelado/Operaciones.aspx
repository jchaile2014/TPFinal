<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Operaciones.aspx.cs" Inherits="UnPocoDeHelado.Operaciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container mt-4">

    <div class="page-hero d-flex align-items-center justify-content-between flex-wrap gap-3 mb-4">
        <div class="d-flex align-items-center gap-3" style="z-index:1; position:relative;">
            <i class="bi bi-cart3 page-hero-icon"></i>
            <div>
                <h2 class="page-hero-title">Operaciones</h2>
                <p class="page-hero-sub">Registrá y consultá ventas y compras</p>
            </div>
        </div>
        <div class="d-flex gap-2" style="z-index:1; position:relative;">
            <asp:Button ID="btnNuevaVenta" runat="server" OnClick="btnNuevaVenta_Click"
                Text="+ Nueva Venta" CssClass="btn btn-hero" />
            <asp:Button ID="btnNuevaCompra" runat="server" OnClick="btnNuevaCompra_Click"
                Text="+ Nueva Compra" CssClass="btn"
                style="background: rgba(255,255,255,0.25); color: white; border: 2px solid rgba(255,255,255,0.7); font-weight: 700; padding: 0.6rem 1.5rem; border-radius: 50px; backdrop-filter: blur(4px);" />
        </div>
    </div>

    <div class="kpi-strip mb-4">
        <div class="kpi-item" id="kpiTodas">
            <i class="bi bi-receipt kpi-icon" style="color:#ff7eb3;"></i>
            <div>
                <div class="kpi-label">Total operaciones</div>
                <div class="kpi-value" id="kpiCountTodas">—</div>
            </div>
        </div>
        <div class="kpi-divider"></div>
        <div class="kpi-item" id="kpiVentas">
            <i class="bi bi-arrow-up-circle kpi-icon" style="color:#ff758c;"></i>
            <div>
                <div class="kpi-label">Ventas</div>
                <div class="kpi-value" id="kpiCountVentas">—</div>
            </div>
        </div>
        <div class="kpi-divider"></div>
        <div class="kpi-item" id="kpiCompras">
            <i class="bi bi-arrow-down-circle kpi-icon" style="color:#4f8ef7;"></i>
            <div>
                <div class="kpi-label">Compras</div>
                <div class="kpi-value" id="kpiCountCompras">—</div>
            </div>
        </div>
    </div>

    <hr class="mb-4" style="border-color: #fecfef; border-width: 2px;" />

    <div class="filter-bar mb-4">
        <div class="filter-section p-2 mb-3" style="margin-bottom: 1.5rem !important;">
            <span class="filter-label" style="margin-right:0.5rem; margin-left: 0.5rem;">Filtrar por</span>
            <div class="filter-pills" id="tabPills">
                <button type="button" runat="server" id="pillTodas" class="filter-pill active" data-tipo="todas" onclick="aplicarFiltros()">
                    <span class="pill-dot"></span> Todas
                    <span class="badge bg-white text-dark ms-1" id="countTodas" style="font-size:0.7rem; border-radius:10px;">0</span>
                </button>
                <button type="button" runat="server" id="pillVentas" class="filter-pill" data-tipo="venta" onclick="aplicarFiltros()">
                    <i class="bi bi-arrow-up-circle-fill" style="color:#ff758c;"></i> Ventas
                    <span class="badge bg-white text-dark ms-1" id="countVentas" style="font-size:0.7rem; border-radius:10px;">0</span>
                </button>
                <button type="button" runat="server" id="pillCompras" class="filter-pill" data-tipo="compra" onclick="aplicarFiltros()">
                    <i class="bi bi-arrow-down-circle-fill" style="color:#4f8ef7;"></i> Compras
                    <span class="badge bg-white text-dark ms-1" id="countCompras" style="font-size:0.7rem; border-radius:10px;">0</span>
                </button>
            </div>
        </div>
        <div class="row g-2">
            <div class="col-md-5">
                <div class="search-wrapper">
                    <i class="bi bi-search search-icon"></i>
                    <input type="text" id="txtBuscar" class="search-input" placeholder="Buscar por número de factura..." oninput="aplicarFiltros()" />
                    <button type="button" class="search-clear" id="btnLimpiarBuscar" onclick="limpiarBuscar()" style="display:none;">
                        <i class="bi bi-x"></i>
                    </button>
                </div>
            </div>
            <div class="col-md-4">
                <div class="estado-filter-wrapper">
                    <i class="bi bi-person estado-filter-icon"></i>
                    <asp:DropDownList ID="ddlEmpleado" runat="server" ClientIDMode="Static" CssClass="estado-filter" onchange="aplicarFiltros()">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-md-3">
                <div class="estado-filter-wrapper">
                    <i class="bi bi-calendar3 estado-filter-icon"></i>
                    <select id="ddlFecha" class="estado-filter" onchange="cambiarModoFecha()">
                        <option value="todas">Todas las fechas</option>
                        <option value="hoy">Hoy</option>
                        <option value="semana">Semana pasada</option>
                        <option value="mes">Último mes</option>
                        <option value="personalizar">Personalizar</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row g-2 mt-1" id="rowPersonalizar" style="display:none;">
            <div class="col-md-3 offset-md-9">
                <div class="row g-2">
                    <div class="col-6">
                        <input type="date" id="txtFechaDesde" class="search-input" style="padding: 0.65rem 0.8rem;" onchange="aplicarFiltros()" />
                    </div>
                    <div class="col-6">
                        <input type="date" id="txtFechaHasta" class="search-input" style="padding: 0.65rem 0.8rem;" onchange="aplicarFiltros()" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="sinResultados" class="text-center py-5" style="display:none;">
        <i class="bi bi-search" style="font-size: 3rem; color: #fecfef;"></i>
        <p class="text-muted mt-3 fw-semibold">No se encontraron operaciones con ese criterio.</p>
        <button type="button" class="btn btn-sm" onclick="resetearFiltros()" style="border: 2px solid #ff7eb3; color: #ff7eb3; border-radius: 20px; padding: 0.4rem 1.2rem;">
            Limpiar filtros
        </button>
    </div>

    <div class="row" id="gridOperaciones">
        <asp:Repeater ID="rptOperaciones" runat="server">
            <ItemTemplate>
                <div class="col-md-4 col-sm-6 mb-4 op-card-wrapper"
                     data-tipo='<%# Convert.ToBoolean(Eval("SeOpera")) ? "venta" : "compra" %>'
                     data-factura='<%# (Eval("NumeroFactura") ?? "").ToString().ToLower() %>'
                     data-estado='<%# (Eval("Estado") ?? "").ToString().ToLower() %>'
                     data-fecha='<%# Eval("Fecha", "{0:yyyy-MM-dd}") %>'
                     data-empleado='<%# (Eval("Empleado.Nombre") ?? "").ToString() %>'>
                    <div class='<%# "op-card op-card-" + (Convert.ToBoolean(Eval("SeOpera")) ? "venta" : "compra") %>'>
                        <div class="op-card-glow"></div>
                        <div class="op-card-inner">
                            <div class="op-icon-wrap op-icon-wrap-<%# Convert.ToBoolean(Eval("SeOpera")) ? "venta" : "compra" %>">
                                <i class='<%# Convert.ToBoolean(Eval("SeOpera")) ? "bi bi-receipt" : "bi bi-box-arrow-in-down" %>'></i>
                            </div>
                            <span class='op-type-badge op-type-<%# Convert.ToBoolean(Eval("SeOpera")) ? "venta" : "compra" %>'>
                                <%# Convert.ToBoolean(Eval("SeOpera")) ? "Venta" : "Compra" %>
                            </span>
                            <h5 class="op-factura"><%# string.IsNullOrEmpty(Eval("NumeroFactura")?.ToString()) ? "Sin factura" : Eval("NumeroFactura") %></h5>
                            <div class="op-meta">
                                <span><i class="bi bi-calendar3"></i> <%# Eval("Fecha", "{0:dd/MM/yyyy}") %></span>
                                <span><i class="bi bi-cash"></i> <%# Eval("Total", "{0:C}") %></span>
                            </div>
                            <div class="mt-2">
                                <span class="op-cliente-badge">
                                    <i class='<%# Convert.ToBoolean(Eval("SeOpera")) ? "bi bi-person me-1" : "bi bi-truck me-1" %>'></i>
                                    <%# Convert.ToBoolean(Eval("SeOpera")) ? Eval("Cliente.Nombre") : Eval("Proveedores") %>
                                </span>
                            </div>
                        </div>
                        <div class="op-card-footer">
                            <a href='<%# "OperacionesABM.aspx?id=" + Eval("Id") %>' class='btn-ver-op btn-ver-<%# Convert.ToBoolean(Eval("SeOpera")) ? "venta" : "compra" %>'>
                                <i class="bi bi-eye me-1"></i>Ver detalle
                            </a>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</div>

<style>
    .kpi-strip {
        display: flex;
        align-items: center;
        background: rgba(255,255,255,0.9);
        border-radius: 16px;
        padding: 1rem 1.5rem;
        box-shadow: 0 4px 20px rgba(255,117,140,0.08);
        border: 1px solid rgba(255,126,179,0.12);
        gap: 0;
        flex-wrap: wrap;
    }
    .kpi-item {
        display: flex;
        align-items: center;
        gap: 0.8rem;
        flex: 1;
        min-width: 120px;
        padding: 0.25rem 1rem;
    }
    .kpi-icon { font-size: 1.8rem; }
    .kpi-label { font-size: 0.75rem; color: #9a9a9a; font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em; }
    .kpi-value { font-size: 1.5rem; font-weight: 800; color: #4a4a4a; }
    .kpi-divider { width: 1px; height: 48px; background: #f0e0e8; margin: 0 0.5rem; }
    .filter-bar {
        background: rgba(255,255,255,0.85);
        border-radius: 16px;
        padding: 1.25rem 1.5rem;
        box-shadow: 0 4px 20px rgba(255,117,140,0.08);
        border: 1px solid rgba(255,126,179,0.15);
    }

    .search-wrapper { position: relative; }
    .search-icon {
        position: absolute; left: 14px; top: 50%; transform: translateY(-50%);
        color: #ff7eb3; font-size: 1rem; pointer-events: none;
    }
    .search-input {
        width: 100%; padding: 0.65rem 2.5rem;
        border: 1.5px solid #e0e0e0; border-radius: 50px;
        font-size: 0.9rem; outline: none; transition: border-color 0.25s; background: white;
    }
    .search-input:focus { border-color: #ff7eb3; box-shadow: 0 0 0 3px rgba(255,126,179,0.15); }
    .search-clear {
        position: absolute; right: 12px; top: 50%; transform: translateY(-50%);
        background: none; border: none; color: #aaa; cursor: pointer; font-size: 1rem; padding: 0;
    }
    .search-clear:hover { color: #ff7eb3; }
    .estado-filter-wrapper { position: relative; }
    .estado-filter-icon {
        position: absolute; left: 14px; top: 50%; transform: translateY(-50%);
        color: #ff7eb3; font-size: 0.95rem; pointer-events: none;
    }
    .estado-filter {
        width: 100%; padding: 0.65rem 1rem 0.65rem 2.4rem;
        border: 1.5px solid #e0e0e0; border-radius: 50px;
        font-size: 0.9rem; outline: none; appearance: none; background: white; cursor: pointer;
    }
    .estado-filter:focus { border-color: #ff7eb3; box-shadow: 0 0 0 3px rgba(255,126,179,0.15); }
    .op-card {
        position: relative; border-radius: 20px; overflow: hidden;
        transition: transform 0.3s, box-shadow 0.3s;
        animation: fadeInUp 0.4s ease both;
        box-shadow: 0 4px 20px rgba(0,0,0,0.06);
    }
    .op-card:hover { transform: translateY(-6px); box-shadow: 0 16px 40px rgba(0,0,0,0.12); }
    .op-card-venta { background: linear-gradient(160deg, #fff0f5 0%, #ffffff 60%); border: 1px solid rgba(255,126,179,0.2); }
    .op-card-compra { background: linear-gradient(160deg, #f0f5ff 0%, #ffffff 60%); border: 1px solid rgba(79,142,247,0.2); }
    .op-card-glow {
        position: absolute; top: -40px; right: -40px;
        width: 120px; height: 120px; border-radius: 50%;
        opacity: 0.06; pointer-events: none;
    }
    .op-card-venta .op-card-glow { background: radial-gradient(circle, #ff758c, transparent); }
    .op-card-compra .op-card-glow { background: radial-gradient(circle, #4f8ef7, transparent); }
    .op-card-inner { padding: 1.75rem 1.5rem 1rem; text-align: center; }
    .op-icon-wrap {
        width: 64px; height: 64px; border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        font-size: 1.8rem; margin: 0 auto 1rem;
    }
    .op-icon-wrap-venta { background: linear-gradient(135deg, #ff758c22, #ff7eb333); color: #ff758c; }
    .op-icon-wrap-compra { background: linear-gradient(135deg, #4f8ef722, #4f8ef733); color: #4f8ef7; }
    .op-type-badge {
        display: inline-block; font-size: 0.75rem; font-weight: 700;
        padding: 0.2rem 0.8rem; border-radius: 50px; letter-spacing: 0.04em;
        text-transform: uppercase; margin-bottom: 0.6rem;
    }
    .op-type-venta  { background: #fecfef; color: #ff758c; }
    .op-type-compra { background: #dce8ff; color: #2563eb; }
    .op-factura { font-size: 1rem; font-weight: 700; color: #333; margin: 0.3rem 0 0.6rem; }
    .op-meta {
        display: flex; justify-content: center; gap: 1.2rem;
        font-size: 0.82rem; color: #888; margin-bottom: 0.5rem;
    }
    .op-meta i { margin-right: 0.2rem; }
    .op-card-footer {
        padding: 0.9rem 1.5rem;
        border-top: 1px solid rgba(0,0,0,0.05);
        text-align: center;
    }
    .btn-ver-op {
        display: inline-block; font-weight: 700; font-size: 0.88rem;
        padding: 0.45rem 1.6rem; border-radius: 50px;
        text-decoration: none; transition: all 0.3s;
    }
    .btn-ver-venta  { border: 2px solid #ff7eb3; color: #ff7eb3; }
    .btn-ver-compra { border: 2px solid #4f8ef7; color: #4f8ef7; }
    .btn-ver-venta:hover  { background: linear-gradient(to right, #ff758c, #ff7eb3); color: white; border-color: transparent; }
    .btn-ver-compra:hover { background: linear-gradient(to right, #4f8ef7, #6ba3ff); color: white; border-color: transparent; }
    .estado-badge {
        display: inline-block; font-size: 0.78rem; font-weight: 600;
        padding: 0.2rem 0.75rem; border-radius: 50px;
    }
    .estado-cobrada   { background: #d1fae5; color: #065f46; }
    .estado-pendiente { background: #fef3c7; color: #92400e; }
    .estado-finalizado { background: #dbeafe; color: #1e40af; }
    .op-cliente-badge {
        display: inline-block; font-size: 0.82rem; font-weight: 600;
        padding: 0.2rem 0.85rem; border-radius: 50px;
        background: #fff0f5; color: #c05070;
    }
    .op-card-wrapper.hidden { display: none !important; }
    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(20px); }
        to   { opacity: 1; transform: translateY(0); }
    }
</style>

<script type="text/javascript">
    window.addEventListener('DOMContentLoaded', function () {
        actualizarContadores();
        aplicarFiltros();
    });

    function toYMD(d) {
        var mes = ('0' + (d.getMonth() + 1)).slice(-2);
        var dia = ('0' + d.getDate()).slice(-2);
        return d.getFullYear() + '-' + mes + '-' + dia;
    }

    function obtenerRangoFecha() {
        var modo = document.getElementById('ddlFecha').value;
        var hoy = new Date(); hoy.setHours(0, 0, 0, 0);
        if (modo === 'todas') {
            return { desde: null, hasta: null };
        }
        if (modo === 'hoy') {
            return { desde: toYMD(hoy), hasta: toYMD(hoy) };
        }
        if (modo === 'semana') {
            var d = new Date(hoy); d.setDate(hoy.getDate() - 6);
            return { desde: toYMD(d), hasta: toYMD(hoy) };
        }
        if (modo === 'mes') {
            var m = new Date(hoy); m.setDate(hoy.getDate() - 29);
            return { desde: toYMD(m), hasta: toYMD(hoy) };
        }
        if (modo === 'personalizar') {
            return {
                desde: document.getElementById('txtFechaDesde').value || null,
                hasta: document.getElementById('txtFechaHasta').value || null
            };
        }
        return { desde: null, hasta: null };
    }

    function cambiarModoFecha() {
        var esPersonalizar = document.getElementById('ddlFecha').value === 'personalizar';
        document.getElementById('rowPersonalizar').style.display = esPersonalizar ? 'flex' : 'none';
        aplicarFiltros();
    }

    document.addEventListener('click', function (e) {
        var pill = e.target.closest('.filter-pill');
        if (!pill) return;
        document.querySelectorAll('.filter-pill').forEach(function (p) { p.classList.remove('active'); });
        pill.classList.add('active');
        aplicarFiltros();
    });

    function aplicarFiltros() {
        var tipoActivo     = document.querySelector('.filter-pill.active')?.dataset.tipo || 'todas';
        var textoBuscar    = (document.getElementById('txtBuscar').value || '').trim().toLowerCase();
        var empleadoFiltro = (document.getElementById('ddlEmpleado').value || '').toLowerCase();
        var rangoFecha     = obtenerRangoFecha();

        document.getElementById('btnLimpiarBuscar').style.display = textoBuscar ? 'block' : 'none';

        var cards = document.querySelectorAll('.op-card-wrapper');
        var visibles = 0;
        cards.forEach(function (card) {
            var tipo     = card.dataset.tipo     || '';
            var factura  = card.dataset.factura  || '';
            var empleado = (card.dataset.empleado || '').toLowerCase();
            var fecha    = card.dataset.fecha    || '';
            var okFecha = (!rangoFecha.desde || fecha >= rangoFecha.desde)
                       && (!rangoFecha.hasta || fecha <= rangoFecha.hasta);
            var ok = (tipoActivo === 'todas' || tipo === tipoActivo)
                  && (!textoBuscar    || factura.includes(textoBuscar))
                  && (!empleadoFiltro || empleado === empleadoFiltro)
                  && okFecha;
            if (ok) { card.classList.remove('hidden'); visibles++; }
            else      card.classList.add('hidden');
        });
        document.getElementById('sinResultados').style.display = visibles === 0 ? 'block' : 'none';
    }

    function setText(id, val) {
        var el = document.getElementById(id);
        if (el) el.textContent = val;
    }

    function actualizarContadores() {
        var cards = document.querySelectorAll('.op-card-wrapper');
        var v = 0, c = 0;
        cards.forEach(function (card) {
            if (card.dataset.tipo === 'venta')  v++;
            if (card.dataset.tipo === 'compra') c++;
        });
        setText('countTodas', cards.length);
        setText('countVentas', v);
        setText('countCompras', c);
        setText('kpiCountTodas', cards.length);
        setText('kpiCountVentas', v);
        setText('kpiCountCompras', c);
    }

    function limpiarBuscar() {
        document.getElementById('txtBuscar').value = '';
        document.getElementById('btnLimpiarBuscar').style.display = 'none';
        aplicarFiltros();
    }

    function resetearFiltros() {
        document.getElementById('txtBuscar').value = '';
        document.getElementById('ddlEmpleado').value = '';
        document.getElementById('ddlFecha').value = 'todas';
        document.getElementById('rowPersonalizar').style.display = 'none';
        document.querySelectorAll('.filter-pill').forEach(function (p) { p.classList.remove('active'); });
        var pillDefault = document.querySelector('.filter-pill[data-tipo="todas"]') || document.querySelector('.filter-pill[data-tipo="venta"]');
        if (pillDefault) pillDefault.classList.add('active');
        aplicarFiltros();
    }
</script>
</asp:Content>
