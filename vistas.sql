-- Script: Vistas.sql 

Use UnPocoDeHelado;
GO

Create View vista_topProductosVendidos As
Select Top 50
    p.Id     As IdProducto,
    p.Nombre As Producto,
    ISNULL(cat.Nombre, '(sin categoria)') As Categoria,
    ISNULL(m.Nombre,   '(sin marca)')     As Marca,
    SUM(d.Cantidad)  As UnidadesVendidas,
    SUM(d.Subtotal)  As TotalFacturado
From Producto p
Left  Join Clasificacion cat On cat.Id = p.IdCategoria And cat.SeClasifica = 0
Left  Join Clasificacion m   On m.Id   = p.IdMarca     And m.SeClasifica   = 1
Inner Join DetalleOperacion d On d.IdProducto = p.Id And d.SeOpera = 1
Inner Join Operacion        o On o.Id = d.IdOperacion And o.SeOpera = 1
Where p.Activo = 1
  And o.Estado = 'Cobrada'
Group By p.Id, p.Nombre, cat.Nombre, m.Nombre
Order By UnidadesVendidas Desc;
GO

Create View vista_stockCritico As
Select
    p.IdSucursal,
    p.Id        As IdProducto,
    p.Nombre    As Producto,
    ISNULL(cat.Nombre, '(sin categoria)') As Categoria,
    p.Cantidad  As StockActual,
    p.StockMinimo,
    p.PrecioCompraActual,
    STUFF((
        Select ', ' + pr.Nombre
        From ProductoProveedor pp
        Inner Join Proveedor pr On pr.Id = pp.IdProveedor
        Where pp.IdProducto = p.Id And pr.Activo = 1
        For XML Path('')
    ), 1, 2, '') As ProveedoresDisponibles
From Producto p
Left Join Clasificacion cat On cat.Id = p.IdCategoria And cat.SeClasifica = 0
Where p.Activo = 1
  And p.Cantidad < p.StockMinimo;
GO

-- En una compra, IdProveedor ahora vive en cada linea de detalle.
-- Como una operacion puede tener varios proveedores distintos,
-- los concatenamos con STUFF en una sola columna "Proveedores".
Create View vista_operacionesDetalladas As
Select
    o.Id            As IdOperacion,
    Case o.SeOpera When 1 Then 'Venta' Else 'Compra' End As Tipo,
    o.NumeroFactura,
    o.Fecha,
    o.IdSucursal,
    o.IdEmpleado,
    e.Nombre + ' ' + e.Apellido As Empleado,
    ISNULL(cl.Nombre + ' ' + cl.Apellido, '-') As Cliente,
    ISNULL(STUFF((
        Select Distinct ', ' + pr.Nombre
        From DetalleOperacion d
        Inner Join Proveedor pr On pr.Id = d.IdProveedor
        Where d.IdOperacion = o.Id
        For XML Path('')
    ), 1, 2, ''), '-') As Proveedores,
    ISNULL(mp.Nombre, '(sin definir)') As MedioPago,
    o.Estado,
    o.Total
From Operacion o
Inner Join Empleado  e  On e.Id  = o.IdEmpleado
Left  Join Cliente   cl On cl.Id = o.IdCliente
Left  Join MedioPago mp On mp.Id = o.IdMedioPago;
GO
