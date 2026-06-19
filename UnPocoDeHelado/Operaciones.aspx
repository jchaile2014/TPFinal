<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Operaciones.aspx.cs" Inherits="UnPocoDeHelado.Operaciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row mb-4 align-items-center">
            <div class="col-md-7">
                <h2 class="fw-bold" style="background: linear-gradient(45deg, #ff9a9e 0%, #ff7eb3 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                    <i class="bi bi-cart3 me-2" style="color: #ff7eb3;"></i>Operaciones
                </h2>
                <p class="text-muted mb-0">Ventas y compras</p>
            </div>
            <div class="col-md-5 text-md-end mt-3 mt-md-0">
                <asp:Button ID="btnNuevaVenta" runat="server" OnClick="btnNuevaVenta_Click" Text="Nueva Venta" CssClass="btn px-4 py-2 text-white fw-bold shadow-sm" style="background: linear-gradient(to right, #ff758c 0%, #ff7eb3 100%); border: none; border-radius: 12px;" />
                <asp:Button ID="btnNuevaCompra" runat="server" OnClick="btnNuevaCompra_Click" Text="Nueva Compra" CssClass="btn px-4 py-2 fw-bold" style="background-color: white; border: 2px solid #ff7eb3; color: #ff7eb3; border-radius: 12px;" />
            </div>
        </div>
        <hr class="mb-4" style="border-color: #fecfef; border-width: 2px;" />

        <div class="row">
            <asp:Repeater ID="rptOperaciones" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 col-sm-6 mb-4">
                        <div class="card h-100 shadow-sm border-0 rounded-4" style="background: rgba(255, 255, 255, 0.9); backdrop-filter: blur(10px); transition: transform 0.2s;">
                            <div class="card-body text-center">
                                <div class="mb-3">
                                    <i class="bi bi-receipt" style="font-size: 4rem; color: #ff758c;"></i>
                                </div>
                                <span class="badge rounded-pill mb-2" style="background-color: #fecfef; color: #ff758c;"><%# Convert.ToBoolean(Eval("SeOpera")) ? "Venta" : "Compra" %></span>
                                <h5 class="card-title fw-bold" style="color: #4a4a4a; margin-bottom: 0;"><%# string.IsNullOrEmpty(Eval("NumeroFactura")?.ToString()) ? "Sin factura" : Eval("NumeroFactura") %></h5>
                                <p class="text-muted small mt-2 mb-1"><i class="bi bi-calendar-event me-1" style="color: #ff7eb3;"></i> <%# Eval("Fecha", "{0:dd/MM/yyyy}") %></p>
                                <p class="text-muted small mb-1"><i class="bi bi-cash-coin me-1" style="color: #ff7eb3;"></i> <%# Eval("Total", "{0:C}") %></p>
                                <p class="text-muted small mb-3"><i class="bi bi-info-circle me-1" style="color: #ff7eb3;"></i> <%# Eval("Estado") %></p>
                            </div>
                            <div class="card-footer bg-transparent border-0 text-center pb-4 mt-auto">
                                <a href='<%# "OperacionesABM.aspx?id=" + Eval("Id") %>' class="btn btn-sm px-4 fw-bold" style="background-color: white; border: 2px solid #ff7eb3; color: #ff7eb3; border-radius: 20px; transition: all 0.3s;">
                                    <i class="bi bi-eye me-1"></i> Ver
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
