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
            font-size: 4rem;
            font-weight: 900;
            background: linear-gradient(135deg, #ff0844 0%, #ffb199 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 1rem;
            filter: drop-shadow(0 4px 6px rgba(0,0,0,0.25));
            letter-spacing: -1px;
        }
        .icecream-subtitle {
            font-size: 1.25rem;
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 2rem;
            text-shadow: 0 2px 4px rgba(255,255,255,0.9);
            line-height: 1.6;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.65);
            backdrop-filter: blur(20px) saturate(180%);
            -webkit-backdrop-filter: blur(20px) saturate(180%);
            border-radius: 24px;
            padding: 3rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25), 
                        inset 0 0 0 1px rgba(255, 255, 255, 0.7);
            border: none;
            position: relative;
            overflow: hidden;
        }
        .login-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.8) 0%, rgba(255,255,255,0) 70%);
            transform: rotate(30deg);
            pointer-events: none;
            z-index: 0;
        }
        .login-card > * {
            position: relative;
            z-index: 1;
        }
        .btn-custom {
            background: linear-gradient(135deg, #ff0844 0%, #ffb199 100%);
            border: none;
            color: white;
            font-weight: 700;
            font-size: 1.05rem;
            padding: 0.9rem;
            border-radius: 12px;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(255, 8, 68, 0.3);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .btn-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(255, 8, 68, 0.4);
            color: white;
        }
        .form-control-custom {
            border-radius: 12px;
            padding: 0.9rem 1.2rem;
            border: 2px solid transparent;
            background-color: rgba(255, 255, 255, 0.9);
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }
        .form-control-custom:focus {
            border-color: #ff0844;
            background-color: #fff;
            box-shadow: 0 4px 15px rgba(255, 8, 68, 0.15);
            outline: none;
        }
        .login-title {
            font-size: 2.2rem;
            font-weight: 800;
            background: linear-gradient(135deg, #ff0844 0%, #ffb199 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
            letter-spacing: -0.5px;
        }
        .login-subtitle {
            font-size: 0.95rem;
            color: #8c98a4;
            font-weight: 500;
            letter-spacing: 0.2px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="hero-section row m-0">
            <div class="col-lg-7 hero-text">
                <span class="badge bg-danger rounded-pill mb-3 px-3 py-2" style="background-color: #ff758c !important;">Sistema de Gestión</span>
                <h1 class="icecream-title">Un Poco De Helado</h1>
                <p class="icecream-subtitle">
                    Bienvenido al sistema administrativo. Vas a poder gestionar tus ventas, compras, productos, empleados y mucho más. 
                    Por favor, iniciá sesión para acceder a las funcionalidades del sistema.
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
                <asp:Panel ID="pnlLogin" runat="server" CssClass="login-card w-100">
                    <div class="text-center mb-4">
                        <h3 class="login-title">Iniciar Sesión</h3>
                        <p class="login-subtitle">Ingresá tus credenciales para continuar</p>
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
                        <a href="OlvideClave.aspx" class="text-decoration-none small" style="color: #ff7eb3;"><i class="bi bi-key me-1"></i>Olvidé mi clave</a>
                    </div>

                    <div class="d-grid gap-2">
                        <asp:Button ID="btnLogin" runat="server" Text="Ingresar" CssClass="btn btn-custom w-100" OnClick="btnLogin_Click" />
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlLogueado" runat="server" CssClass="login-card w-100 text-center" Visible="false">
                    <i class="bi bi-check-circle-fill" style="font-size: 3rem; color: #ff7eb3;"></i>
                    <h3 class="fw-bold mt-3" style="color: #4a4a4a;">Ya iniciaste sesión</h3>
                    <p class="text-muted mb-1">Usuario: <strong><asp:Label ID="lblUsuario" runat="server"></asp:Label></strong></p>
                    <p class="text-muted mb-4">Rol: <strong><asp:Label ID="lblRol" runat="server"></asp:Label></strong></p>
                    <div class="d-grid gap-2">
                        <asp:Button ID="btnSalirDefault" runat="server" Text="Salir" CssClass="btn btn-custom w-100" OnClick="btnSalirDefault_Click" />
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>
