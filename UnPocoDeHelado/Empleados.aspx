<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Empleados.aspx.cs" Inherits="UnPocoDeHelado.Empleados" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row">
            <div class="col-12">
                <h2>Gestión de Empleados</h2>
                <hr />
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-12">
                <asp:Button ID="btnAgregar" CssClass="btn btn-success" Text="Nuevo Empleado" runat="server" OnClick="btnAgregar_Click" />
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <asp:GridView ID="dgvEmpleados" CssClass="table table-striped" runat="server" 
                    AllowPaging="true" PageSize="10" AutoGenerateColumns="false"
                    DataKeyNames="Id"
                    OnPageIndexChanging="dgvEmpleados_PageIndexChanging"
                    OnSelectedIndexChanged="dgvEmpleados_SelectedIndexChanged">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                        <asp:BoundField DataField="DNI" HeaderText="DNI" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                        <asp:BoundField DataField="Sucursal.Nombre" HeaderText="Sucursal" />
                        <asp:BoundField DataField="FechaIngreso" HeaderText="Fecha Ingreso" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Salario" HeaderText="Salario" DataFormatString="{0:C}" />
                        <asp:CheckBoxField DataField="Activo" HeaderText="Activo" />
                        <asp:CommandField ShowSelectButton="true" SelectText="Editar" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
