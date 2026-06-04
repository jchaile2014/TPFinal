<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="UnPocoDeHelado.Productos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="container mt-5">
        <div class="row">
            <div class="col-12">
                <h2>Gestión de Productos</h2>
                <hr />
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-12">
                <asp:Button ID="btnAgregar" CssClass="btn btn-success" Text="Nuevo Producto" runat="server" OnClick="btnAgregar_Click" />
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <asp:GridView ID="dgvProductos" CssClass="table table-striped" runat="server"
                    AllowPaging="true" PageSize="10" AutoGenerateColumns="false"
                    DataKeyNames="Id"
                    OnPageIndexChanging="dgvProductos_PageIndexChanging"
                    OnSelectedIndexChanged="dgvProductos_SelectedIndexChanged">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="Categoria" HeaderText="Categoría" />
                        <asp:BoundField DataField="Marca" HeaderText="Marca" />
                        <asp:BoundField DataField="PrecioVenta" HeaderText="Precio" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                        <asp:CheckBoxField DataField="Activo" HeaderText="Activo" />
                        <asp:CommandField ShowSelectButton="true" SelectText="Editar" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
