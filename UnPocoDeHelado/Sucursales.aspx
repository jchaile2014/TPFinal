<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Sucursales.aspx.cs" Inherits="UnPocoDeHelado.ListaDeSucursales" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row">
            <div class="col-12">
                <h2>Gestion de Sucursales</h2>
                <hr />
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-12">
                <asp:Button ID="btnAgregar" CssClass="btn btn-success" Text="Nueva Sucursal" runat="server" OnClick="btnAgregar_Click" />
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <asp:GridView ID="dgvSucursales" CssClass="table table-striped" runat="server" 
                    AllowPaging="true" PageSize="10" AutoGenerateColumns="false"
                    DataKeyNames="Id"
                    OnPageIndexChanging="dgvSucursales_PageIndexChanging"
                    OnSelectedIndexChanged="dgvSucursales_SelectedIndexChanged">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="Direccion" HeaderText="Dirección" />
                        <asp:BoundField DataField="Ciudad" HeaderText="Ciudad" />
                        <asp:BoundField DataField="Provincia" HeaderText="Provincia" />
                        <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="FechaApertura" HeaderText="Fecha Apertura" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:CheckBoxField DataField="Activa" HeaderText="Activa" />
                        <asp:CommandField ShowSelectButton="true" SelectText="Editar" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>