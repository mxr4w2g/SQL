

--Inline Tables Value Function
CREATE OR ALTER FUNCTION itv_dbo.GetYearlySales
(@UserAuthorizationKey AS INT)
RETURNS TABLE
AS 
RETURN
(
SELECT MakeName,ModelName,CustomerName,CountryName,Cost,RepairsCost,PartsCost,TransportInCost,SalePrice,SaleDate, @UserAuthorizationKey AS UserKey
	FROM Reference.YearlySales
)
--View For Reference.YearlySales
CREATE OR ALTER VIEW [Reference].view_YearlySales
AS
SELECT *
FROM itv_dbo.GetYearlySales(1)
GO
-------------------------------------------------------------------------------------------------------------



--Inline Tables Value Function
CREATE OR ALTER FUNCTION itv_dbo.GetSalesInPounds
(@UserAuthorizationKey AS INT)
RETURNS TABLE
AS 
RETURN
(
SELECT MakeName,ModelName,VehicleCost, @UserAuthorizationKey AS UserKey
	FROM SourceData.SalesInPounds
)
--View For SourceData.SalesInPounds
CREATE OR ALTER VIEW [SourceData].view_SalesInPounds
AS
SELECT *
FROM itv_dbo.GetSalesInPounds(1)
GO
--------------------------------------------------------------------------------------------



--Inline Tables Value Function
CREATE OR ALTER FUNCTION itv_dbo.GetSalesText
(@UserAuthorizationKey AS INT)
RETURNS TABLE
AS 
RETURN
(
SELECT CountryName,MakeName,Cost,SalePrice, @UserAuthorizationKey AS UserKey
	FROM SourceData.SalesText
)
--View For SourceData.SalesText
CREATE OR ALTER VIEW [SourceData].view_SalesText
AS
SELECT *
FROM itv_dbo.GetSalesText(1)
GO