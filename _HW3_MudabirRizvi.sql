--Question1: Write a query that returns all order placed on the last day
--of activity that can be found in the Orders table

use TSQLV4

SELECT orderid, orderdate, custid, empid
FROM Orders
WHERE orderdate = (
SELECT MAX(orderdate)
FROM Orders
)
ORDER BY orderid DESC;



--Question3: Write a query that returns employees
-- who did not place orders on or after May 1st, 2016

--Answer:
SELECT e.empid, e.FirstName, e.lastname
FROM HR.Employees e
LEFT JOIN Orders o ON e.empid = o.empid
AND o.orderdate >= '2016-05-01'
WHERE o.orderid IS NULL




--Question4: Write a query that returns
-- countries where there are customers but not employees

--Answer: 
SELECT DISTINCT C.Country
FROM Sales.Customers C
LEFT JOIN HR.Employees E ON C.Country = E.Country
WHERE E.Country IS NULL;




--Question5:Write a query that returns for each customer
-- all orders placed on the customer's last day of activity

--Answer:
WITH LastActivity AS (
SELECT c.custid, MAX(o.orderdate) AS last_activity_date        
FROM Sales.Customers c
JOIN Orders o ON c.custid = o.custid
GROUP BY c.custid
)
SELECT la.custid,o.orderid, o.orderdate, o.empid
FROM LastActivity la
JOIN Orders o ON la.custid = o.custid AND la.last_activity_date = o.orderdate
ORDER BY la.custid



--Question9: Explain the difference between IN and EXISTS

--Answer:"IN" filters rows whether a value matches any value in subquery or list of values
--"Exist" is used to check for existence of rows in subquery,returns true if subquery returns at least one row



--Answer of ChatGPT explain like 5 year old:
--**IN** is like looking at a plate of cookies and saying, "I want the chocolate chip one." If the chocolate chip cookie is on the plate, you can have it.
--**EXISTS** is like peeking into a toy box to see if your favorite toy is in there. If it's there, you can play with it.
