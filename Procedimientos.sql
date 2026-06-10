-- Script: Procedimientos.sql

Use UnPocoDeHelado;
GO

-- sp_registrarVenta
-- Lo invoca el VENDEDOR. Crea la cabecera de venta (SeOpera=1)
-- en estado 'Pendiente'. Devuelve el Id por OUTPUT.

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
        Print 'Error al registrar la venta: ' + ERROR_MESSAGE();
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
        Begin
            Print 'Stock insuficiente. Disponible: '
                  + Cast(ISNULL(@StockDisp,0) As Varchar)
                  + ' / Solicitado: ' + Cast(@Cantidad As Varchar);
            Rollback Transaction; Return;
        End

        Declare @PrecioUnitario Decimal(10,2);
        Set @PrecioUnitario = dbo.fn_precioVenta(@IdProducto);

        Declare @Subtotal Decimal(12,2) = @PrecioUnitario * @Cantidad;

        Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, Cantidad, PrecioUnitario, Subtotal)
        Values (@IdOperacion, 1, @IdProducto, @Cantidad, @PrecioUnitario, @Subtotal);

        Commit Transaction;
    End Try
    Begin Catch
        If @@TRANCOUNT > 0 Rollback Transaction;
        Print 'Error al agregar item: ' + ERROR_MESSAGE();
    End Catch
End;
GO

-- sp_cobrarVenta
-- Lo invoca el ADMINISTRADOR. Genera el numero de factura unico
-- B-AAAA-NNNNNNNN (AAAA = sucursal, NNNNNNNN = correlativo)
-- y pasa la venta a estado 'Cobrada'.

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
        Begin
            Print 'La operacion no es una venta.';
            Rollback Transaction; Return;
        End

        If @Estado <> 'Pendiente'
        Begin
            Print 'La venta no esta en estado Pendiente.';
            Rollback Transaction; Return;
        End

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
        Print 'Venta cobrada. Factura: ' + @NumeroFactura;
    End Try
    Begin Catch
        If @@TRANCOUNT > 0 Rollback Transaction;
        Print 'Error al cobrar la venta: ' + ERROR_MESSAGE();
    End Catch
End;
GO

-- sp_registrarCompra
-- Registra una compra (SeOpera = 0). El IdProveedor se guarda
-- en DetalleOperacion (permite varios proveedores por compra).
-- El trigger trg_aplicarStock suma el stock y actualiza el
-- PrecioCompraActual del producto.

Create Procedure sp_registrarCompra
    @IdProveedor     Bigint,
    @IdSucursal      Bigint,
    @IdEmpleado      Bigint,
    @IdProducto      Bigint,
    @Cantidad        Int,
    @PrecioUnitario  Decimal(10,2)
As
Begin
    Begin Try
        Begin Transaction;

        Declare @IdCompra Bigint;
        Declare @Subtotal Decimal(12,2) = @Cantidad * @PrecioUnitario;

        Insert Into Operacion (SeOpera, Fecha, IdSucursal, IdEmpleado, Estado, Total)
        Values (0, GETDATE(), @IdSucursal, @IdEmpleado, 'Finalizado', @Subtotal);

        Set @IdCompra = SCOPE_IDENTITY();

        Insert Into DetalleOperacion (IdOperacion, SeOpera, IdProducto, IdProveedor, Cantidad, PrecioUnitario, Subtotal)
        Values (@IdCompra, 0, @IdProducto, @IdProveedor, @Cantidad, @PrecioUnitario, @Subtotal);

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
        Print 'Error al registrar la compra: ' + ERROR_MESSAGE();
    End Catch
End;
GO
