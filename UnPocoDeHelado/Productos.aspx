<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="UnPocoDeHelado.Productos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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
            width: 100%; padding: 0.65rem 1rem 0.65rem 2.5rem;
            border: 1.5px solid #e0e0e0; border-radius: 50px;
            font-size: 0.9rem; outline: none; transition: border-color 0.25s; background: white;
        }
        .search-input:focus { border-color: #ff7eb3; box-shadow: 0 0 0 3px rgba(255,126,179,0.15); }
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">

        <div class="page-hero d-flex align-items-center justify-content-between flex-wrap gap-3 mb-4">
            <div class="d-flex align-items-center gap-3" style="z-index:1; position:relative;">
                <i class="bi bi-box-seam page-hero-icon"></i>
                <div>
                    <h2 class="page-hero-title">Gestión de Productos</h2>
                    <p class="page-hero-sub">Administrá el catálogo y el stock</p>
                </div>
            </div>
            <div style="z-index:1; position:relative;">
                <asp:Button ID="btnAgregar" runat="server" OnClick="btnAgregar_Click"
                    Text="+ Nuevo Producto" CssClass="btn btn-hero" />
            </div>
        </div>

        <div class="filter-bar mb-4">
            <div class="filter-section p-2 mb-3" style="margin-bottom: 1.5rem !important;">
                <span class="filter-label" style="margin-right:0.5rem; margin-left: 0.5rem;">ORDENAR POR</span>
                <div class="filter-pills">
                    <asp:LinkButton ID="btnOrdenPredeterminado" runat="server" CssClass="filter-pill active" OnClick="btnOrdenPredeterminado_Click" style="text-decoration:none;">
                        <span class="pill-dot"></span> Alfabético
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnOrdenarStock" runat="server" CssClass="filter-pill" OnClick="btnOrdenarStock_Click" style="text-decoration:none;">
                        <i class="bi bi-arrow-down-circle-fill" style="color:#ff758c;"></i> Mayor Stock
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnOrdenarStockMenor" runat="server" CssClass="filter-pill" OnClick="btnOrdenarStockMenor_Click" style="text-decoration:none;">
                        <i class="bi bi-arrow-up-circle-fill" style="color:#4f8ef7;"></i> Menor Stock
                    </asp:LinkButton>
                </div>
            </div>
            <div class="row g-2">
                <div class="col-md-6">
                    <div class="search-wrapper">
                        <i class="bi bi-search search-icon"></i>
                        <asp:TextBox ID="txtFiltro" runat="server" CssClass="search-input" placeholder="Buscar por nombre..." AutoPostBack="true" OnTextChanged="Filtro_Changed"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="estado-filter-wrapper">
                        <i class="bi bi-tags estado-filter-icon"></i>
                        <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="estado-filter" AutoPostBack="true" OnSelectedIndexChanged="Filtro_Changed">
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <asp:Repeater ID="rptProductos" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 col-sm-6 mb-4">
                        <div class="list-card h-100">
                            <div class="card-body text-center" style="padding: 1.75rem 1rem 1rem; background: linear-gradient(160deg, #fff0f5 0%, #ffffff 70%);">
                                <div class="mb-3">
                                    <i class="bi bi-box-seam" style="font-size: 4rem; color: #ff758c;"></i>
                                </div>
                                <h5 class="fw-bold mb-0" style="color: #333;"><%# Eval("Nombre") %></h5>
                                <span class="badge rounded-pill mt-2 mb-3" style="background-color: #fecfef; color: #ff758c; font-size: 0.75rem; font-weight: 700;">
                                    <%# Eval("Marca") %> / <%# Eval("Categoria") %>
                                </span>
                                <p class="text-muted small mb-1">
                                    <i class="bi bi-box-fill me-1" style="color:#ff7eb3;"></i>
                                    Stock: <strong><%# Eval("Cantidad") %></strong>
                                    <span class="text-danger">(mín. <%# Eval("StockMinimo") %>)</span>
                                </p>
                                <p class="text-muted small mb-0">
                                    <i class="bi bi-cash-coin me-1" style="color:#ff7eb3;"></i>
                                    <%# Eval("PrecioVenta", "{0:C}") %>
                                </p>
                            </div>
                            <div class="card-footer bg-transparent border-0 text-center pb-4 mt-auto" style="border-top: 1px solid rgba(0,0,0,0.05) !important;">
                                <a href='<%# "ProductosABM.aspx?id=" + Eval("Id") %>' class="btn-editar">
                                    <i class="bi bi-pencil-square me-1"></i> Editar
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
