<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="UnPocoDeHelado.Clientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row"><div class="col-12"><h2>Gestión de Clientes</h2><hr /></div></div>
        <div class="row mb-3"><div class="col-12">
            <asp:Button ID="btnAgregar" CssClass="btn btn-success" Text="Nuevo Cliente" runat="server" OnClick="btnAgregar_Click" />
        </div></div>
        <div class="row"><div class="col-12">
            <asp:GridView ID="dgvClientes" CssClass="table table-striped" runat="server"
                AllowPaging="true" PageSize="10" AutoGenerateColumns="false" DataKeyNames="Id"
                OnPageIndexChanging="dgvClientes_PageIndexChanging"
                OnSelectedIndexChanged="dgvClientes_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                    <asp:BoundField DataField="DNI" HeaderText="DNI" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                    <asp:CommandField ShowSelectButton="true" SelectText="Editar" />
                </Columns>
            </asp:GridView>
        </div></div>
    </div>
</asp:Content>
