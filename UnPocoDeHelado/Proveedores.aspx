<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="UnPocoDeHelado.Proveedores" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container mt-5">
        <div class="row"><div class="col-12"><h2>Gestión de Proveedores</h2><hr /></div></div>
        <div class="row mb-3"><div class="col-12">
            <asp:Button ID="btnAgregar" CssClass="btn btn-success" Text="Nuevo Proveedor" runat="server" OnClick="btnAgregar_Click" />
        </div></div>
        <div class="row"><div class="col-12">
            <asp:GridView ID="dgvProveedores" CssClass="table table-striped" runat="server"
                AllowPaging="true" PageSize="10" AutoGenerateColumns="false" DataKeyNames="Id"
                OnPageIndexChanging="dgvProveedores_PageIndexChanging"
                OnSelectedIndexChanged="dgvProveedores_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="CUIT" HeaderText="CUIT" />
                    <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Direccion" HeaderText="Dirección" />
                    <asp:BoundField DataField="Rubro" HeaderText="Rubro" />
                    <asp:CheckBoxField DataField="Activo" HeaderText="Activo" />
                    <asp:CommandField ShowSelectButton="true" SelectText="Editar" />
                </Columns>
            </asp:GridView>
        </div></div>
    </div>
</asp:Content>
