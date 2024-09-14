USE [PrestigeCars]
GO


IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Udt')
BEGIN
    EXEC('CREATE SCHEMA [Udt]')
END


IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Utils')
BEGIN
    EXEC('CREATE SCHEMA [Utils]')
END


IF NOT EXISTS (SELECT 1 FROM sys.types WHERE name = 'StockCode' AND schema_id = SCHEMA_ID('Udt'))
BEGIN
    CREATE TYPE [Udt].[StockCode] FROM [nvarchar](50) NOT NULL
END


IF NOT EXISTS (SELECT 1 FROM sys.types WHERE name = 'Cost' AND schema_id = SCHEMA_ID('Udt'))
BEGIN
    CREATE TYPE [Udt].[Cost] FROM money NULL
END

IF NOT EXISTS (SELECT 1 FROM sys.types WHERE name = 'RepairsCost' AND schema_id = SCHEMA_ID('Udt'))
BEGIN
    CREATE TYPE [Udt].[RepairsCost] FROM money NULL
END

IF NOT EXISTS (SELECT 1 FROM sys.types WHERE name = 'PartsCost' AND schema_id = SCHEMA_ID('Udt'))
BEGIN
    CREATE TYPE [Udt].[PartsCost] FROM money NULL
END

IF NOT EXISTS (SELECT 1 FROM sys.types WHERE name = 'SurrogateKeyInt' AND schema_id = SCHEMA_ID('Udt'))
BEGIN
    CREATE TYPE [Udt].[SurrogateKeyInt] FROM [INT] NULL
END

IF NOT EXISTS (SELECT 1 FROM sys.types WHERE name = 'TransportInCost' AND schema_id = SCHEMA_ID('Udt'))
BEGIN
    CREATE TYPE [Udt].[TransportInCost] FROM money NULL
END

IF NOT EXISTS (SELECT 1 FROM sys.types WHERE name = 'Color' AND schema_id = SCHEMA_ID('Udt'))
BEGIN
    CREATE TYPE [Udt].[Color] FROM nvarchar(50) NULL
END

IF NOT EXISTS (SELECT 1 FROM sys.types WHERE name = 'BuyerComments' AND schema_id = SCHEMA_ID('Udt'))
BEGIN
    CREATE TYPE [Udt].[BuyerComments] FROM NVARCHAR(4000) NULL
END

IF NOT EXISTS (SELECT 1 FROM sys.types WHERE name = 'DateBought' AND schema_id = SCHEMA_ID('Udt'))
BEGIN
    CREATE TYPE [Udt].[DateBought] FROM date NULL
END

IF NOT EXISTS (SELECT 1 FROM sys.types WHERE name = 'TimeBought' AND schema_id = SCHEMA_ID('Udt'))
BEGIN
    CREATE TYPE [Udt].[TimeBought] FROM time NULL
END

IF NOT EXISTS (SELECT 1 FROM sys.types WHERE name = 'IsBool' AND schema_id = SCHEMA_ID('Udt'))
BEGIN
    CREATE TYPE [Udt].[IsRHD] FROM bit NULL
END

IF NOT EXISTS (SELECT 1 FROM sys.types WHERE name = 'ModelId' AND schema_id = SCHEMA_ID('Udt'))
BEGIN
    CREATE TYPE [Udt].[ModelId] FROM smallint NULL
END