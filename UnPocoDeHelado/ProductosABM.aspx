<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductosABM.aspx.cs" Inherits="UnPocoDeHelado.ProductosABM" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-8">

                <div class="form-card">
                    <div class="text-center mb-5">
                        <i class="bi bi-box-seam" style="font-size: 3rem; color: #ff7eb3;"></i>
                        <h2 id="titulo" runat="server" class="form-title mt-2">Nuevo Producto</h2>
                        <p class="text-muted">Completa los datos del producto para registrarlo en el sistema</p>
                    </div>

                    <div class="row g-4">
                        <div class="col-12">
                            <label class="form-label">Nombre</label>
                            <asp:TextBox ID="txtNombre" CssClass="form-control form-control-custom" placeholder="Ej. Helado de Chocolate" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre" CssClass="text-danger" Display="Dynamic" ErrorMessage="El nombre es obligatorio." />
                        </div>

                        <div class="col-12">
                            <label class="form-label">Descripcion</label>
                            <asp:TextBox ID="txtDescripcion" CssClass="form-control form-control-custom" TextMode="MultiLine" Rows="3" placeholder="Descripción breve del producto..." runat="server"></asp:TextBox>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Marca</label>
                            <asp:DropDownList ID="ddlMarca" CssClass="form-select form-select-custom" runat="server"></asp:DropDownList>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Categoria</label>
                            <asp:DropDownList ID="ddlCategoria" CssClass="form-select form-select-custom" runat="server"></asp:DropDownList>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Cantidad (stock)</label>
                            <asp:TextBox ID="txtCantidad" CssClass="form-control form-control-custom" TextMode="Number" placeholder="0" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCantidad" CssClass="text-danger" Display="Dynamic" ErrorMessage="La cantidad es obligatoria." />
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtCantidad" ValidationExpression="\d+" CssClass="text-danger" Display="Dynamic" ErrorMessage="La cantidad debe ser un numero entero." />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Stock minimo</label>
                            <asp:TextBox ID="txtStockMinimo" CssClass="form-control form-control-custom" TextMode="Number" placeholder="0" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStockMinimo" CssClass="text-danger" Display="Dynamic" ErrorMessage="El stock minimo es obligatorio." />
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtStockMinimo" ValidationExpression="\d+" CssClass="text-danger" Display="Dynamic" ErrorMessage="El stock minimo debe ser un numero entero." />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">% Ganancia</label>
                            <asp:TextBox ID="txtPorcentaje" CssClass="form-control form-control-custom" TextMode="Number" placeholder="0.00" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPorcentaje" CssClass="text-danger" Display="Dynamic" ErrorMessage="El % de ganancia es obligatorio." />
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPorcentaje" ValidationExpression="\d+([.,]\d{1,2})?" CssClass="text-danger" Display="Dynamic" ErrorMessage="El % de ganancia debe ser un numero valido." />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Precio compra</label>
                            <div class="input-group">
                                <span class="input-group-text" style="border-radius: 10px 0 0 10px; border: 1px solid #e0e0e0; background-color: #fdfbfb;">$</span>
                                <asp:TextBox ID="txtPrecioCompra" CssClass="form-control form-control-custom" style="border-radius: 0 10px 10px 0;" TextMode="Number" placeholder="0.00" runat="server"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPrecioCompra" CssClass="text-danger" Display="Dynamic" ErrorMessage="El precio de compra es obligatorio." />
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPrecioCompra" ValidationExpression="\d+([.,]\d{1,2})?" CssClass="text-danger" Display="Dynamic" ErrorMessage="El precio de compra debe ser un numero valido." />
                        </div>

                        <div class="col-12 mt-4">
                            <div class="form-check mb-1">
                                <asp:CheckBox ID="chkActivo" CssClass="form-check-input" runat="server" Checked="true" />
                                <label class="form-check-label fw-bold text-secondary" style="font-size: 1rem; cursor: pointer;">Producto Activo</label>
                            </div>
                            <small class="text-muted d-block">Si se desactiva, el producto no figurara en listados operativos.</small>
                        </div>
                    </div>

                    <hr class="my-5" style="border-color: #fecfef;" />

                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <asp:Button ID="btnEliminar" CssClass="btn btn-danger-custom shadow-sm" Text="Inactivar" runat="server" OnClick="btnEliminar_Click" Visible="false" CausesValidation="false" OnClientClick="return confirm('¿Estás seguro de inactivar este producto?');" />
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
