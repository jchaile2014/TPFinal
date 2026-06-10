-- Script: Triggers.sql

Use UnPocoDeHelado;
GO

Create Trigger trg_actualizarTotalOperacion
On DetalleOperacion
After Insert, Update, Delete
As
Begin
    Set NoCount On;

    Declare @IdsOp Table (IdOperacion Bigint);

    Insert Into @IdsOp
    Select Distinct IdOperacion From inserted
    Union
    Select Distinct IdOperacion From deleted;

    Update o
    Set o.Total = ISNULL((
        Select SUM(d.Subtotal) From DetalleOperacion d Where d.IdOperacion = o.Id
    ), 0)
    From Operacion o
    Where o.Id In (Select IdOperacion From @IdsOp);
End;
GO

Create Trigger trg_aplicarStock
On DetalleOperacion
After Insert
As
Begin
    Set NoCount On;

    If Exists (
        Select 1
        From inserted i
        Inner Join Producto p On p.Id = i.IdProducto
        Where i.SeOpera = 1
          And p.Cantidad < i.Cantidad
    )
    Begin
        RAISERROR('Stock insuficiente para uno o mas productos.', 16, 1);
        Rollback Transaction;
        Return;
    End

    Update p
    Set p.Cantidad = p.Cantidad - i.Cantidad
    From Producto p
    Inner Join inserted i On i.IdProducto = p.Id
    Where i.SeOpera = 1;

    Update p
    Set p.Cantidad           = p.Cantidad + i.Cantidad,
        p.PrecioCompraActual = i.PrecioUnitario
    From Producto p
    Inner Join inserted i On i.IdProducto = p.Id
    Where i.SeOpera = 0;
End;
GO
