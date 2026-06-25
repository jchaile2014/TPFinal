<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="UnPocoDeHelado.Clientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">

        <div class="page-hero d-flex align-items-center justify-content-between flex-wrap gap-3">
            <div class="d-flex align-items-center gap-3" style="z-index:1; position:relative;">
                <i class="bi bi-people-fill page-hero-icon"></i>
                <div>
                    <h2 class="page-hero-title">Gestión de Clientes</h2>
                    <p class="page-hero-sub">Administrá y gestioná tu cartera de clientes</p>
                </div>
            </div>
            <div style="z-index:1; position:relative;">
                <asp:Button ID="btnAgregar" runat="server" OnClick="btnAgregar_Click"
                    Text="+ Nuevo Cliente" CssClass="btn btn-hero" />
            </div>
        </div>

        <div class="kpi-strip mb-4">
            <div class="kpi-item" id="kpiTodas">
                <i class="bi bi-people kpi-icon" style="color:#ff7eb3;"></i>
                <div>
                    <div class="kpi-label">Total clientes</div>
                    <div class="kpi-value" id="kpiCountTodas">—</div>
                </div>
            </div>
        </div>

        <hr class="mb-4" style="border-color: #fecfef; border-width: 2px;" />

        <div class="filter-bar mb-4">
            <div class="row g-2">
                <div class="col-md-8">
                    <div class="search-wrapper">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" id="txtBuscar" class="search-input" placeholder="Buscar por DNI, teléfono, email, nombre o apellido..." oninput="aplicarFiltros()" />
                        <button type="button" class="search-clear" id="btnLimpiarBuscar" onclick="limpiarBuscar()" style="display:none;">
                            <i class="bi bi-x"></i>
                        </button>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="estado-filter-wrapper">
                        <i class="bi bi-sort-alpha-down estado-filter-icon"></i>
                        <select id="ddlOrdenar" class="estado-filter" onchange="aplicarFiltros()">
                            <option value="az">Ordenar de A a Z</option>
                            <option value="za">Ordenar de Z a A</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <div id="sinResultados" class="text-center py-5" style="display:none;">
            <i class="bi bi-search" style="font-size: 3rem; color: #fecfef;"></i>
            <p class="text-muted mt-3 fw-semibold">No se encontraron clientes con ese criterio.</p>
            <button type="button" class="btn btn-sm" onclick="resetearFiltros()" style="border: 2px solid #ff7eb3; color: #ff7eb3; border-radius: 20px; padding: 0.4rem 1.2rem;">
                Limpiar filtros
            </button>
        </div>

        <div class="row" id="gridClientes">
            <asp:Repeater ID="rptClientes" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 col-sm-6 mb-4 cliente-card-wrapper"
                         data-nombre='<%# (Eval("Nombre") ?? "").ToString().ToLower() %>'
                         data-apellido='<%# (Eval("Apellido") ?? "").ToString().ToLower() %>'
                         data-dni='<%# (Eval("DNI") ?? "").ToString().ToLower() %>'
                         data-email='<%# (Eval("Email") ?? "").ToString().ToLower() %>'
                         data-telefono='<%# (Eval("Telefono") ?? "").ToString().ToLower() %>'>
                        <div class="list-card h-100">
                            <div class="card-body text-center" style="padding: 1.75rem 1rem 1rem; background: linear-gradient(160deg, #fff0f5 0%, #ffffff 70%);">
                                <div class="mb-3">
                                    <i class="bi bi-person-circle" style="font-size: 4rem; color: #ff758c;"></i>
                                </div>
                                <h5 class="fw-bold mb-0" style="color: #333;"><%# Eval("Nombre") %> <%# Eval("Apellido") %></h5>
                                <span class="badge rounded-pill mt-2 mb-3" style="background-color: #fecfef; color: #ff758c; font-size: 0.75rem; font-weight: 700;">Cliente</span>
                                <p class="text-muted small mb-1">
                                    <i class="bi bi-envelope-fill me-1" style="color:#ff7eb3;"></i>
                                    <%# string.IsNullOrEmpty(Eval("Email")?.ToString()) ? "Sin email" : Eval("Email") %>
                                </p>
                                <p class="text-muted small mb-3">
                                    <i class="bi bi-telephone-fill me-1" style="color:#ff7eb3;"></i>
                                    <%# string.IsNullOrEmpty(Eval("Telefono")?.ToString()) ? "Sin teléfono" : Eval("Telefono") %>
                                </p>
                                <div class="d-flex justify-content-center small px-2 py-2" style="background-color: #fdf5f8; border-radius: 10px;">
                                    <div class="text-center">
                                        <strong style="color: #ff758c;">DNI</strong><br />
                                        <span class="text-muted"><%# string.IsNullOrEmpty(Eval("DNI")?.ToString()) ? "—" : Eval("DNI") %></span>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer bg-transparent border-0 text-center pb-4 mt-auto" style="border-top: 1px solid rgba(0,0,0,0.05) !important;">
                                <a href='<%# "ClientesABM.aspx?id=" + Eval("Id") %>' class="btn-editar">
                                    <i class="bi bi-pencil-square me-1"></i> Editar
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
        
        .list-card {
            border-radius: 20px; overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
            animation: fadeInUp 0.4s ease both;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
            background: white;
            display: flex; flex-direction: column;
        }
        .list-card:hover { transform: translateY(-6px); box-shadow: 0 16px 40px rgba(0,0,0,0.12); }
        .btn-editar {
            display: inline-block; font-weight: 700; font-size: 0.88rem;
            padding: 0.45rem 1.6rem; border-radius: 50px;
            text-decoration: none; transition: all 0.3s;
            border: 2px solid #ff7eb3; color: #ff7eb3;
        }
        .btn-editar:hover { background: linear-gradient(to right, #ff758c, #ff7eb3); color: white; border-color: transparent; }
        .cliente-card-wrapper.hidden { display: none !important; }
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

        function aplicarFiltros() {
            var textoBuscar = (document.getElementById('txtBuscar').value || '').trim().toLowerCase();
            var orden = document.getElementById('ddlOrdenar').value;

            document.getElementById('btnLimpiarBuscar').style.display = textoBuscar ? 'block' : 'none';

            var cardsWrapper = document.getElementById('gridClientes');
            var cards = Array.from(document.querySelectorAll('.cliente-card-wrapper'));
            
            var visibles = 0;
            cards.forEach(function (card) {
                var nombre = card.dataset.nombre || '';
                var apellido = card.dataset.apellido || '';
                var dni = card.dataset.dni || '';
                var email = card.dataset.email || '';
                var telefono = card.dataset.telefono || '';
                
                var ok = (!textoBuscar || 
                          nombre.includes(textoBuscar) || 
                          apellido.includes(textoBuscar) || 
                          dni.includes(textoBuscar) || 
                          email.includes(textoBuscar) || 
                          telefono.includes(textoBuscar));
                
                if (ok) {
                    card.classList.remove('hidden');
                    visibles++;
                } else {
                    card.classList.add('hidden');
                }
            });
            cards.sort(function(a, b) {
                var nombreA = (a.dataset.apellido + " " + a.dataset.nombre).trim();
                var nombreB = (b.dataset.apellido + " " + b.dataset.nombre).trim();
                if (orden === 'az') {
                    return nombreA.localeCompare(nombreB);
                } else {
                    return nombreB.localeCompare(nombreA);
                }
            });
            cards.forEach(function(card) {
                cardsWrapper.appendChild(card);
            });

            document.getElementById('sinResultados').style.display = visibles === 0 ? 'block' : 'none';
        }

        function actualizarContadores() {
            var total = document.querySelectorAll('.cliente-card-wrapper').length;
            var el = document.getElementById('kpiCountTodas');
            if (el) el.textContent = total;
        }

        function limpiarBuscar() {
            document.getElementById('txtBuscar').value = '';
            document.getElementById('btnLimpiarBuscar').style.display = 'none';
            aplicarFiltros();
        }

        function resetearFiltros() {
            document.getElementById('txtBuscar').value = '';
            document.getElementById('ddlOrdenar').value = 'az';
            aplicarFiltros();
        }
    </script>
</asp:Content>
