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

Create Table Sucursal (
    Id              Bigint Identity(1,1) Primary Key,
    Nombre          Varchar(80)  Not Null,
    Direccion       Varchar(150) Not Null,
    Ciudad          Varchar(60)  Not Null,
    Provincia       Varchar(60)  Not Null,
    Telefono        Varchar(30)  Null,
    Email           Varchar(100) Null,
    FechaApertura   Date         Not Null,
    Activa          Bit          Not Null Default 1
);
GO

Create Table Empleado (
    Id            Bigint Identity(1,1) Primary Key,
    Nombre        Varchar(50)   Not Null,
    Apellido      Varchar(50)   Not Null,
    DNI           Varchar(15)   Not Null Unique,
    Email         Varchar(100)  Null,
    Telefono      Varchar(30)   Null,
    IdSucursal    Bigint        Not Null,
    IdRol         Int           Not Null,
    FechaIngreso  Date          Not Null,
    Salario       Decimal(10,2) Null Check (Salario IS Null OR Salario >= 0),
    Activo        Bit           Not Null Default 1,
    Constraint FK_Empleado_Sucursal Foreign Key (IdSucursal) References Sucursal(Id),
    Constraint FK_Empleado_Rol      Foreign Key (IdRol)      References Rol(Id)
);
GO

Create Table Usuario (
    Id             Bigint       Primary Key,
    NombreUsuario  Varchar(50)  Not Null Unique,
    Pass           Varchar(255) Not Null,
    Constraint FK_Usuario_Empleado Foreign Key (Id) References Empleado(Id)
);
GO

Create Table Categoria (
    Id          Int Identity(1,1) Primary Key,
    Nombre      Varchar(50)  Not Null Unique,
    Descripcion Varchar(255) Null,
    Activa      Bit Not Null Default 1
);
GO

Create Table Producto (
    Id                 bigint Identity(1,1) Primary Key,
    Nombre             Varchar(80)   Not Null,
    IdCategoria        Int           Not Null,
    Marca              Varchar(50)   Null,
    PrecioVenta        Decimal(10,2) Not Null Default 0 Check (PrecioVenta >= 0),
    Descripcion        Varchar(255)  Null,
    Activo             Bit           Not Null Default 1,
    Constraint FK_Producto_Categoria    Foreign Key (IdCategoria)    References Categoria(Id),
);
GO

Create Table Stock (
    IdSucursal          Bigint Not Null,
    IdProducto          Bigint Not Null,
    Cantidad            Decimal(10,2) Not Null Default 0 Check (Cantidad >= 0),
    Constraint PK_Stock Primary Key (IdSucursal, IdProducto),
    Constraint FK_Stock_Sucursal Foreign Key (IdSucursal) References Sucursal(Id),
    Constraint FK_Stock_Producto Foreign Key (IdProducto) References Producto(Id)
);
GO

Create Table Mesa (
    Id          Bigint Identity(1,1) Primary Key,
    IdSucursal  Bigint Not Null,
    Numero      Int    Not Null,
    Capacidad   Int    Not Null Check (Capacidad > 0),
    Estado      Varchar(20) Not Null Default 'Libre' Check (Estado In ('Libre', 'Ocupada', 'Reservada')),
    Activa      Bit    Not Null Default 1,
    Constraint FK_Mesa_Sucursal Foreign Key (IdSucursal) References Sucursal(Id),
    Constraint UQ_Mesa_Sucursal_Numero Unique (IdSucursal, Numero)
);
GO

Create Table Cliente (
    Id                Bigint Identity(1,1) Primary Key,
    Nombre            Varchar(50)  Not Null,
    Apellido          Varchar(50)  Not Null,
    DNI               Varchar(15)  Null Unique,
);
GO

SET IDENTITY_INSERT Cliente ON;
INSERT INTO Cliente (Id, Nombre, Apellido) VALUES (1, 'Consumidor', 'Final');
SET IDENTITY_INSERT Cliente OFF;
GO

Create Table MedioPago (
    Id     Int Identity(1,1) Primary Key,
    Nombre Varchar(40) Not Null Unique,
    Activo Bit Not Null Default 1
);
GO

Create Table Venta (
    Id               Bigint Identity(1,1) Primary Key, 
    NumeroFactura    Varchar(20) Null,  
    IdSucursal       Bigint      Not Null,
    IdEmpleadoVende  Bigint      Not Null,
    IdEmpleadoCobra  Bigint      Null,   
    IdCliente        Bigint      Not Null Default 1,
    Fecha            Datetime    Not Null Default GETDATE(),
    IdMedioPago      Int         Null,   
    Estado           Varchar(20) Not Null Default 'Pendiente',
    Total            Decimal(12,2) Not Null Default 0 Check (Total >= 0),
    Constraint FK_Venta_Sucursal       Foreign Key (IdSucursal)      References Sucursal(Id),
    Constraint FK_Venta_EmpleadoVende  Foreign Key (IdEmpleadoVende) References Empleado(Id),
    Constraint FK_Venta_EmpleadoCobra  Foreign Key (IdEmpleadoCobra) References Empleado(Id),
    Constraint FK_Venta_Cliente        Foreign Key (IdCliente)       References Cliente(Id),
    Constraint FK_Venta_MedioPago      Foreign Key (IdMedioPago)     References MedioPago(Id)
);
GO

Create Unique Index Venta_NumeroFactura
    On Venta(NumeroFactura) Where NumeroFactura IS Not Null;
GO

Create Table DetalleVenta (
    Id              Bigint Identity(1,1) Primary Key,
    IdVenta         Bigint Not Null,
    IdProducto      Bigint Not Null,
    Cantidad        Int    Not Null Check (Cantidad > 0),
    PrecioUnitario  Decimal(10,2) Not Null Check (PrecioUnitario >= 0),
    Subtotal        Decimal(12,2) Not Null Check (Subtotal >= 0),
    Constraint FK_DetVenta_Venta    Foreign Key (IdVenta)    References Venta(Id),
    Constraint FK_DetVenta_Producto Foreign Key (IdProducto) References Producto(Id)
);
GO

Create Table Pedido (
    Id          Bigint Identity(1,1) Primary Key,
    IdMesa      Bigint   Not Null,
    IdEmpleado  Bigint   Not Null,
    Fecha       Datetime Not Null Default GETDATE(),
    Estado      Varchar(20) Not Null Default 'Abierto' Check (Estado In ('Abierto', 'Cerrado', 'Cancelado')),
    IdVenta     Bigint   Null,
    Constraint FK_Pedido_Mesa     Foreign Key (IdMesa)     References Mesa(Id),
    Constraint FK_Pedido_Empleado Foreign Key (IdEmpleado) References Empleado(Id),
    Constraint FK_Pedido_Venta    Foreign Key (IdVenta)    References Venta(Id)
);
GO

Create Table DetallePedido (
    Id              Bigint Identity(1,1) Primary Key,
    IdPedido        Bigint Not Null,
    IdProducto      Bigint Not Null,
    Cantidad        Decimal    Not Null Check (Cantidad > 0),
    PrecioUnitario  Decimal(10,2) Not Null Check (PrecioUnitario >= 0),
    Subtotal        Decimal(12,2) Not Null Check (Subtotal >= 0),
    Observacion     Varchar(255) Null,
    Constraint FK_DetPedido_Pedido   Foreign Key (IdPedido)   References Pedido(Id),
    Constraint FK_DetPedido_Producto Foreign Key (IdProducto) References Producto(Id)
);
GO

Create Table  Proveedor (
    Id        Bigint Identity(1,1) PRIMARY KEY,
    Nombre    Varchar(100) Not Null,
    CUIT      Varchar(15)  Not Null Unique,
    Telefono  Varchar(30)  Null,
    Email     Varchar(100) Null,
    Direccion Varchar(150) Null,
    Rubro     Varchar(80)  Null,
    Activo    Bit          Not Null Default  1
);
GO

Create Table ProductoProveedor (
    IdProducto          Bigint Not Null,
    IdProveedor         Bigint Not Null,
    UltimaFechaCompra   Date   Null,
    UltimoPrecioCompra  Decimal(10,2) Null,
    Constraint PK_ProductoProveedor PRIMARY KEY (IdProducto, IdProveedor),
    Constraint FK_PP_Producto  Foreign Key (IdProducto)  References Producto(Id),
    Constraint FK_PP_Proveedor Foreign Key (IdProveedor) References Proveedor(Id)
);
GO

Create Table Compra (
    Id           Bigint Identity(1,1) PRIMARY KEY,
    IdProveedor  Bigint   Not Null,
    IdSucursal   Bigint   Not Null,
    IdEmpleado   Bigint   Not Null,
    Fecha        Datetime Not Null Default GETDATE(),
    Total        Decimal(12,2) Not Null Default 0 Check (Total >= 0),
    Estado       Varchar(20)   Not Null Default 'Pendiente' Check (Estado In ('Pendiente', 'Finalizado', 'Cancelado')),
    Constraint FK_Compra_Proveedor Foreign Key (IdProveedor) References Proveedor(Id),
    Constraint FK_Compra_Sucursal  Foreign Key (IdSucursal)  References Sucursal(Id),
    Constraint FK_Compra_Empleado  Foreign Key (IdEmpleado)  References Empleado(Id)
);
GO  

Create Table DetalleCompra (
    Id              Bigint IDENTITY(1,1) PRIMARY KEY,
    IdCompra        Bigint Not Null,
    IdProducto      Bigint Not Null,
    Cantidad        Decimal(10,2) Not Null Check (Cantidad > 0),
    PrecioUnitario  Decimal(10,2) Not Null Check (PrecioUnitario >= 0),
    Subtotal        Decimal(12,2) Not Null Check (Subtotal >= 0),
    Constraint FK_DetCompra_Compra   Foreign Key (IdCompra)   References Compra(Id),
    Constraint FK_DetCompra_Producto Foreign Key (IdProducto) References     Producto(Id)
);
GO