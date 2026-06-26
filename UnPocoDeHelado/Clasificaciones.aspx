<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clasificaciones.aspx.cs" Inherits="UnPocoDeHelado.Clasificaciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .clas-hero {
            background: linear-gradient(135deg, #ff758c 0%, #ff7eb3 60%, #ffb3d1 100%);
            border-radius: 20px;
            padding: 2rem 2.5rem;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
            box-shadow: 0 12px 35px rgba(255,117,140,0.35);
        }
        .clas-hero::before {
            content: '';
            position: absolute;
            top: -40px; right: -40px;
            width: 200px; height: 200px;
            background: rgba(255,255,255,0.12);
            border-radius: 50%;
        }
        .clas-hero::after {
            content: '';
            position: absolute;
            bottom: -60px; right: 80px;
            width: 150px; height: 150px;
            background: rgba(255,255,255,0.08);
            border-radius: 50%;
        }
        .clas-hero-title {
            color: white;
            font-size: 2rem;
            font-weight: 800;
            margin: 0;
            text-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .clas-hero-sub {
            color: rgba(255,255,255,0.85);
            margin: 0.3rem 0 0;
            font-size: 0.95rem;
        }
        .clas-hero-icon {
            font-size: 3.5rem;
            color: rgba(255,255,255,0.9);
            filter: drop-shadow(0 4px 8px rgba(0,0,0,0.15));
        }
        .btn-nuevo-clas {
            background: white;
            color: #ff758c;
            border: none;
            font-weight: 700;
            padding: 0.6rem 1.5rem;
            border-radius: 50px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
            transition: all 0.3s;
            font-size: 0.92rem;
        }
        .btn-nuevo-clas:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            color: #ff758c;
        }

        .clas-card {
            border-radius: 18px;
            border: none;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 4px 20px rgba(0,0,0,0.07);
            background: white;
        }
        .clas-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 18px 40px rgba(255,117,140,0.18);
        }
        .clas-card-header {
            padding: 1.75rem 1rem 1rem;
            text-align: center;
            position: relative;
        }
        .clas-card-header.tipo-marca {
            background: linear-gradient(160deg, #fff0f5 0%, #ffffff 70%);
        }
        .clas-card-header.tipo-categoria {
            background: linear-gradient(160deg, #f0f5ff 0%, #ffffff 70%);
        }
        .clas-icon-wrap {
            width: 72px; height: 72px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 2rem;
            margin: 0 auto 1rem;
        }
        .clas-icon-wrap.tipo-marca {
            background: linear-gradient(135deg, #ff758c22, #ff7eb344);
            color: #ff758c;
        }
        .clas-icon-wrap.tipo-categoria {
            background: linear-gradient(135deg, #4f8ef722, #4f8ef744);
            color: #4f8ef7;
        }
        .clas-tipo-badge {
            display: inline-block;
            font-size: 0.72rem;
            font-weight: 700;
            padding: 0.2rem 0.85rem;
            border-radius: 50px;
            letter-spacing: 0.04em;
            text-transform: uppercase;
            margin-bottom: 0.5rem;
        }
        .clas-tipo-badge.tipo-marca   { background: #fecfef; color: #ff758c; }
        .clas-tipo-badge.tipo-categoria { background: #dce8ff; color: #2563eb; }
        .clas-nombre {
            font-size: 1.1rem;
            font-weight: 800;
            color: #333;
            margin: 0.25rem 0 0.5rem;
        }
        .clas-status-badge {
            display: inline-block;
            font-size: 0.75rem;
            font-weight: 600;
            padding: 0.2rem 0.75rem;
            border-radius: 50px;
        }
        .status-activo   { background: #d1fae5; color: #065f46; }
        .status-inactivo { background: #fee2e2; color: #991b1b; }
        .clas-card-footer {
            padding: 0.9rem 1.25rem;
            border-top: 1px solid rgba(0,0,0,0.05);
            text-align: center;
            background: transparent;
        }
        .btn-editar-clas {
            display: inline-block;
            font-weight: 700;
            font-size: 0.85rem;
            padding: 0.45rem 1.5rem;
            border-radius: 50px;
            text-decoration: none;
            transition: all 0.3s;
            border: 2px solid #ff7eb3;
            color: #ff7eb3;
        }
        .btn-editar-clas:hover {
            background: linear-gradient(to right, #ff758c, #ff7eb3);
            color: white;
            border-color: transparent;
            box-shadow: 0 6px 16px rgba(255,117,140,0.35);
        }
        .ddl-oculto { display: none; }

        .empty-state {
            text-align: center;
            padding: 4rem 1rem;
            color: #bbb;
        }
        .empty-state i { font-size: 3.5rem; color: #fecfef; display: block; margin-bottom: 1rem; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">

        <div class="clas-hero d-flex align-items-center justify-content-between flex-wrap gap-3 mb-4">
            <div class="d-flex align-items-center gap-3" style="z-index:1; position:relative;">
                <i class="bi bi-tags-fill clas-hero-icon"></i>
                <div>
                    <h2 class="clas-hero-title">Gestión de Clasificaciones</h2>
                    <p class="clas-hero-sub">Administrá marcas y categorías de productos</p>
                </div>
            </div>

        </div>

        <div class="filter-section">
            <span class="filter-label">Filtrar por</span>
            <div class="filter-pills" id="filterPills">

                <button type="button" class="filter-pill" data-val="True" onclick="filtrarPill(this)">
                    <i class="bi bi-bookmark-star-fill" style="color:#ff758c;"></i> Marcas
                </button>
                <button type="button" class="filter-pill" data-val="False" onclick="filtrarPill(this)">
                    <i class="bi bi-grid-fill" style="color:#4f8ef7;"></i> Categorías
                </button>
            </div>
        </div>

        <asp:DropDownList ID="ddlTipo" CssClass="ddl-oculto" runat="server"
            AutoPostBack="true" OnSelectedIndexChanged="ddlTipo_SelectedIndexChanged">
            <asp:ListItem Value="">Todos</asp:ListItem>
            <asp:ListItem Value="True">Marca</asp:ListItem>
            <asp:ListItem Value="False">Categoría</asp:ListItem>
        </asp:DropDownList>

        <div class="row" id="gridClasificaciones">
            <asp:Repeater ID="rptClasificaciones" runat="server">
                <ItemTemplate>
                    <div class="col-md-3 col-sm-6 mb-4 clas-item"
                         data-tipo='<%# (bool)Eval("SeClasifica") ? "True" : "False" %>'>
                        <div class="clas-card h-100">
                            <div class='clas-card-header <%# (bool)Eval("SeClasifica") ? "tipo-marca" : "tipo-categoria" %>'>
                                <div class='clas-icon-wrap <%# (bool)Eval("SeClasifica") ? "tipo-marca" : "tipo-categoria" %>'>
                                    <i class='<%# (bool)Eval("SeClasifica") ? "bi bi-bookmark-star-fill" : "bi bi-grid-fill" %>'></i>
                                </div>
                                <span class='clas-tipo-badge <%# (bool)Eval("SeClasifica") ? "tipo-marca" : "tipo-categoria" %>'>
                                    <%# (bool)Eval("SeClasifica") ? "Marca" : "Categoría" %>
                                </span>
                                <div class="clas-nombre"><%# Eval("Nombre") %></div>
                                <span class='clas-status-badge <%# (bool)Eval("Activo") ? "status-activo" : "status-inactivo" %>'>
                                    <%# (bool)Eval("Activo") ? "✓ Activo" : "✗ Inactivo" %>
                                </span>
                            </div>
                            <div class="clas-card-footer">
                                <a href='<%# "ClasificacionesABM.aspx?id=" + Eval("Id") %>' class="btn-editar-clas">
                                    <i class="bi bi-pencil-square me-1"></i> Editar
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <div id="emptyState" class="empty-state" style="display:none;">
            <i class="bi bi-tags"></i>
            <p class="fw-semibold">No hay clasificaciones para mostrar.</p>
        </div>

    </div>

    <script type="text/javascript">
        function filtrarPill(pill) {
            document.querySelectorAll('.filter-pill').forEach(function (p) {
                p.classList.remove('active');
            });
            pill.classList.add('active');

            var val = pill.dataset.val;

            var ddl = document.querySelector("select[id$='ddlTipo']");
            if (ddl) {
                ddl.value = val;
                __doPostBack(ddl.name, '');
            }
        }
        window.addEventListener('DOMContentLoaded', function () {
            var ddl = document.querySelector("select[id$='ddlTipo']");
            if (ddl) {
                var val = ddl.value;
                document.querySelectorAll('.filter-pill').forEach(function (p) {
                    p.classList.toggle('active', p.dataset.val === val);
                });
            }
            actualizarEmpty();
        });

        function actualizarEmpty() {
            var items = document.querySelectorAll('.clas-item');
            var empty = document.getElementById('emptyState');
            if (empty) empty.style.display = items.length === 0 ? 'block' : 'none';
        }
    </script>
</asp:Content>
