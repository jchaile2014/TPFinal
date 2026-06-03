-- Script: Datos.sql
-- Descripcion: Carga de datos 

Use UnPocoDeHelado;
GO

-- ROLES
Insert Into Rol (Nombre, Descripcion) Values
('Dueño',    'Administrador de empleados y revison de listados'),
('Gerente',  'Administrador del stock y cobra ventas'),
('Heladero', 'registra ventas en mostrador y atiende mesas');

-- SUCURSALES
Insert Into Sucursal (Nombre, Direccion, Ciudad, Provincia, Telefono, Email, FechaApertura) Values
('Centro', 'Av. San Martin 450', 'San Fernando del Valle', 'Catamarca', '03834-441122', 'centro@unpocodehelado.com', '2018-03-15'),
('Norte',  'Av. Belgrano 1200',  'Valle Viejo', 'Catamarca', '03834-441133', 'norte@unpocodehelado.com',  '2020-11-20');

-- EMPLEADOS
Insert Into Empleado (Nombre, Apellido, DNI, Email, Telefono, IdSucursal, IdRol, FechaIngreso, Salario) Values
('Ademir', 'Montenegro', '39468951', 'AJefecito@unpocodehelado.com', '03834-458236', 1, 1, '2018-03-15', null),
('Juan',   'Perez',     '30111222',  'jperez@unpocodehelado.com',    '03834-700111', 1, 2, '2019-04-01', 850000),
('Carlos', 'Rodriguez', '34555666',  'crodriguez@unpocodehelado.com','03834-700333', 1, 3, '2021-02-10', 480000), 
('Lucia',  'Fernandez', '36777888',  'lfernandez@unpocodehelado.com','03834-700444', 1, 3, '2022-05-20', 490000), 
('Maria',  'Gonzalez',  '32333444',  'mgonzalez@unpocodehelado.com', '03834-700222', 2, 2, '2020-08-15', 820000), 
('Pedro',  'Lopez',     '38999000',  'plopez@unpocodehelado.com',    '03834-700555', 2, 3, '2023-11-01', 450000); 

-- USUARIOS
Insert Into  Usuario (Id, NombreUsuario, Pass) Values
(1, 'admin',      'admin'),
(2, 'jperez',     'pass123'),
(3, 'crodriguez', 'pass123'),
(4, 'lfernandez', 'pass123'),
(5, 'mgonzalez',  'pass123'),
(6, 'plopez',     'pass123');

-- CATEGORIAS
Insert Into Categoria (Nombre, Descripcion) Values
('HeladosDeAgua',     'Helados en sus distintos sabores'),
('HeladosDeCrema',    'Helados en sus distintos sabores'),
('HeladosPremium',    'Helados en sus distintas presentaciones'),
('Cafeteria',         'Cafes e infusiones'),
('Reposteria',        'Productos de panaderia y reposteria');

-- PRODUCTOS
Insert Into Producto (Nombre, IdCategoria, Marca, PrecioVenta, Descripcion) Values
('Helado cucurucho',        1, 'Cucurucho',             2000.00, 'Helado servido en cucurucho clasico'), 
('Helado 1/4 kg',           1, 'Helados del Invierno',  3500.00, 'Helado por peso 1/4 kg'),               
('Helado 1/2 kg',           1, 'Helados del Invierno',  6500.00, 'Helado por peso 1/2 kg'),              
('Helado 1 kg',             1, 'Helados del Invierno',  12000.00, 'Helado por peso 1 kg'),                
('Cafe chico',              2, 'Cafe Turco',            1200.00, 'Pocillo de cafe espresso'),             
('Cafe grande',             2, 'Cafe Turco',            1800.00, 'Cafe espresso doble'),                  
('Cafe con leche',          2, 'Cafe Turco',         1500.00, 'Cafe con leche en jarrito'),
('Cafe con leche grande',   2, 'Cafe Turco',         1500.00, 'Cafe con leche doble'),
('Capuccino chico',         2, 'Cafe Turco',         1700.00, 'Capuccino chico con espuma de leche'),
('Capuccino grande',        2, 'Cafe Turco',         2500.00, 'Capuccino grande con espuma de leche'),
('Tostado',                 3, 'Panaderia',          3000.00, 'tostado jamon y queso'),
('Tortillita',              3, 'Panaderia',          900.00,  'Tortillita criolla'),                   
('Medialuna',               3, 'Panaderia',          800.00,  'Medialuna de manteca'), 
('Donas',                   3, 'Panaderia',          1000.00, 'Donas glaseadas'),
('Scon de queso',           3, 'Panaderia',          1200.00, 'Scon de queso');              

-- MEDIOS DE PAGO
Insert Into MedioPago (Nombre) Values
('Efectivo'), ('Tarjeta Debito'), ('Tarjeta Credito'), ('MercadoPago'), ('Transferencia');

-- CLIENTES
Insert Into Cliente (Nombre, Apellido, DNI) Values
('Anita',     'Martinez',         '28111222'), 
('Roberto', 'Carlos',             '30333444'), 
('Sofia',   'Romero del valle',   '35555666'), 
('Diego',   'De La Vega',         '40777888'); 

-- MESAS
Insert Into Mesa (IdSucursal, Numero, Capacidad) Values
(1, 1, 2), (1, 2, 2), (1, 3, 4), (1, 4, 4), (1, 5, 2),  
(2, 1, 2), (2, 2, 2), (2, 3, 4);                         

-- PROVEEDORES
Insert Into Proveedor (Nombre, CUIT, Telefono, Email, Direccion, Rubro) Values
('Helados del Invierno',       '30-12345678-9', '03834-555111', 'ventas@hdInver.com', 'Parque Industrial', 'Helados'),               
('Distribuidora La Mendozina', '30-23456789-0', '011-44556677', null,   'Av. Industrial 800',     'Envases'),           
('Distribuidora El Turco',  '30-34567890-1', '03834-555222', null,'Ruta 38 km 6',           'Cafeteria y reposteria'); 

--PRODUCTO - PROVEEDOR
Insert Into ProductoProveedor (IdProducto, IdProveedor) Values
(2, 1), (3, 1), (4, 1),
(1, 2),
(1, 1),                  
(5, 3), (6, 3), (7, 3), (8, 3), (9, 3), (10, 3),
(11, 3), (12, 3), (13, 3), (14, 3), (15, 3);

-- COMPRAS

-- Compra 1: Centro <- Helados del Invierno
Insert Into Compra (IdProveedor, IdSucursal, IdEmpleado, Fecha, Total, Estado) Values
(1, 1, 1, '2026-04-15 10:30', 190000.00, 'Finalizado');
Insert Into DetalleCompra (IdCompra, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(1, 4, 20, 5000.00, 100000.00),   -- Helado 1 kg x 20
(1, 3, 30, 3000.00, 90000.00);    -- Helado 1/2 kg x 30

-- Compra 2: Norte <- Helados del Invierno
Insert Into Compra (IdProveedor, IdSucursal, IdEmpleado, Fecha, Total, Estado) Values
(1, 2, 4, '2026-04-16 11:00', 95000.00, 'Finalizado');
Insert Into DetalleCompra (IdCompra, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(2, 4, 10, 5000.00, 50000.00),    -- Helado 1 kg x 10
(2, 2, 25, 1800.00, 45000.00);    -- Helado 1/4 kg x 25

-- Compra 3: Centro <- Envases
Insert Into Compra (IdProveedor, IdSucursal, IdEmpleado, Fecha, Total, Estado) Values
(2, 1, 1, '2026-04-18 09:15', 80000.00, 'Finalizado');
Insert Into DetalleCompra (IdCompra, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(3, 1, 100, 800.00, 80000.00);    -- Cucurucho x 100

-- Compra 4: Norte <- Envases
Insert Into Compra (IdProveedor, IdSucursal, IdEmpleado, Fecha, Total, Estado) Values
(2, 2, 4, '2026-04-19 09:45', 40000.00, 'Finalizado');
Insert Into DetalleCompra (IdCompra, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(4, 1, 50, 800.00, 40000.00);     -- Cucurucho x 50

-- Compra 5: Centro <- Distribuidora El Turco
Insert Into Compra (IdProveedor, IdSucursal, IdEmpleado, Fecha, Total, Estado) Values
(3, 1, 1, '2026-04-22 08:30', 116000.00, 'Finalizado');
Insert Into DetalleCompra (IdCompra, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(5, 5, 80, 400.00, 32000.00),     -- Cafe chico
(5, 6, 50, 600.00, 30000.00),     -- Cafe grande
(5, 9, 60, 300.00, 18000.00),     -- Medialuna
(5, 8, 40, 400.00, 16000.00),     -- Tortillita
(5, 7, 40, 500.00, 20000.00);     -- Cafe con leche

-- Compra 6: Norte <- Distribuidora El Turco
Insert Into Compra (IdProveedor, IdSucursal, IdEmpleado, Fecha, Total, Estado) Values
(3, 2, 4, '2026-04-23 08:50', 78000.00, 'Finalizado');
Insert Into DetalleCompra (IdCompra, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(6, 5, 50, 400.00, 20000.00),     -- Cafe chico
(6, 6, 30, 600.00, 18000.00),     -- Cafe grande
(6, 9, 40, 300.00, 12000.00),     -- Medialuna
(6, 8, 30, 400.00, 12000.00),     -- Tortillita
(6, 7, 32, 500.00, 16000.00);     -- Cafe con leche

-- Actualizamos la tabla ProductoProveedor con la ultima fecha y precio de compra para cada producto y proveedor
Update pp
Set UltimaFechaCompra  = ult.UltimaFecha,
    UltimoPrecioCompra = ult.UltimoPrecio
From ProductoProveedor pp
Inner Join (
    Select c.IdProveedor, dc.IdProducto,
           MAX(c.Fecha) As UltimaFecha,
           MAX(dc.PrecioUnitario) As UltimoPrecio
    From DetalleCompra dc
    Inner Join Compra c On c.Id = dc.IdCompra
    Group By c.IdProveedor, dc.IdProducto
) ult On ult.IdProveedor = pp.IdProveedor And ult.IdProducto = pp.IdProducto;
GO
-- STOCK INICIAL POR SUCURSAL
Insert Into Stock (IdSucursal, IdProducto, Cantidad) Values
(1, 1, 100), (1, 2, 50), (1, 3, 30), (1, 4, 20), 
(1, 5, 80), (1, 6, 50), (1, 7, 40), (1, 8, 40), (1, 9, 60), (1, 10, 60),
(2, 1, 50), (2, 2, 25), (2, 3, 15), (2, 4, 10),
(2, 5, 50), (2, 6, 30), (2, 7, 32), (2, 8, 30), (2, 9, 40), (2,10 ,30);

GO
-- VENTAS
-- Venta 1: Centro - Carlos vende, Juan cobra - COBRADA
Insert Into Venta (NumeroFactura, IdSucursal, IdEmpleadoVende, IdEmpleadoCobra, IdCliente, Fecha, IdMedioPago, Estado, Total) Values
('B-0001-00000001', 1, 2, 1, 2, '2026-05-10 14:20', 1, 'Cobrada', 5200.00);
Insert Into DetalleVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(1, 1, 2, 2000.00, 4000.00),  -- 2x cucurucho
(1, 5, 1, 1200.00, 1200.00);  -- 1x cafe chico

-- Venta 2: Centro - Lucia vende, Juan cobra - COBRADA
Insert Into Venta (NumeroFactura, IdSucursal, IdEmpleadoVende, IdEmpleadoCobra, IdCliente, Fecha, IdMedioPago, Estado, Total) Values
('B-0001-00000002', 1, 3, 1, 3, '2026-05-10 17:45', 4, 'Cobrada', 8100.00);
Insert Into DetalleVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(2, 3, 1, 6500.00, 6500.00),  -- 1x Helado 1/2 kg
(2, 9, 2, 800.00,  1600.00);  -- 2x Medialuna

-- Venta 3: Centro - Carlos vende - PENDIENTE
Insert Into Venta (IdSucursal, IdEmpleadoVende, IdCliente, Fecha, Estado, Total) Values
(1, 2, 1, '2026-05-11 12:10', 'Pendiente', 12000.00);
Insert Into DetalleVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(3, 4, 1, 12000.00, 12000.00); -- 1x Helado 1 kg

-- Venta 4: Centro - Lucia vende, Juan cobra - COBRADA
Insert Into Venta (NumeroFactura, IdSucursal, IdEmpleadoVende, IdEmpleadoCobra, IdCliente, Fecha, IdMedioPago, Estado, Total) Values
('B-0001-00000003', 1, 3, 1, 4, '2026-05-11 16:00', 2, 'Cobrada', 7200.00);
Insert Into DetalleVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(4, 7, 3, 1500.00, 4500.00),  -- 3x Cafe con leche
(4, 8, 3, 900.00,  2700.00);  -- 3x Tortillita

-- Venta 5: Centro - Carlos vende - PENDIENTE
Insert Into Venta (IdSucursal, IdEmpleadoVende, IdCliente, Fecha, Estado, Total) Values
(1, 2, 1, '2026-05-12 15:30', 'Pendiente', 8000.00);
Insert Into DetalleVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(5, 1, 4, 2000.00, 8000.00);  -- 4x cucurucho

-- Venta 6: Norte - Pedro vende, Maria cobra - COBRADA
Insert Into Venta (NumeroFactura, IdSucursal, IdEmpleadoVende, IdEmpleadoCobra, IdCliente, Fecha, IdMedioPago, Estado, Total) Values
('B-0002-00000001', 2, 5, 4, 5, '2026-05-10 13:15', 1, 'Cobrada', 5300.00);
Insert Into DetalleVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(6, 2, 1, 3500.00, 3500.00),  -- 1x Helado 1/4 kg
(6, 6, 1, 1800.00, 1800.00);  -- 1x Cafe grande

-- Venta 7: Norte - Pedro vende, Maria cobra, Consumidor Final - COBRADA
Insert Into Venta (NumeroFactura, IdSucursal, IdEmpleadoVende, IdEmpleadoCobra, IdCliente, Fecha, IdMedioPago, Estado, Total) Values
('B-0002-00000002', 2, 5, 4, 1, '2026-05-11 17:30', 1, 'Cobrada', 5600.00);
Insert Into DetalleVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(7, 1, 2, 2000.00, 4000.00),  -- 2x cucurucho
(7, 9, 2, 800.00,  1600.00);  -- 2x Medialuna

-- Venta 8: Norte - Pedro vende - PENDIENTE
Insert Into Venta (IdSucursal, IdEmpleadoVende, IdCliente, Fecha, Estado, Total) Values
(2, 5, 1, '2026-05-12 14:00', 'Pendiente', 12000.00);
Insert Into DetalleVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(8, 4, 1, 12000.00, 12000.00); -- 1x Helado 1 kg

-- Venta 9: Centro - Lucia vende, Juan cobra - COBRADA
Insert Into Venta (NumeroFactura, IdSucursal, IdEmpleadoVende, IdEmpleadoCobra, IdCliente, Fecha, IdMedioPago, Estado, Total) Values
('B-0001-00000004', 1, 3, 1, 2, '2026-05-13 19:00', 5, 'Cobrada', 6500.00);
Insert Into DetalleVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(9, 3, 1, 6500.00, 6500.00);  -- 1x Helado 1/2 kg

-- Venta 10: Norte - Pedro vende, Maria cobra - COBRADA
Insert Into Venta (NumeroFactura, IdSucursal, IdEmpleadoVende, IdEmpleadoCobra, IdCliente, Fecha, IdMedioPago, Estado, Total) Values
('B-0002-00000003', 2, 5, 4, 4, '2026-05-13 16:40', 3, 'Cobrada', 6000.00);
Insert Into DetalleVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario, Subtotal) Values
(10, 5, 2, 1200.00, 2400.00), -- 2x Cafe chico
(10, 8, 4, 900.00,  3600.00); -- 4x Tortillita