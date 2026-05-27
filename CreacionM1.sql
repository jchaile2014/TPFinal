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

-- dejo las referencias a tablas de sucursal esperando su proxima creacion.