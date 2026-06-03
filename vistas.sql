-- Script: Vistas.sql

Use UnPocoDeHelado;
GO

Create View vista_topProductosVendidos As
Select Top 50
    p.Id              As IdProducto,
    p.Nombre          As Producto,
    c.Nombre          As Categoria,
    ISNULL(p.Marca, '(sin marca)') As Marca,
    SUM(dv.Cantidad)  As UnidadesVendidas,
    SUM(dv.Subtotal)  As TotalFacturado
From Producto p
Inner Join Categoria    c  On c.Id = p.IdCategoria
Inner Join DetalleVenta dv On dv.IdProducto = p.Id
Inner Join Venta        v  On v.Id = dv.IdVenta
Where p.Activo = 1
  And v.Estado = 'Cobrada'
Group By p.Id, p.Nombre, c.Nombre, p.Marca
Order By UnidadesVendidas Desc;
GO

Create View vista_stockPorSucursal As
Select
    su.Id     As IdSucursal,
    su.Nombre As Sucursal,
    p.Id      As IdProducto,
    p.Nombre  As Producto,
    c.Nombre  As Categoria,
    s.Cantidad As StockActual,
    p.PrecioVenta,
    STUFF((
        Select ', ' + pr.Nombre
        From ProductoProveedor pp
        Inner Join Proveedor pr On pr.Id = pp.IdProveedor
        Where pp.IdProducto = p.Id And pr.Activo = 1
        For XML Path('')
    ), 1, 2, '') As ProveedoresDisponibles
From Stock s
Inner Join Producto  p  On p.Id  = s.IdProducto
Inner Join Categoria c  On c.Id  = p.IdCategoria
Inner Join Sucursal  su On su.Id = s.IdSucursal
Where su.Activa = 1 And p.Activo = 1;
GO

Create View vista_ventasDetalladas As
Select
    v.Id                AS IdVenta,
    v.NumeroFactura,
    v.Fecha,
    su.Nombre           AS Sucursal,
    ev.Nombre + ' ' + ev.Apellido AS Vendedor,
    ISNULL(ec.Nombre + ' ' + ec.Apellido, '(no cobrada)') AS Cajero,
    cl.Nombre + ' ' + cl.Apellido AS Cliente,
    ISNULL(mp.Nombre, '(sin definir)') AS MedioPago,
    v.Estado,
    v.Total
From Venta v
Inner Join Sucursal  su ON su.Id = v.IdSucursal
Inner Join Empleado  ev ON ev.Id = v.IdEmpleadoVende
Left  Join Empleado  ec ON ec.Id = v.IdEmpleadoCobra
Inner Join Cliente   cl ON cl.Id = v.IdCliente
Left  Join MedioPago mp ON mp.Id = v.IdMedioPago;
GO