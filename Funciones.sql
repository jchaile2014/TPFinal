-- Script: Funciones.sql

Create Function fn_gananciaProducto (@IdProducto Bigint)
Returns Decimal(6,2)
As
Begin
    Declare @UltimoPrecio Decimal(10,2);
    Declare @PrecioVenta  Decimal(10,2);

    Select Top 1 @UltimoPrecio = dc.PrecioUnitario
    From DetalleCompra dc
    Inner Join Compra c On c.Id = dc.IdCompra
    Where dc.IdProducto = @IdProducto
    Order By c.Fecha Desc, dc.Id Desc;

    Select @PrecioVenta = PrecioVenta
    From Producto Where Id = @IdProducto;

    If @UltimoPrecio Is Null Or @UltimoPrecio = 0 Or @PrecioVenta Is Null
        Return 0;

    Return Cast(((@PrecioVenta - @UltimoPrecio) / @UltimoPrecio) * 100 As Decimal(6,2));
End;
GO

Create Function fn_ventasSucursalPeriodo
(
    @IdSucursal Bigint,
    @FechaDesde Date,
    @FechaHasta Date
)
Returns Decimal(12,2)
As
Begin
    Declare @Total Decimal(12,2);

    Select @Total = SUM(v.Total)
    From Venta v
    Where v.IdSucursal = @IdSucursal
      And v.Estado = 'Cobrada'
      And Cast(v.Fecha As Date) Between @FechaDesde And @FechaHasta;

    Return ISNULL(@Total, 0);
End;
GO
