Use Northwinds2022TSQLV7

--Question 1
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE YEAR(orderdate) = 2015 AND MONTH(orderdate) = 6;

--Question 2
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = EOMONTH(orderdate);

--Question 3
select * from HR.Employees
where lastname LIKE '%e%e%';
