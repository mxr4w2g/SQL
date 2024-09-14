USE TSQLV4;

DROP TABLE IF EXISTS dbo.Customers;

CREATE TABLE dbo.Customers
(
  custid      INT          NOT NULL PRIMARY KEY,
  companyname NVARCHAR(40) NOT NULL,
  country     NVARCHAR(15) NOT NULL,
  region      NVARCHAR(15) NULL,
  city        NVARCHAR(15) NOT NULL  
);

-- Question 1-1
-- Insert into the dbo.Customers table a row with:
-- custid:  100
-- companyname: Coho Winery
-- country:     USA
-- region:      WA
-- city:        Redmond

INSERT INTO dbo.Customers (custid, companyname, country, region, city)
VALUES (100, 'Coho Winery', 'USA', 'WA', 'Redmond');




--Question 1-2
-- Insert into the dbo.Customers table 
-- all customers from Sales.Customers
-- who placed orders

INSERT INTO dbo.Customers (custid, companyname, country, region, city)
SELECT custid,companyname,country,region,city
FROM Sales.Customers
WHERE custid IN (SELECT custid FROM Sales.Orders);



--Question 1-3

SELECT *
INTO dbo.Orders
FROM Sales.Orders
WHERE YEAR(orderdate) BETWEEN 2014 AND 2016;



--Question 2

DELETE FROM dbo.Orders
OUTPUT deleted.orderid, deleted.orderdate
WHERE orderdate < '2014-08-01';











