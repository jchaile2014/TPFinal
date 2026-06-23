<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Empleados.aspx.cs" Inherits="UnPocoDeHelado.Empleados" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row mb-4 align-items-center">
            <div class="col-md-8">
                <h2 class="fw-bold" style="background: linear-gradient(45deg, #ff9a9e 0%, #ff7eb3 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                    <i class="bi bi-people-fill me-2" style="color: #ff7eb3;"></i>Gestión de Empleados
                </h2>
                <p class="text-muted mb-0">Administra el personal</p>
            </div>
            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                <asp:LinkButton ID="btnAgregar" runat="server" OnClick="btnAgregar_Click" CssClass="btn px-4 py-2 text-white fw-bold shadow-sm" style="background: linear-gradient(to right, #ff758c 0%, #ff7eb3 100%); border: none; border-radius: 12px; transition: transform 0.2s;">
                    <i class="bi bi-plus-circle me-1"></i> Nuevo Empleado
                </asp:LinkButton>
            </div>
        </div>
        <hr class="mb-4" style="border-color: #fecfef; border-width: 2px;" />

        <div class="row">
            <asp:Repeater ID="repEmpleados" runat="server" OnItemCommand="repEmpleados_ItemCommand">
                <ItemTemplate>
                    <div class="col-md-4 col-sm-6 mb-4">
                        <div class="card h-100 shadow-sm border-0 rounded-4" style="background: rgba(255, 255, 255, 0.9); backdrop-filter: blur(10px); transition: transform 0.2s;">
                            <div class="card-body text-center">
                                <div class="mb-3">
                                    <i class="bi bi-person-circle" style="font-size: 4rem; color: #ff758c;"></i>
                                </div>
                                <h5 class="card-title fw-bold" style="color: #4a4a4a; margin-bottom: 0;"><%# Eval("Nombre") %> <%# Eval("Apellido") %></h5>
                                <span class="badge rounded-pill mt-2 mb-3" style="background-color: #fecfef; color: #ff758c;">Sucursal</span>
                                
                                <p class="text-muted small mb-1"><i class="bi bi-envelope-fill me-1" style="color: #ff7eb3;"></i> <%# string.IsNullOrEmpty(Eval("Email")?.ToString()) ? "Sin email" : Eval("Email") %></p>
                                <p class="text-muted small mb-3"><i class="bi bi-telephone-fill me-1" style="color: #ff7eb3;"></i> <%# string.IsNullOrEmpty(Eval("Telefono")?.ToString()) ? "Sin teléfono" : Eval("Telefono") %></p>
                                
                                <div class="d-flex justify-content-between small px-2 py-2" style="background-color: #fdfbfb; border-radius: 10px;">
                                    <div class="text-center">
                                        <strong style="color: #ff758c;">DNI</strong><br /><span class="text-muted"><%# Eval("DNI") %></span>
                                    </div>
                                    <div class="text-center">
                                        <strong style="color: #ff758c;">Ingreso</strong><br /><span class="text-muted"><%# Eval("FechaIngreso", "{0:dd/MM/yyyy}") %></span>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer bg-transparent border-0 text-center pb-4 mt-auto">
                                <asp:LinkButton ID="btnEditar" runat="server" CommandName="Editar" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-sm px-4 fw-bold" style="background-color: white; border: 2px solid #ff7eb3; color: #ff7eb3; border-radius: 20px; transition: all 0.3s;">
                                    <i class="bi bi-pencil-square me-1"></i> Editar
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
    
    <style>
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(255, 117, 140, 0.15) !important;
        }
        .card-footer .btn:hover {
            background: linear-gradient(to right, #ff758c 0%, #ff7eb3 100%) !important;
            color: white !important;
            border-color: transparent !important;
        }
    </style>
</asp:Content>
