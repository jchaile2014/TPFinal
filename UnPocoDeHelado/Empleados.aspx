<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Empleados.aspx.cs" Inherits="UnPocoDeHelado.Empleados" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">

        <div class="page-hero d-flex align-items-center justify-content-between flex-wrap gap-3">
            <div class="d-flex align-items-center gap-3" style="z-index:1; position:relative;">
                <i class="bi bi-person-badge page-hero-icon"></i>
                <div>
                    <h2 class="page-hero-title">Gestión de Empleados</h2>
                    <p class="page-hero-sub">Administrá el personal de tu sucursal</p>
                </div>
            </div>
            <div style="z-index:1; position:relative;">
                <asp:LinkButton ID="btnAgregar" runat="server" OnClick="btnAgregar_Click" CssClass="btn btn-hero">
                    <i class="bi bi-plus-circle me-1"></i> Nuevo Empleado
                </asp:LinkButton>
            </div>
        </div>

        <div class="row">
            <asp:Repeater ID="repEmpleados" runat="server" OnItemCommand="repEmpleados_ItemCommand">
                <ItemTemplate>
                    <div class="col-md-4 col-sm-6 mb-4">
                        <div class="list-card h-100">
                            <div class="card-body text-center" style="padding: 1.75rem 1rem 1rem; background: linear-gradient(160deg, #fff0f5 0%, #ffffff 70%);">
                                <div class="mb-3">
                                    <i class="bi bi-person-circle" style="font-size: 4rem; color: #ff758c;"></i>
                                </div>
                                <h5 class="fw-bold mb-0" style="color: #333;"><%# Eval("Nombre") %> <%# Eval("Apellido") %></h5>
                                <span class="badge rounded-pill mt-2 mb-3" style="background-color: #fecfef; color: #ff758c; font-size: 0.75rem; font-weight: 700;">Empleado</span>
                                <p class="text-muted small mb-1">
                                    <i class="bi bi-envelope-fill me-1" style="color:#ff7eb3;"></i>
                                    <%# string.IsNullOrEmpty(Eval("Email")?.ToString()) ? "Sin email" : Eval("Email") %>
                                </p>
                                <p class="text-muted small mb-3">
                                    <i class="bi bi-telephone-fill me-1" style="color:#ff7eb3;"></i>
                                    <%# string.IsNullOrEmpty(Eval("Telefono")?.ToString()) ? "Sin teléfono" : Eval("Telefono") %>
                                </p>
                                <div class="d-flex justify-content-between small px-2 py-2" style="background-color: #fdf5f8; border-radius: 10px;">
                                    <div class="text-center">
                                        <strong style="color: #ff758c;">DNI</strong><br />
                                        <span class="text-muted"><%# Eval("DNI") %></span>
                                    </div>
                                    <div class="text-center">
                                        <strong style="color: #ff758c;">Ingreso</strong><br />
                                        <span class="text-muted"><%# Eval("FechaIngreso", "{0:dd/MM/yyyy}") %></span>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer bg-transparent border-0 text-center pb-4 mt-auto" style="border-top: 1px solid rgba(0,0,0,0.05) !important;">
                                <asp:LinkButton ID="btnEditar" runat="server" CommandName="Editar"
                                    CommandArgument='<%# Eval("Id") %>' CssClass="btn-editar">
                                    <i class="bi bi-pencil-square me-1"></i> Editar
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
