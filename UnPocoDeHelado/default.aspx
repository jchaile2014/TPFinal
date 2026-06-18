<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="UnPocoDeHelado._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .hero-section {
            background: linear-gradient(135deg, rgba(255, 245, 248, 0.6) 0%, rgba(255, 255, 255, 0.1) 100%), url('Images/hero-bg.png');
            background-size: cover;
            background-position: center;
            min-height: 80vh;
            display: flex;
            align-items: center;
            border-radius: 15px;
            margin-top: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .hero-text {
            padding: 3rem;
        }
        .icecream-title {
            font-size: 3.5rem;
            font-weight: 800;
            background: linear-gradient(45deg, #ff9a9e 0%, #fecfef 99%, #fecfef 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 1rem;
        }
        .icecream-subtitle {
            font-size: 1.2rem;
            color: #6c757d;
            margin-bottom: 2rem;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            border: 1px solid rgba(255,255,255,0.5);
        }
        .btn-custom {
            background: linear-gradient(to right, #ff758c 0%, #ff7eb3 100%);
            border: none;
            color: white;
            font-weight: 600;
            padding: 0.8rem;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(255, 117, 140, 0.4);
            color: white;
        }
        .form-control-custom {
            border-radius: 10px;
            padding: 0.8rem;
            border: 1px solid #e0e0e0;
        }
        .form-control-custom:focus {
            border-color: #ff7eb3;
            box-shadow: 0 0 0 0.2rem rgba(255, 126, 179, 0.25);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="hero-section row m-0">
            <div class="col-lg-7 hero-text">
                <span class="badge bg-danger rounded-pill mb-3 px-3 py-2" style="background-color: #ff758c !important;">Sistema de Gestion</span>
                <h1 class="icecream-title">Un Poco De Helado</h1>
                <p class="icecream-subtitle">
                    Bienvenido al sistema administrativo. Vas a poder gestionar tus ventas, compras, productos, empleados y mucho mas. 
                    Por favor, inicia sesion para acceder a las funcionalidades del sistema.
                </p>
                <div class="d-flex gap-3 mt-4">
                    <div class="d-flex align-items-center gap-2 text-muted">
                        <i class="bi bi-shield-check" style="font-size: 1.5rem; color: #ff7eb3;"></i>
                        <span></span>
                    </div>
                    <div class="d-flex align-items-center gap-2 text-muted">
                        <i class="bi bi-speedometer2" style="font-size: 1.5rem; color: #ff7eb3;"></i>
                        <span></span>
                    </div>
                </div>
            </div>

            <div class="col-lg-5 p-4 p-lg-5 d-flex justify-content-center">
                <div class="login-card w-100">
                    <div class="text-center mb-4">
                        <h3 class="fw-bold" style="color: #4a4a4a;">Iniciar Sesion</h3>
                        <p class="text-muted small">Ingresa tus credenciales para continuar</p>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-secondary">Usuario</label>
                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control form-control-custom" placeholder="Ej. admin"></asp:TextBox>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label fw-semibold text-secondary">Clave</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control form-control-custom" TextMode="Password" placeholder="********"></asp:TextBox>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="chkRecordar">
                            <label class="form-check-label text-muted small" for="chkRecordar">Recordarme</label>
                        </div>
                        <a href="#" class="text-decoration-none small" style="color: #ff7eb3;"> Olvide mi clave</a>
                    </div>
                    
                    <div class="d-grid gap-2">
                       <asp:Button ID="btnLogin" runat="server" Text="Ingresar" CssClass="btn btn-custom w-100" OnClick="btnLogin_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
