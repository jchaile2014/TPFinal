<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="UnPocoDeHelado.Proveedores" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">

        <div class="page-hero d-flex align-items-center justify-content-between flex-wrap gap-3">
            <div class="d-flex align-items-center gap-3" style="z-index:1; position:relative;">
                <i class="bi bi-truck page-hero-icon"></i>
                <div>
                    <h2 class="page-hero-title">Gestión de Proveedores</h2>
                    <p class="page-hero-sub">Administrá tus proveedores y contactos</p>
                </div>
            </div>
            <div style="z-index:1; position:relative;">
                <asp:Button ID="btnAgregar" runat="server" OnClick="btnAgregar_Click"
                    Text="+ Nuevo Proveedor" CssClass="btn btn-hero" />
            </div>
        </div>

        <div class="row">
            <asp:Repeater ID="rptProveedores" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 col-sm-6 mb-4">
                        <div class="list-card h-100">
                            <div class="card-body text-center" style="padding: 1.75rem 1rem 1rem; background: linear-gradient(160deg, #fff0f5 0%, #ffffff 70%);">
                                <div class="mb-3">
                                    <i class="bi bi-truck" style="font-size: 4rem; color: #ff758c;"></i>
                                </div>
                                <h5 class="fw-bold mb-0" style="color: #333;"><%# Eval("Nombre") %></h5>
                                <span class="badge rounded-pill mt-2 mb-3" style="background-color: #fecfef; color: #ff758c; font-size: 0.75rem; font-weight: 700;">
                                    <%# string.IsNullOrEmpty(Eval("Rubro")?.ToString()) ? "Sin rubro" : Eval("Rubro") %>
                                </span>
                                <p class="text-muted small mb-1">
                                    <i class="bi bi-upc-scan me-1" style="color:#ff7eb3;"></i>
                                    CUIT: <%# Eval("CUIT") %>
                                </p>
                                <p class="text-muted small mb-1">
                                    <i class="bi bi-envelope-fill me-1" style="color:#ff7eb3;"></i>
                                    <%# string.IsNullOrEmpty(Eval("Email")?.ToString()) ? "Sin email" : Eval("Email") %>
                                </p>
                                <p class="text-muted small mb-1">
                                    <i class="bi bi-telephone-fill me-1" style="color:#ff7eb3;"></i>
                                    <%# string.IsNullOrEmpty(Eval("Telefono")?.ToString()) ? "Sin teléfono" : Eval("Telefono") %>
                                </p>
                                <p class="text-muted small mb-0">
                                    <i class="bi bi-geo-alt-fill me-1" style="color:#ff7eb3;"></i>
                                    <%# string.IsNullOrEmpty(Eval("Direccion")?.ToString()) ? "Sin dirección" : Eval("Direccion") %>
                                </p>
                            </div>
                            <div class="card-footer bg-transparent border-0 text-center pb-4 mt-auto" style="border-top: 1px solid rgba(0,0,0,0.05) !important;">
                                <a href='<%# "ProveedoresABM.aspx?id=" + Eval("Id") %>' class="btn-editar">
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
