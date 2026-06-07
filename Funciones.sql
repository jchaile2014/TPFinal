-- Script: Funciones.sql

Use UnPocoDeHelado;
GO

Create Function fn_precioVenta (@IdProducto Bigint)
Returns Decimal(10,2)
As
Begin
    Declare @PrecioCompra Decimal(10,2);
    Declare @Ganancia     Decimal(5,2);

    Select @PrecioCompra = PrecioCompraActual,
           @Ganancia     = PorcentajeGanancia
    From Producto Where Id = @IdProducto;

    If @PrecioCompra Is Null Or @Ganancia Is Null
        Return 0;

    Return Cast(@PrecioCompra * (1 + @Ganancia / 100.0) As Decimal(10,2));
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

    Select @Total = SUM(o.Total)
    From Operacion o
    Where o.SeOpera = 1
      And o.IdSucursal = @IdSucursal
      And o.Estado = 'Cobrada'
      And Cast(o.Fecha As Date) Between @FechaDesde And @FechaHasta;

    Return ISNULL(@Total, 0);
End;
GO
