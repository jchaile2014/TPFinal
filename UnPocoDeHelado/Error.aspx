<%@ Page Title="Error" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="UnPocoDeHelado.Error" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5 text-center">
        <h1 class="text-danger">¡Ha ocurrido un error!</h1>
        <hr />
        <asp:Label ID="lblMensajeError" runat="server" CssClass="text-danger fs-5"></asp:Label>
        <br /><br />
        <a href="default.aspx" class="btn btn-primary">Volver al inicio</a>
    </div>

</asp:Content>
