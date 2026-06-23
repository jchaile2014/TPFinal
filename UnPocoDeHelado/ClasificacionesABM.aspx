<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClasificacionesABM.aspx.cs" Inherits="UnPocoDeHelado.ClasificacionesABM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-8">

                <div class="form-card">
                    <div class="text-center mb-5">
                        <i class="bi bi-tags" style="font-size: 3rem; color: #ff7eb3;"></i>
                        <h2 id="titulo" runat="server" class="form-title mt-2">Nueva Clasificación</h2>
                        <p class="text-muted">Completa los datos de la clasificación para registrarla en el sistema</p>
                    </div>

                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="form-label">Nombre</label>
                            <asp:TextBox ID="txtNombre" CssClass="form-control form-control-custom" placeholder="Nombre de la clasificación" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre" CssClass="text-danger" Display="Dynamic" ErrorMessage="El nombre es obligatorio." />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Tipo</label>
                            <asp:DropDownList ID="ddlTipo" CssClass="form-select form-select-custom" runat="server">
                                <asp:ListItem Value="True">Marca</asp:ListItem>
                                <asp:ListItem Value="False">Categoría</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-12 mt-4">
                            <div class="form-check mb-1">
                                <asp:CheckBox ID="chkActivo" CssClass="form-check-input" runat="server" Checked="true" />
                                <label class="form-check-label fw-bold text-secondary" style="font-size: 1rem; cursor: pointer;">Clasificación Activa</label>
                            </div>
                            <small class="text-muted d-block">Si se desactiva, la clasificación no figurará en listados operativos.</small>
                        </div>
                    </div>

                    <hr class="my-5" style="border-color: #fecfef;" />

                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <asp:Button ID="btnEliminar" CssClass="btn btn-danger-custom shadow-sm" Text="Eliminar" runat="server" OnClick="btnEliminar_Click" Visible="false" CausesValidation="false" OnClientClick="return confirm('¿Estás seguro de eliminar esta clasificación?');" />
                        </div>
                        <div class="d-flex gap-3">
                            <asp:Button ID="btnCancelar" CssClass="btn btn-outline-custom" Text="Cancelar" runat="server" OnClick="btnCancelar_Click" CausesValidation="false" />
                            <asp:Button ID="btnGuardar" CssClass="btn btn-gradient shadow-sm" Text="Guardar Cambios" runat="server" OnClick="btnGuardar_Click" />
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>
</asp:Content>
