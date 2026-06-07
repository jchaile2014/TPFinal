-- Script: Datos.sql
-- Descripcion: Carga de datos 

Use UnPocoDeHelado;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- CLASIFICACIONES 
Insert Into Clasificacion (Nombre, SeClasifica) Values
('Helados',    0),   
('Cafeteria',  0), 
('Reposteria', 0);

-- Marcas (SeClasifica = 1)
Insert Into Clasificacion (Nombre, SeClasifica) Values
('Helados del Valle',   1),   
('Envases Premium',     1),  
('Cafe La Pampa',       1), 
('Panaderia Artesanal', 1);

-- EMPLEADOS
Insert Into Empleado (Nombre, Apellido, DNI, Email, Telefono, IdSucursal, IdRol, FechaIngreso, Salario) Values
('Juan',   'Perez',     '30111222', 'jperez@unpocodehelado.com',    '03834-700111', 1, 1, '2019-04-01', 850000), -- Id 1 Admin Centro
('Carlos', 'Rodriguez', '34555666', 'crodriguez@unpocodehelado.com','03834-700333', 1, 2, '2021-02-10', 480000), -- Id 2 Vend  Centro
('Lucia',  'Fernandez', '36777888', 'lfernandez@unpocodehelado.com','03834-700444', 1, 2, '2022-05-20', 490000), -- Id 3 Vend  Centro
('Maria',  'Gonzalez',  '32333444', 'mgonzalez@unpocodehelado.com', '03834-700222', 2, 1, '2020-08-15', 820000), -- Id 4 Admin Norte
('Pedro',  'Lopez',     '38999000', 'plopez@unpocodehelado.com',    '03834-700555', 2, 2, '2023-11-01', 450000); -- Id 5 Vend  Norte

-- USUARIOS 
Insert Into Usuario (Id, NombreUsuario, Pass) Values
(1, 'jperez',     'pass123'),
(2, 'crodriguez', 'pass123'),
(3, 'lfernandez', 'pass123'),
(4, 'mgonzalez',  'pass123'),
(5, 'plopez',     'pass123');


-- CLIENTES 
Insert Into Cliente (Nombre, Apellido, DNI, Email, Telefono) Values
('Consumidor', 'Final',    NULL,       NULL,                  NULL),         -- Id 1
('Ana',        'Martinez', '28111222', 'ana.m@gmail.com',     '03834-600111'),-- Id 2
('Roberto',    'Silva',    '30333444', 'r.silva@gmail.com',   '03834-600222'),-- Id 3
('Sofia',      'Romero',   '35555666', 'sofiarom@gmail.com',  '03834-600333'),-- Id 4
('Diego',      'Vega',     '40777888', 'diegovega@gmail.com', '03834-600444');-- Id 5

-- PROVEEDORES
Insert Into Proveedor (Nombre, CUIT, Telefono, Email, Direccion, Rubro) Values
('Helados del Valle',       '30-12345678-9', '03834-555111', 'ventas@hdvalle.com', 'Parque Industrial L-12', 'Helados'),                -- Id 1
('Envases & Cucuruchos SA', '30-23456789-0', '011-44556677', 'ventas@enycu.com',   'Av. Industrial 800',     'Envases'),                -- Id 2
('Distribuidora La Pampa',  '30-34567890-1', '03834-555222', 'pedidos@lapampa.com','Ruta 38 km 6',           'Cafeteria y reposteria');-- Id 3

-- PRODUCTOS

-- Sucursal Centro (IdSucursal = 1)
Insert Into Producto (Nombre, IdCategoria, IdMarca, Cantidad, StockMinimo, PorcentajeGanancia, PrecioCompraActual, IdSucursal, Descripcion) Values
('Helado cucurucho', 1, 5, 94,  10, 150.00, 800.00,  1, 'Helado servido en cucurucho clasico'),  -- Id 1
('Helado 1/4 kg',    1, 4, 0,   5,  94.44,  1800.00, 1, 'Helado por peso 1/4 kg'),               -- Id 2
('Helado 1/2 kg',    1, 4, 28,  5,  116.67, 3000.00, 1, 'Helado por peso 1/2 kg'),               -- Id 3
('Helado 1 kg',      1, 4, 19,  3,  140.00, 5000.00, 1, 'Helado por peso 1 kg'),                 -- Id 4
('Cafe chico',       2, 6, 79,  20, 200.00, 400.00,  1, 'Pocillo de cafe espresso'),             -- Id 5
('Cafe grande',      2, 6, 50,  20, 200.00, 600.00,  1, 'Cafe espresso doble'),                  -- Id 6
('Cafe con leche',   2, 6, 37,  20, 200.00, 500.00,  1, 'Cafe con leche en jarrito'),            -- Id 7
('Tortillita',       3, 7, 37,  15, 125.00, 400.00,  1, 'Tortillita criolla'),                   -- Id 8
('Medialuna',        3, 7, 58,  15, 166.67, 300.00,  1, 'Medialuna de manteca');                 -- Id 9

-- Sucursal Norte (IdSucursal = 2)
Insert Into Producto (Nombre, IdCategoria, IdMarca, Cantidad, StockMinimo, PorcentajeGanancia, PrecioCompraActual, IdSucursal, Descripcion) Values
('Helado cucurucho', 1, 5, 48,  10, 150.00, 800.00,  2, 'Helado servido en cucurucho clasico'),  -- Id 10
('Helado 1/4 kg',    1, 4, 24,  5,  94.44,  1800.00, 2, 'Helado por peso 1/4 kg'),               -- Id 11
('Helado 1/2 kg',    1, 4, 0,   5,  116.67, 3000.00, 2, 'Helado por peso 1/2 kg'),               -- Id 12
('Helado 1 kg',      1, 4, 9,   3,  140.00, 5000.00, 2, 'Helado por peso 1 kg'),                 -- Id 13
('Cafe chico',       2, 6, 48,  20, 200.00, 400.00,  2, 'Pocillo de cafe espresso'),             -- Id 14
('Cafe grande',      2, 6, 29,  20, 200.00, 600.00,  2, 'Cafe espresso doble'),                  -- Id 15
('Cafe con leche',   2, 6, 32,  20, 200.00, 500.00,  2, 'Cafe con leche en jarrito'),            -- Id 16
('Tortillita',       3, 7, 26,  15, 125.00, 400.00,  2, 'Tortillita criolla'),                   -- Id 17
('Medialuna',        3, 7, 38,  15, 166.67, 300.00,  2, 'Medialuna de manteca');                 -- Id 18

Insert Into ProductoProveedor (IdProducto, IdProveedor) Values
-- Centro
(1, 2), (1, 1),
(2, 1), (3, 1), (4, 1),
(5, 3), (6, 3), (7, 3),
(8, 3), (9, 3),
-- Norte
(10, 2), (10, 1),
(11, 1), (12, 1), (13, 1),
(14, 3), (15, 3), (16, 3),
(17, 3), (18, 3);

-- OPERACIONES: COMPRAS
-- Compra 1: Centro <- Helados del Valle (Juan)
Insert Into Operacion (SeOpera, Fecha, IdSucursal, IdProveedor, IdEmpleado, Estado, Total) Values
(0, '2026-04-15 10:30', 1, 1, 1, 'Finalizado', 190000.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(1, 0, 4, 20, 5000.00, 100000.00),
(1, 0, 3, 30, 3000.00, 90000.00);

-- Compra 2: Norte <- Helados del Valle (Maria)
Insert Into Operacion (SeOpera, Fecha, IdSucursal, IdProveedor, IdEmpleado, Estado, Total) Values
(0, '2026-04-16 11:00', 2, 1, 4, 'Finalizado', 95000.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(2, 0, 13, 10, 5000.00, 50000.00),
(2, 0, 11, 25, 1800.00, 45000.00);

-- Compra 3: Centro <- Envases & Cucuruchos (Juan)
Insert Into Operacion (SeOpera, Fecha, IdSucursal, IdProveedor, IdEmpleado, Estado, Total) Values
(0, '2026-04-18 09:15', 1, 2, 1, 'Finalizado', 80000.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(3, 0, 1, 100, 800.00, 80000.00);

-- Compra 4: Norte <- Envases & Cucuruchos (Maria)
Insert Into Operacion (SeOpera, Fecha, IdSucursal, IdProveedor, IdEmpleado, Estado, Total) Values
(0, '2026-04-19 09:45', 2, 2, 4, 'Finalizado', 40000.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(4, 0, 10, 50, 800.00, 40000.00);

-- Compra 5: Centro <- Distribuidora La Pampa (Juan)
Insert Into Operacion (SeOpera, Fecha, IdSucursal, IdProveedor, IdEmpleado, Estado, Total) Values
(0, '2026-04-22 08:30', 1, 3, 1, 'Finalizado', 116000.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(5, 0, 5, 80, 400.00, 32000.00),
(5, 0, 6, 50, 600.00, 30000.00),
(5, 0, 9, 60, 300.00, 18000.00),
(5, 0, 8, 40, 400.00, 16000.00),
(5, 0, 7, 40, 500.00, 20000.00);

-- Compra 6: Norte <- Distribuidora La Pampa (Maria)
Insert Into Operacion (SeOpera, Fecha, IdSucursal, IdProveedor, IdEmpleado, Estado, Total) Values
(0, '2026-04-23 08:50', 2, 3, 4, 'Finalizado', 78000.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(6, 0, 14, 50, 400.00, 20000.00),
(6, 0, 15, 30, 600.00, 18000.00),
(6, 0, 18, 40, 300.00, 12000.00),
(6, 0, 17, 30, 400.00, 12000.00),
(6, 0, 16, 32, 500.00, 16000.00);

-- OPERACIONES: VENTAS 
-- Venta 1 (Op Id 7): Centro - Carlos (vend) - COBRADA
Insert Into Operacion (SeOpera, NumeroFactura, Fecha, IdSucursal, IdCliente, IdEmpleado, IdMedioPago, Estado, Total) Values
(1, 'B-0001-00000001', '2026-05-10 14:20', 1, 2, 2, 1, 'Cobrada', 5200.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(7, 1, 1, 2, 2000.00, 4000.00),
(7, 1, 5, 1, 1200.00, 1200.00);

-- Venta 2 (Op Id 8): Centro - Lucia - COBRADA
Insert Into Operacion (SeOpera, NumeroFactura, Fecha, IdSucursal, IdCliente, IdEmpleado, IdMedioPago, Estado, Total) Values
(1, 'B-0001-00000002', '2026-05-10 17:45', 1, 3, 3, 2, 'Cobrada', 8100.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(8, 1, 3, 1, 6500.00, 6500.00),
(8, 1, 9, 2, 800.00,  1600.00);

-- Venta 3 (Op Id 9): Centro - Carlos - PENDIENTE
Insert Into Operacion (SeOpera, Fecha, IdSucursal, IdCliente, IdEmpleado, Estado, Total) Values
(1, '2026-05-11 12:10', 1, 1, 2, 'Pendiente', 12000.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(9, 1, 4, 1, 12000.00, 12000.00);

-- Venta 4 (Op Id 10): Centro - Lucia - COBRADA
Insert Into Operacion (SeOpera, NumeroFactura, Fecha, IdSucursal, IdCliente, IdEmpleado, IdMedioPago, Estado, Total) Values
(1, 'B-0001-00000003', '2026-05-11 16:00', 1, 4, 3, 2, 'Cobrada', 7200.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(10, 1, 7, 3, 1500.00, 4500.00),
(10, 1, 8, 3, 900.00,  2700.00);

-- Venta 5 (Op Id 11): Centro - Carlos - PENDIENTE
Insert Into Operacion (SeOpera, Fecha, IdSucursal, IdCliente, IdEmpleado, Estado, Total) Values
(1, '2026-05-12 15:30', 1, 1, 2, 'Pendiente', 8000.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(11, 1, 1, 4, 2000.00, 8000.00);

-- Venta 6 (Op Id 12): Norte - Pedro - COBRADA
Insert Into Operacion (SeOpera, NumeroFactura, Fecha, IdSucursal, IdCliente, IdEmpleado, IdMedioPago, Estado, Total) Values
(1, 'B-0002-00000001', '2026-05-10 13:15', 2, 5, 5, 1, 'Cobrada', 5300.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(12, 1, 11, 1, 3500.00, 3500.00),
(12, 1, 15, 1, 1800.00, 1800.00);

-- Venta 7 (Op Id 13): Norte - Pedro - COBRADA (Consumidor Final)
Insert Into Operacion (SeOpera, NumeroFactura, Fecha, IdSucursal, IdCliente, IdEmpleado, IdMedioPago, Estado, Total) Values
(1, 'B-0002-00000002', '2026-05-11 17:30', 2, 1, 5, 1, 'Cobrada', 5600.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(13, 1, 10, 2, 2000.00, 4000.00),
(13, 1, 18, 2, 800.00,  1600.00);

-- Venta 8 (Op Id 14): Norte - Pedro - PENDIENTE
Insert Into Operacion (SeOpera, Fecha, IdSucursal, IdCliente, IdEmpleado, Estado, Total) Values
(1, '2026-05-12 14:00', 2, 1, 5, 'Pendiente', 12000.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(14, 1, 13, 1, 12000.00, 12000.00);

-- Venta 9 (Op Id 15): Centro - Lucia - COBRADA
Insert Into Operacion (SeOpera, NumeroFactura, Fecha, IdSucursal, IdCliente, IdEmpleado, IdMedioPago, Estado, Total) Values
(1, 'B-0001-00000004', '2026-05-13 19:00', 1, 2, 3, 3, 'Cobrada', 6500.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(15, 1, 3, 1, 6500.00, 6500.00);

-- Venta 10 (Op Id 16): Norte - Pedro - COBRADA
Insert Into Operacion (SeOpera, NumeroFactura, Fecha, IdSucursal, IdCliente, IdEmpleado, IdMedioPago, Estado, Total) Values
(1, 'B-0002-00000003', '2026-05-13 16:40', 2, 4, 5, 2, 'Cobrada', 6000.00);
Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(16, 1, 14, 2, 1200.00, 2400.00),
(16, 1, 17, 4, 900.00,  3600.00);

GO