<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clasificaciones.aspx.cs" Inherits="UnPocoDeHelado.Clasificaciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row mb-4 align-items-center">
            <div class="col-md-8">
                <h2 class="fw-bold" style="background: linear-gradient(45deg, #ff9a9e 0%, #ff7eb3 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                    <i class="bi bi-tags-fill me-2" style="color: #ff7eb3;"></i>Gestion de Clasificaciones
                </h2>
                <p class="text-muted mb-0">Marcas y categorias</p>
            </div>
            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                <asp:Button ID="btnAgregar" runat="server" OnClick="btnAgregar_Click" Text="Nuevo" Enabled="false" CssClass="btn px-4 py-2 text-white fw-bold shadow-sm" style="background: linear-gradient(to right, #ff758c 0%, #ff7eb3 100%); border: none; border-radius: 12px;" />
            </div>
        </div>
        <hr class="mb-4" style="border-color: #fecfef; border-width: 2px;" />

        <div class="row mb-4">
            <div class="col-md-4">
                <label class="form-label">Mostrar</label>
                <asp:DropDownList ID="ddlTipo" CssClass="form-select fw-bold text-white border-0" style="background: linear-gradient(to right, #ff758c 0%, #ff7eb3 100%); border-radius: 12px;" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlTipo_SelectedIndexChanged">
                    <asp:ListItem Value="">Seleccione...</asp:ListItem>
                    <asp:ListItem Value="True">Marca</asp:ListItem>
                    <asp:ListItem Value="False">Categoria</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <div class="row">
            <asp:Repeater ID="rptClasificaciones" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 col-sm-6 mb-4">
                        <div class="card h-100 shadow-sm border-0 rounded-4" style="background: rgba(255, 255, 255, 0.9); backdrop-filter: blur(10px); transition: transform 0.2s;">
                            <div class="card-body text-center">
                                <div class="mb-3">
                                    <i class="bi bi-tag-fill" style="font-size: 4rem; color: #ff758c;"></i>
                                </div>
                                <h5 class="card-title fw-bold" style="color: #4a4a4a; margin-bottom: 0;"><%# Eval("Nombre") %></h5>
                                <span class="badge rounded-pill mt-2 mb-3" style="background-color: #fecfef; color: #ff758c;"><%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %></span>
                            </div>
                            <div class="card-footer bg-transparent border-0 text-center pb-4 mt-auto">
                                <a href='<%# "ClasificacionesABM.aspx?id=" + Eval("Id") %>' class="btn btn-sm px-4 fw-bold" style="background-color: white; border: 2px solid #ff7eb3; color: #ff7eb3; border-radius: 20px; transition: all 0.3s;">
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
