/*
    Optional schema compatibility patch for the supplied MyStore database.
    Run AFTER the base database tables exist.
    This aligns the supplied database2024 schema with the project's EDMX model.
*/
USE [MyStore];
GO

/* The project's EDMX maps UserRole as nvarchar(50), while the original SQL uses nchar(1). */
IF COL_LENGTH(N'dbo.User', N'UserRole') IS NOT NULL
BEGIN
    ALTER TABLE dbo.[User] ALTER COLUMN UserRole NVARCHAR(50) NOT NULL;
END
GO

/* The project's EDMX expects ShippingAddress, DeliveryMethod and PaymentMethod. */
IF COL_LENGTH(N'dbo.Order', N'ShippingAddress') IS NULL
BEGIN
    ALTER TABLE dbo.[Order] ADD ShippingAddress NVARCHAR(MAX) NULL;
    IF COL_LENGTH(N'dbo.Order', N'AddressDelivery') IS NOT NULL
        UPDATE dbo.[Order]
        SET ShippingAddress = AddressDelivery
        WHERE ShippingAddress IS NULL;
    UPDATE dbo.[Order] SET ShippingAddress = N'' WHERE ShippingAddress IS NULL;
    ALTER TABLE dbo.[Order] ALTER COLUMN ShippingAddress NVARCHAR(MAX) NOT NULL;
END
GO

IF COL_LENGTH(N'dbo.Order', N'DeliveryMethod') IS NULL
    ALTER TABLE dbo.[Order] ADD DeliveryMethod NVARCHAR(50) NULL;
GO

IF COL_LENGTH(N'dbo.Order', N'PaymentMethod') IS NULL
    ALTER TABLE dbo.[Order] ADD PaymentMethod NVARCHAR(50) NULL;
GO

/* Separate fulfilment status for the order-status tabs in MyOrder. */
IF COL_LENGTH(N'dbo.Order', N'OrderStatus') IS NULL
    ALTER TABLE dbo.[Order] ADD OrderStatus NVARCHAR(50) NOT NULL
        CONSTRAINT DF_Order_OrderStatus DEFAULT (N'Chờ thanh toán');
GO

/* The EDMX maps OrderDetail.TotalPrice as a computed column. */
IF COL_LENGTH(N'dbo.OrderDetail', N'TotalPrice') IS NULL
    ALTER TABLE dbo.OrderDetail ADD TotalPrice AS (CONVERT(DECIMAL(29,2), Quantity * UnitPrice));
GO

/* Verify key columns required by the project. */
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE (TABLE_NAME = 'Order' AND COLUMN_NAME IN
       ('AddressDelivery','ShippingAddress','DeliveryMethod','PaymentMethod','OrderStatus'))
   OR (TABLE_NAME = 'OrderDetail' AND COLUMN_NAME IN ('Quantity','UnitPrice','TotalPrice'))
   OR (TABLE_NAME = 'Product' AND COLUMN_NAME IN ('Quantity'))
   OR (TABLE_NAME = 'User' AND COLUMN_NAME IN ('Username','Password','UserRole'))
ORDER BY TABLE_NAME, ORDINAL_POSITION;
GO
