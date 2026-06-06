<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clasificaciones.aspx.cs" Inherits="UnPocoDeHelado.Clasificaciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="container mt-5">
        <div class="row">
            <div class="col-12">
                <h2>Gestión de Clasificaciones</h2>
                <hr />
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-md-4">
                <label class="form-label">Mostrar</label>
                <asp:DropDownList ID="ddlTipo" CssClass="form-select" runat="server"
                    AutoPostBack="true" OnSelectedIndexChanged="ddlTipo_SelectedIndexChanged">
                    <asp:ListItem Value="">Seleccione...</asp:ListItem>
                    <asp:ListItem Value="True">Marca</asp:ListItem>
                    <asp:ListItem Value="False">Categoría</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-12">
                <asp:Button ID="btnAgregar" CssClass="btn btn-success" Text="Nuevo" runat="server" OnClick="btnAgregar_Click" Enabled="false" />
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <asp:GridView ID="dgvClasificaciones" CssClass="table table-striped" runat="server"
                    AllowPaging="true" PageSize="10" AutoGenerateColumns="false"
                    DataKeyNames="Id"
                    OnPageIndexChanging="dgvClasificaciones_PageIndexChanging"
                    OnSelectedIndexChanged="dgvClasificaciones_SelectedIndexChanged">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                        <asp:CheckBoxField DataField="Activo" HeaderText="Activo" />
                        <asp:CommandField ShowSelectButton="true" SelectText="Editar" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
