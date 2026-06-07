-- =============================================================
-- TPI Base de Datos II - Sistema de UnPocoDeHelado
-- Script: CreacionM1.sql
-- Descripción: primera parte de la Creación de la base de datos
-- Módulo 1 de Empleados: Empleado, Usuario y Rol
-- Modulo 2 de productos: Producto, Categoria, Stock y Sucursal
-- Modulo 3 de ventas y pedidos: Cliente, Venta, DetalleVenta, Mesa, Pedido, DetallePedido y MedioPago
-- Modulo 4 de compras: Proveedor, Compra, DetalleCompra y ProductoProveedor
-- =============================================================


Create Database UnPocoDeHelado;
GO
Use UnPocoDeHelado;
GO

Create Table Rol (
    Id          Int Identity(1,1) Primary Key,
    Nombre      Varchar(50)  Not Null Unique,
    Descripcion Varchar(255) Null
);
GO

Create Table MedioPago (
    Id     Int Identity(1,1) Primary Key,
    Nombre Varchar(40) Not Null Unique,
    Activo Bit Not Null Default 1
);
GO

Create Table Clasificacion (
    Id          Bigint Identity(1,1) Primary Key,
    Nombre      Varchar(50) Not Null,
    SeClasifica Bit Not Null,
    Activo      Bit Not Null Default 1
);
GO

Create Table Cliente (
    Id       Bigint Identity(1,1) Primary Key,
    Nombre   Varchar(50)  Not Null,
    Apellido Varchar(50)  Not Null,
    DNI      Varchar(15)  Null Unique,
    Email    Varchar(100) Null,
    Telefono Varchar(30)  Null
);
GO

Create Table Empleado (
    Id            Bigint Identity(1,1) Primary Key,
    Nombre        Varchar(50)   Not Null,
    Apellido      Varchar(50)   Not Null,
    DNI           Varchar(15)   Not Null Unique,
    Email         Varchar(100)  Null,
    Telefono      Varchar(30)   Null,
    IdSucursal    Bigint        Null,      
    IdRol         Int           Not Null,
    FechaIngreso  Date          Not Null,
    Salario       Decimal(10,2) Null Check (Salario IS Null OR Salario >= 0),
    Activo        Bit           Not Null Default 1,
    Constraint FK_Empleado_Rol Foreign Key (IdRol) References Rol(Id)
);
GO

Create Table Usuario (
    Id            Bigint       Primary Key,
    NombreUsuario Varchar(50)  Not Null Unique,
    Pass          Varchar(255) Not Null,
    Constraint FK_Usuario_Empleado Foreign Key (Id) References Empleado(Id)
);
GO

Create Table Proveedor (
    Id        Bigint Identity(1,1) Primary Key,
    Nombre    Varchar(100) Not Null,
    CUIT      Varchar(15)  Not Null Unique,
    Telefono  Varchar(30)  Null,
    Email     Varchar(100) Null,
    Direccion Varchar(150) Null,
    Rubro     Varchar(80)  Null,
    Activo    Bit          Not Null Default 1
);
GO

Create Table Producto (
    Id                 Bigint Identity(1,1) Primary Key,
    Nombre             Varchar(80)   Not Null,
    Descripcion        Varchar(255)  Null,
    IdMarca            Bigint        Null,         
    IdCategoria        Bigint        Null,         
    Cantidad           Int           Not Null Default 0 Check (Cantidad >= 0),
    StockMinimo        Int           Not Null Default 0 Check (StockMinimo >= 0),
    PorcentajeGanancia Decimal(5,2)  Not Null Default 0 Check (PorcentajeGanancia >= 0),
    PrecioCompraActual Decimal(10,2) Not Null Default 0 Check (PrecioCompraActual >= 0),
    IdSucursal         Bigint        Null,
    Activo             Bit           Not Null Default 1,
    Constraint FK_Producto_Marca     Foreign Key (IdMarca)     References Clasificacion(Id),
    Constraint FK_Producto_Categoria Foreign Key (IdCategoria) References Clasificacion(Id)
);
GO

Create Table ProductoProveedor (
    IdProducto  Bigint Not Null,
    IdProveedor Bigint Not Null,
    Constraint PK_ProductoProveedor Primary Key (IdProducto, IdProveedor),
    Constraint FK_PP_Producto  Foreign Key (IdProducto)  References Producto(Id),
    Constraint FK_PP_Proveedor Foreign Key (IdProveedor) References Proveedor(Id)
);
GO

Create Table Operacion (
    Id            Bigint Identity(1,1) Primary Key,
    SeOpera       Bit Not Null,
    NumeroFactura Varchar(20) Null,               
    Fecha         Datetime Not Null Default GETDATE(),
    IdSucursal    Bigint Null,
    IdCliente     Bigint Null,                    
    IdProveedor   Bigint Null,
    IdEmpleado    Bigint Not Null,
    IdMedioPago   Int Null,
    Estado        Varchar(20) Not Null Default 'Pendiente',
    Total         Decimal(12,2) Not Null Default 0 Check (Total >= 0),
    Constraint FK_Operacion_Cliente   Foreign Key (IdCliente)   References Cliente(Id),
    Constraint FK_Operacion_Proveedor Foreign Key (IdProveedor) References Proveedor(Id),
    Constraint FK_Operacion_Empleado  Foreign Key (IdEmpleado)  References Empleado(Id),
    Constraint FK_Operacion_MedioPago Foreign Key (IdMedioPago) References MedioPago(Id)
);
GO

SET QUOTED_IDENTIFIER ON;
GO
Create Unique Index UQ_Operacion_NumeroFactura
    On Operacion(NumeroFactura) Where NumeroFactura Is Not Null;
GO

Create Table DetalleOperacion (
    Id             Bigint Identity(1,1) Primary Key,
    IdOperacion    Bigint Not Null,
    SeOpera        Bit Not Null,
    IdProducto     Bigint Not Null,
    Cantidad       Int Not Null Check (Cantidad > 0),
    PrecioUnitario Decimal(10,2) Not Null Check (PrecioUnitario >= 0),
    Subtotal       Decimal(12,2) Not Null Check (Subtotal >= 0),
    Constraint FK_DetOp_Operacion Foreign Key (IdOperacion) References Operacion(Id),
    Constraint FK_DetOp_Producto  Foreign Key (IdProducto)  References Producto(Id)
);
GO

Insert Into Rol (Nombre, Descripcion) Values
('Administrador', 'Acceso total'),
('Vendedor',      'Registra ventas');
GO
Insert Into MedioPago (Nombre) Values
('Efectivo'), ('Tarjeta'), ('Transferencia');
GO
