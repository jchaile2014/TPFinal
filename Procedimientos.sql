-- Script: Procedimientos.sql

Use UnPocoDeHelado;
GO

-- sp_registrarVenta
-- Crea la cabecera de venta (SeOpera=1) en estado 'Pendiente'.
-- El Total arranca en 0; lo recalcula el trigger al agregar items.
-- Devuelve el Id por OUTPUT.

Create Procedure sp_registrarVenta
    @IdSucursal        Bigint,
    @IdEmpleado        Bigint,
    @IdCliente         Bigint = 1,   -- Consumidor Final por defecto
    @IdOperacionSalida Bigint Output
As
Begin
    Begin Try
        Begin Transaction;

        Insert Into Operacion (SeOpera, Fecha, IdSucursal, IdCliente, IdEmpleado, Estado, Total)
        Values (1, GETDATE(), @IdSucursal, @IdCliente, @IdEmpleado, 'Pendiente', 0);

        Set @IdOperacionSalida = SCOPE_IDENTITY();

        Commit Transaction;
    End Try
    Begin Catch
        If @@TRANCOUNT > 0 Rollback Transaction;
        Throw;
    End Catch
End;
GO

-- sp_agregarItemVenta
-- Agrega un item al detalle validando stock del producto.
-- El precio se calcula con fn_precioVenta
-- (PrecioCompraActual * (1 + PorcentajeGanancia/100)).
-- En ventas IdProveedor queda NULL.

Create Procedure sp_agregarItemVenta
    @IdOperacion Bigint,
    @IdProducto  Bigint,
    @Cantidad    Int
As
Begin
    Begin Try
        Begin Transaction;

        Declare @StockDisp Int;
        Select @StockDisp = Cantidad From Producto Where Id = @IdProducto;

        If ISNULL(@StockDisp, 0) < @Cantidad
            Throw 50001, 'Stock insuficiente para el producto solicitado.', 1;

        Declare @PrecioUnitario Decimal(10,2);
        Set @PrecioUnitario = dbo.fn_precioVenta(@IdProducto);

        Declare @Subtotal Decimal(12,2) = @PrecioUnitario * @Cantidad;

        Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal)
        Values (@IdOperacion, 1, @IdProducto, @Cantidad, @PrecioUnitario, @Subtotal);

        Commit Transaction;
    End Try
    Begin Catch
        If @@TRANCOUNT > 0 Rollback Transaction;
        Throw;
    End Catch
End;
GO

-- sp_cobrarVenta
-- Genera el numero de factura unico B-AAAA-NNNNNNNN
-- (AAAA = sucursal, NNNNNNNN = correlativo) y pasa la venta a 'Cobrada'.

Create Procedure sp_cobrarVenta
    @IdOperacion Bigint,
    @IdMedioPago Int
As
Begin
    Begin Try
        Begin Transaction;

        Declare @IdSucursal Bigint, @Estado Varchar(20), @SeOpera Bit;
        Select @IdSucursal = IdSucursal, @Estado = Estado, @SeOpera = SeOpera
        From Operacion Where Id = @IdOperacion;

        If @SeOpera <> 1
            Throw 50002, 'La operacion no es una venta.', 1;

        If @Estado <> 'Pendiente'
            Throw 50003, 'La venta no esta en estado Pendiente.', 1;

        Declare @Ultimo Int;
        Select @Ultimo = ISNULL(MAX(Cast(SUBSTRING(NumeroFactura, 8, 8) As Int)), 0)
        From Operacion
        Where SeOpera = 1
          And IdSucursal = @IdSucursal
          And NumeroFactura Is Not Null;

        Declare @NumeroFactura Varchar(20);
        Set @NumeroFactura = 'B-'
                           + Right('0000' + Cast(@IdSucursal As Varchar), 4)
                           + '-'
                           + Right('00000000' + Cast(@Ultimo + 1 As Varchar), 8);

        Update Operacion
        Set NumeroFactura = @NumeroFactura,
            IdMedioPago   = @IdMedioPago,
            Estado        = 'Cobrada'
        Where Id = @IdOperacion;

        Commit Transaction;
    End Try
    Begin Catch
        If @@TRANCOUNT > 0 Rollback Transaction;
        Throw;
    End Catch
End;
GO

-- sp_registrarCompra
-- Registra una compra (SeOpera = 0). El IdProveedor se guarda en
-- DetalleOperacion (permite varios proveedores por compra).
-- Si @IdOperacion llega NULL crea la cabecera y la devuelve; si llega
-- con valor agrega el renglon a esa compra existente (varios renglones).
-- El Total lo recalcula el trigger; el trigger trg_aplicarStock suma el
-- stock y actualiza el PrecioCompraActual del producto.

Create Procedure sp_registrarCompra
    @IdProveedor     Bigint,
    @IdSucursal      Bigint,
    @IdEmpleado      Bigint,
    @IdProducto      Bigint,
    @Cantidad        Int,
    @PrecioUnitario  Decimal(10,2),
    @IdOperacion     Bigint = NULL Output
As
Begin
    Begin Try
        Begin Transaction;

        Declare @Subtotal Decimal(12,2) = @Cantidad * @PrecioUnitario;

        If @IdOperacion Is Null
        Begin
            Insert Into Operacion (SeOpera, Fecha, IdSucursal, IdEmpleado, Estado, Total)
            Values (0, GETDATE(), @IdSucursal, @IdEmpleado, 'Finalizado', 0);
            Set @IdOperacion = SCOPE_IDENTITY();
        End

        Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, IdProveedor, Cantidad, PrecioUnitario, Subtotal)
        Values (@IdOperacion, 0, @IdProducto, @IdProveedor, @Cantidad, @PrecioUnitario, @Subtotal);

        If Not Exists (Select 1 From ProductoProveedor
                       Where IdProducto = @IdProducto And IdProveedor = @IdProveedor)
        Begin
            Insert Into ProductoProveedor (IdProducto, IdProveedor)
            Values (@IdProducto, @IdProveedor);
        End

        Commit Transaction;
    End Try
    Begin Catch
        If @@TRANCOUNT > 0 Rollback Transaction;
        Throw;
    End Catch
End;
GO
