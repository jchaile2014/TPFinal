<%@ Page Title="Factura" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Factura.aspx.cs" Inherits="UnPocoDeHelado.Factura" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        @media print {
            .no-print { display: none !important; }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 mb-5">
        <div class="card shadow-sm border-0 rounded-4 p-4">
            <div class="text-center mb-4">
                <h2 class="fw-bold" style="color: #ff758c;">Un Poco De Helado</h2>
                <h4>Factura N&deg; <asp:Label ID="lblNumero" runat="server"></asp:Label></h4>
            </div>
            <div class="row mb-3">
                <div class="col-6"><strong>Fecha:</strong> <asp:Label ID="lblFecha" runat="server"></asp:Label></div>
                <div class="col-6 text-end"><strong>Cliente:</strong> <asp:Label ID="lblCliente" runat="server"></asp:Label></div>
            </div>
            <asp:GridView ID="dgvDetalle" CssClass="table table-striped align-middle" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField HeaderText="Producto"><ItemTemplate><%# Eval("Producto.Nombre") %></ItemTemplate></asp:TemplateField>
                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                    <asp:BoundField DataField="PrecioUnitario" HeaderText="P. Unit." DataFormatString="{0:C}" />
                    <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C}" />
                </Columns>
            </asp:GridView>
            <div class="text-end mt-3">
                <h4 class="fw-bold" style="color: #ff758c;">Total: <asp:Label ID="lblTotal" runat="server"></asp:Label></h4>
            </div>
            <div class="mt-4 no-print">
                <asp:Button ID="btnImprimir" CssClass="btn px-4 py-2 text-white fw-bold shadow-sm" style="background: linear-gradient(to right, #ff758c 0%, #ff7eb3 100%); border: none; border-radius: 12px;" Text="Imprimir" runat="server" OnClientClick="window.print(); return false;" />
                <asp:Button ID="btnVolver" CssClass="btn btn-light fw-bold" style="border: 2px solid #ff7eb3; color: #ff7eb3; border-radius: 12px;" Text="Volver" runat="server" OnClick="btnVolver_Click" />
            </div>
        </div>
    </div>
</asp:Content>
