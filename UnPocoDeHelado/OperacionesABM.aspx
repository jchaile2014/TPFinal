<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OperacionesABM.aspx.cs" Inherits="UnPocoDeHelado.OperacionesABM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-5 mb-5">

    <div class="op-detail-header mb-4">
        <div class="d-flex align-items-center gap-3">
            <div class="op-detail-icon" id="headerIcon">
                <i class="bi bi-receipt"></i>
            </div>
            <div>
                <h2 id="titulo" runat="server" class="op-detail-title mb-0">Operacion</h2>
                <p class="text-muted mb-0 small">Detalle completo de la operacion</p>
            </div>
        </div>
        <a href="Operaciones.aspx" class="btn-volver">
            <i class="bi bi-arrow-left me-1"></i>Volver
        </a>
    </div>

    <asp:Panel ID="pnlCarga" runat="server">
        <div class="op-form-card mb-4">
            <div class="op-form-card-title">
                <i class="bi bi-plus-circle me-2"></i>Agregar productos
            </div>
            <div class="row g-3 align-items-end">

                <asp:Panel ID="pnlProveedor" runat="server" CssClass="col-md-4">
                    <label class="op-label">Proveedor</label>
                    <asp:DropDownList ID="ddlProveedor" CssClass="op-select" runat="server"
                        AutoPostBack="true" OnSelectedIndexChanged="ddlProveedor_SelectedIndexChanged">
                    </asp:DropDownList>
                </asp:Panel>

                <asp:Panel ID="pnlCliente" runat="server" CssClass="col-md-4">
                    <label class="op-label">Cliente</label>
                    <asp:DropDownList ID="ddlCliente" CssClass="op-select" runat="server">
                    </asp:DropDownList>
                </asp:Panel>

                <div class="col-md-4">
                    <label class="op-label">Producto</label>
                    <asp:DropDownList ID="ddlProducto" CssClass="op-select" runat="server"
                        AutoPostBack="true" OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>

                <div class="col-md-3">
                    <label class="op-label">Stock actual</label>
                    <asp:TextBox ID="txtStock" CssClass="op-input" runat="server" ReadOnly="true"></asp:TextBox>
                </div>

                <div class="col-md-3">
                    <label class="op-label">Cantidad</label>
                    <asp:TextBox ID="txtCantidad" CssClass="op-input" TextMode="Number" runat="server"></asp:TextBox>
                </div>

                <div class="col-md-3">
                    <label class="op-label">Precio unitario</label>
                    <asp:TextBox ID="txtPrecioUnit" CssClass="op-input" TextMode="Number" runat="server"></asp:TextBox>
                </div>

                <asp:Panel ID="pnlMedioPago" runat="server" CssClass="col-md-3">
                    <label class="op-label">Medio de pago</label>
                    <asp:DropDownList ID="ddlMedioPago" CssClass="op-select" runat="server">
                    </asp:DropDownList>
                </asp:Panel>

                <div class="col-md-3">
                    <asp:Button ID="btnAgregarDetalle" CssClass="btn-agregar w-100" Text="+ Agregar" runat="server" OnClick="btnAgregarDetalle_Click" />
                </div>

            </div>
            <asp:Label ID="lblMensaje" runat="server" CssClass="msg-error mt-2 d-block"></asp:Label>
        </div>
    </asp:Panel>

    <div class="op-table-card mb-4">
        <div class="op-table-header">
            <i class="bi bi-list-ul me-2"></i>Detalle de productos
        </div>
        <div class="table-responsive">
            <asp:GridView ID="dgvDetalle" CssClass="op-table" runat="server" AutoGenerateColumns="false"
                GridLines="None">
                <EmptyDataTemplate>
                    <div class="empty-table-msg">
                        <i class="bi bi-inbox" style="font-size:2.5rem; color:#fecfef;"></i>
                        <p class="text-muted mt-2 mb-0">Aun no hay productos en el detalle.</p>
                    </div>
                </EmptyDataTemplate>
                <HeaderStyle CssClass="op-table-head" />
                <RowStyle CssClass="op-table-row" />
                <AlternatingRowStyle CssClass="op-table-row-alt" />
                <Columns>
                    <asp:TemplateField HeaderText="Producto">
                        <ItemTemplate>
                            <span class="fw-semibold" style="color:#333;"><%# Eval("Producto.Nombre") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                    <asp:BoundField DataField="PrecioUnitario" HeaderText="P. Unit." DataFormatString="{0:C}" />
                    <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C}" />
                </Columns>
            </asp:GridView>
        </div>
        <div class="op-total-row">
            <span class="op-total-label">Total</span>
            <span class="op-total-value"><asp:Label ID="lblTotal" runat="server" Text="$ 0,00"></asp:Label></span>
        </div>
    </div>

    <div class="op-actions">
        <asp:Button ID="btnGuardar" CssClass="btn-confirmar" Text="Confirmar operacion" runat="server" OnClick="btnGuardar_Click" />
        <asp:Button ID="btnCancelar" CssClass="btn-cancelar" Text="Cancelar" runat="server" OnClick="btnCancelar_Click" CausesValidation="false" />
    </div>

</div>

<style>
    .op-detail-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 1rem;
        background: rgba(255,255,255,0.9);
        border-radius: 16px;
        padding: 1.25rem 1.75rem;
        box-shadow: 0 4px 20px rgba(255,117,140,0.08);
        border: 1px solid rgba(255,126,179,0.15);
    }
    .op-detail-icon {
        width: 56px; height: 56px; border-radius: 14px;
        background: linear-gradient(135deg, #ff758c, #ff7eb3);
        display: flex; align-items: center; justify-content: center;
        font-size: 1.6rem; color: white;
        box-shadow: 0 6px 16px rgba(255,117,140,0.35);
        flex-shrink: 0;
    }
    .op-detail-title {
        font-size: 1.5rem; font-weight: 800; color: #333;
    }
    .btn-volver {
        display: inline-flex; align-items: center;
        border: 2px solid #e0e0e0; color: #888;
        border-radius: 50px; padding: 0.45rem 1.2rem;
        font-weight: 600; font-size: 0.88rem;
        text-decoration: none; transition: all 0.25s;
    }
    .btn-volver:hover { border-color: #ff7eb3; color: #ff7eb3; }
    .op-form-card {
        background: rgba(255,255,255,0.95);
        border-radius: 16px;
        padding: 1.5rem;
        box-shadow: 0 4px 20px rgba(255,117,140,0.07);
        border: 1px solid rgba(255,126,179,0.12);
    }
    .op-form-card-title {
        font-weight: 700; font-size: 1rem; color: #555;
        margin-bottom: 1.2rem;
        padding-bottom: 0.75rem;
        border-bottom: 2px dashed #fecfef;
    }
    .op-label {
        font-size: 0.82rem; font-weight: 700; color: #888;
        text-transform: uppercase; letter-spacing: 0.04em;
        margin-bottom: 0.3rem; display: block;
    }
    .op-input, .op-select {
        width: 100%; padding: 0.65rem 0.9rem;
        border: 1.5px solid #e8e0f0; border-radius: 10px;
        font-size: 0.92rem; outline: none; transition: all 0.25s;
        background: white; color: #333;
    }
    .op-input:focus, .op-select:focus {
        border-color: #ff7eb3;
        box-shadow: 0 0 0 3px rgba(255,126,179,0.15);
    }
    .op-input[readonly] { background: #fafafa; color: #999; }
    .btn-agregar {
        background: linear-gradient(to right, #ff758c, #ff7eb3);
        border: none; color: white; font-weight: 700;
        padding: 0.65rem 1rem; border-radius: 10px;
        cursor: pointer; transition: all 0.3s; font-size: 0.92rem;
    }
    .btn-agregar:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(255,117,140,0.4); color: white; }
    .msg-error { color: #e53e3e; font-size: 0.88rem; font-weight: 600; }
    .op-table-card {
        background: rgba(255,255,255,0.95);
        border-radius: 16px;
        box-shadow: 0 4px 20px rgba(255,117,140,0.07);
        border: 1px solid rgba(255,126,179,0.12);
        overflow: hidden;
    }
    .op-table-header {
        background: linear-gradient(to right, #ff9a9e22, #fecfef44);
        padding: 1rem 1.5rem;
        font-weight: 700; font-size: 0.95rem; color: #c05070;
        border-bottom: 2px solid #fecfef;
    }
    .op-table {
        width: 100%; margin: 0; font-size: 0.9rem;
        border-collapse: separate; border-spacing: 0;
    }
    .op-table th {
        background: #fff5f8 !important;
        color: #c05070 !important; font-weight: 700;
        padding: 0.9rem 1.2rem; font-size: 0.8rem;
        text-transform: uppercase; letter-spacing: 0.05em;
        border-bottom: 2px solid #fecfef;
    }
    .op-table-row td, .op-table-row-alt td {
        padding: 0.85rem 1.2rem; vertical-align: middle;
        border-bottom: 1px solid #fff0f5;
        transition: background 0.2s;
    }
    .op-table-row-alt td { background: #fffbfd; }
    .op-table tr:hover td { background: #fff5f8; }
    .empty-table-msg {
        text-align: center; padding: 2.5rem 1rem;
    }
    .op-total-row {
        display: flex; justify-content: flex-end; align-items: center;
        gap: 1rem; padding: 1rem 1.5rem;
        border-top: 2px solid #fecfef;
        background: linear-gradient(to right, transparent, #fff5f8);
    }
    .op-total-label { font-size: 0.85rem; font-weight: 700; color: #999; text-transform: uppercase; letter-spacing: 0.05em; }
    .op-total-value { font-size: 1.5rem; font-weight: 900; background: linear-gradient(45deg, #ff758c, #ff7eb3); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
    .op-actions { display: flex; gap: 0.75rem; flex-wrap: wrap; }
    .btn-confirmar {
        background: linear-gradient(to right, #ff758c, #ff7eb3);
        border: none; color: white; font-weight: 700;
        padding: 0.75rem 2rem; border-radius: 12px;
        cursor: pointer; transition: all 0.3s; font-size: 0.95rem;
    }
    .btn-confirmar:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(255,117,140,0.4); color: white; }
    .btn-cancelar {
        background: white; border: 2px solid #e0e0e0; color: #888;
        font-weight: 600; padding: 0.73rem 1.6rem; border-radius: 12px;
        cursor: pointer; transition: all 0.25s; font-size: 0.95rem;
    }
    .btn-cancelar:hover { border-color: #ff7eb3; color: #ff7eb3; }
</style>

</asp:Content>
