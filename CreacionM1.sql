-- =============================================================
-- TPI Base de Datos II - Sistema de UnPocoDeHelado
-- Script: CreacionM1.sql
-- Descripción: primera parte de la Creación de la base de datos
-- Módulo 1 de Empleados: Empleado, Usuario, Perfil, Rol
-- =============================================================

CREATE DATABASE UnPocoDeHelado;
GO

USE UnPocoDeHelado;
GO

-- Perfil
CREATE TABLE Perfil (
    Id          INT IDENTITY(1,1) PRIMARY KEY,
    Nombre      VARCHAR(40)  NOT NULL UNIQUE, 
    Descripcion VARCHAR(255) NULL
);

CREATE TABLE Rol (
    Id          INT IDENTITY(1,1) PRIMARY KEY,
    Nombre      VARCHAR(50)  NOT NULL UNIQUE,
    Descripcion VARCHAR(255) NULL
);
-- Sucursal
CREATE TABLE Empleado (
    Id            BIGINT IDENTITY(1,1) PRIMARY KEY,
    Nombre        VARCHAR(50)   NOT NULL,
    Apellido      VARCHAR(50)   NOT NULL,
    DNI           VARCHAR(15)   NOT NULL UNIQUE,
    Email         VARCHAR(100)  NULL,
    Telefono      VARCHAR(30)   NULL,
    IdSucursal    BIGINT        NOT NULL,
    IdRol         INT           NOT NULL,
    FechaIngreso  DATE          NOT NULL,
    Salario       DECIMAL(10,2) NULL CHECK (Salario IS NULL OR Salario >= 0),
    Activo        BIT           NOT NULL DEFAULT 1,
    CONSTRAINT FK_Empleado_Sucursal FOREIGN KEY (IdSucursal) REFERENCES Sucursal(Id),
    CONSTRAINT FK_Empleado_Rol      FOREIGN KEY (IdRol)      REFERENCES Rol(Id)
);

CREATE TABLE Usuario (
    Id             BIGINT IDENTITY(1,1) PRIMARY KEY,
    Nombre         VARCHAR(50)  NOT NULL UNIQUE,
    Pass           VARCHAR(255) NOT NULL,
    IdEmpleado     BIGINT       NOT NULL,
    IdPerfil       INT          NOT NULL,
    Activo         BIT          NOT NULL DEFAULT 1,
    CONSTRAINT FK_Usuario_Empleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado(Id),
    CONSTRAINT FK_Usuario_Perfil   FOREIGN KEY (IdPerfil)   REFERENCES Perfil(Id)
);
-- Catalogo
CREATE TABLE Categoria (
    Id          INT IDENTITY(1,1) PRIMARY KEY,
    Nombre      VARCHAR(50)  NOT NULL UNIQUE,
    Descripcion VARCHAR(255) NULL,
    Activa      BIT NOT NULL DEFAULT 1
);

CREATE TABLE TipoProducto (
    Id           INT IDENTITY(1,1) PRIMARY KEY,
    Nombre       VARCHAR(50) NOT NULL,
    IdCategoria  INT         NOT NULL,
    Activo       BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_TipoProducto_Categoria FOREIGN KEY (IdCategoria) REFERENCES Categoria(Id),
    CONSTRAINT UQ_TipoProducto_Categoria UNIQUE (IdCategoria, Nombre)
);

CREATE TABLE Marca (
    Id     INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(80) NOT NULL UNIQUE,
    Activa BIT NOT NULL DEFAULT 1
);

CREATE TABLE Producto (
    Id                 BIGINT IDENTITY(1,1) PRIMARY KEY,
    Nombre             VARCHAR(80)   NOT NULL,
    IdCategoria        INT           NOT NULL,
    IdTipoProducto     INT           NULL,
    IdMarca            INT           NULL,
    PrecioVenta        DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (PrecioVenta >= 0),
    PorcentajeGanancia DECIMAL(6,2)  NOT NULL DEFAULT 0
                          CHECK (PorcentajeGanancia >= -100 AND PorcentajeGanancia <= 10000),
    StockMinimo        DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (StockMinimo >= 0),
    Descripcion        VARCHAR(255)  NULL,
    Activo             BIT           NOT NULL DEFAULT 1,
    CONSTRAINT FK_Producto_Categoria    FOREIGN KEY (IdCategoria)    REFERENCES Categoria(Id),
    CONSTRAINT FK_Producto_TipoProducto FOREIGN KEY (IdTipoProducto) REFERENCES TipoProducto(Id),
    CONSTRAINT FK_Producto_Marca        FOREIGN KEY (IdMarca)        REFERENCES Marca(Id)
);
-- Stock
CREATE TABLE Stock (
    IdSucursal          BIGINT NOT NULL,
    IdProducto          BIGINT NOT NULL,
    Cantidad            DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (Cantidad >= 0),
    FechaActualizacion  DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Stock PRIMARY KEY (IdSucursal, IdProducto),
    CONSTRAINT FK_Stock_Sucursal FOREIGN KEY (IdSucursal) REFERENCES Sucursal(Id),
    CONSTRAINT FK_Stock_Producto FOREIGN KEY (IdProducto) REFERENCES Producto(Id)
);

-- Debemos seguir con Proveedores
