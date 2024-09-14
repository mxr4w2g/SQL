/*
	Name: Mudabir Rizvi
	class : 09:15

	Email: mudabirr04@gmail.com
	
	file Name to be uploaded: CSCI331 Fall2023LastTest-YourLastNameFirstname.sql
*/

/*
	1) Write a query that returns all orders placed on the first day of activity or on the last day of activity (OrderDate) found in the [Sales].[Order] table using subqueries.
	
		1. Hard coding the OrderDate to 2016-05-06 or 2014-07-04 will be marked as incorrect.
		2. Hint: consider using a set operation and subquery or CTE
		3. Tables involved: [Sales].[Order], [Sales].[Customer], and [HumanResources].[Employee]. 
		
		Sample output is below:

				OrderId	OrderDateType		OrderDate	CustomerCompanyName	EmployeeFullName
				10248	Minimum OrderDate	2014-07-04		Customer ENQZT		Sven Mortensen

				11077	Maximum OrderDate	2016-05-06		Customer NYUHS		Sara Davis
				11076	Maximum OrderDate	2016-05-06		Customer RTXGC		Yael Peled
				11075	Maximum OrderDate	2016-05-06		Customer CCKOT		Maria Cameron
				11074	Maximum OrderDate	2016-05-06		Customer JMIKW		Russell King
*/
SELECT
    OrderId,
    OrderDate,
    CustomerCompanyName,
    EmployeeFirstName,
    EmployeeLastName
FROM
    [Sales].[Order] o
JOIN
    [Sales].[Customer] c ON o.CustomerId = c.CustomerId
JOIN
    [HumanResources].[Employee] e ON o.EmployeeId = e.EmployeeId
JOIN (
    SELECT
        MAX(OrderDate) AS MaxOrderDate,
        MIN(OrderDate) AS MinOrderDate
    FROM
        [Sales].[Order]
) AS firstandlastdate ON OrderDate = MinOrderDate OR OrderDate = MaxOrderDate
ORDER BY
    Orderdate;




/*
		2) Write a query that summarizes all employees whose first names start with the letter 'P' and bytheir SalesYear.

		Tables involved: [Sales].[Order], [Sales].[OrderDetail], and [HumanResources].[Employee].

			a. Calculate the number of ActualNumberOfOrders sold 
			b. derive Total Sales using the Sales.OrderDetails (quantity and unit price).
			c. The query returns all orders placed by the employees slected

	Sample output is below:
					  EmployeeFullName		SalesYear	ActualNumberOfOrders		Total Sales 
						Patricia Doyle			2016				19					42020.75
						Patricia Doyle			2015				19					29577.55
						Patricia Doyle			2014				5					11365.70
						Paul Suurs				2016				19					14475.00
						Paul Suurs				2015				33					45992.00
						Paul Suurs				2014				15					17731.10	

*/

select * from HumanResources.employee

SELECT
    YEAR(o.OrderDate) AS SalesYear,
    COUNT(DISTINCT o.OrderId) AS ActualNumberOfOrders,
    SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM
    [HumanResources].[Employee] emp
JOIN
    [Sales].[Order] o ON emp.EmployeeId = o.EmployeeId
JOIN
    [Sales].[OrderDetail] od ON o.OrderId = od.OrderId
WHERE
    emp.EmployeeFirstName LIKE 'P%'
GROUP BY
    YEAR(o.OrderDate)
ORDER BY
    SalesYear;




/*
--	3) Find all of the customers that made no purchases 

		■ Tables involved: [Sales].[Order] and [Sales].[Customer]  in the subquery

			CustomerId		CustomerCompanyName
*/
SELECT
    CustomerId, customercompanyname
FROM
    [Sales].Customer c
WHERE
    NOT EXISTS (
        SELECT 1
        FROM [Sales].[Order] o
        WHERE o.CustomerId = c.CustomerId
    );


	 
/*
	4) Find the Maximum Order Date for Each Customer Using a Correlated Sub-Query with the Sales.Orders Table

		Tables Involved: [Sales].[Order] and [Sales].[Customer]
			
			a. The correlation is based on the CustomerId.
			b. Note that CustomerId 40 made two purchases on the same last day.

			Sample Output:

				CustomerId	CustomerCompanyName		OrderId		OrderDate		EmployeeId
				1			Customer NRZBB			11011		2016-04-09		3
				2			Customer MLTDN			10926		2016-03-04		4
				3			Customer KBUDE			10856		2016-01-28		3
				39			Customer GLLAG			11028		2016-04-16		2
				40			Customer EFFTC			10972		2016-03-24		4
				40			Customer EFFTC			10973		2016-03-24		6
				41			Customer XIIWM			11051		2016-04-27		7
*/
SELECT
    c.CustomerId,
    c.CustomerCompanyName,
    o.OrderId,
    o.OrderDate,
    o.EmployeeId
FROM
    [Sales].[Customer] c
JOIN
    [Sales].[Order] o ON c.CustomerId = o.CustomerId
WHERE
    o.OrderDate = (
        SELECT MAX(OrderDate)
        FROM [Sales].[Order] ord
        WHERE ord.CustomerId = c.CustomerId
    );


			

/*
	5) Find all of the distinct Customers orderscount by orderyear for the specific empid = 3
	
			■ Tables involved: [Sales].[Customer]and  [Sales].[.Order]  in the subquery

				EmployeeFirstName EmployeeLastName	EmployeeId	OrderYear	EmployeeCustomerCount
					Judy				Lew				3		2016				30
					Judy				Lew				3		2015				46
					Judy				Lew				3		2014				16
*/

SELECT
    emp.EmployeeFirstName,
    emp.EmployeeLastName,
    emp.EmployeeId,
    YEAR(o.OrderDate) AS OrderYear,
    COUNT(DISTINCT o.CustomerId) AS EmployeeCustomerCount
FROM
    [HumanResources].[Employee] as emp
JOIN
    [Sales].[Order] o ON emp.EmployeeId = o.EmployeeId
WHERE
    emp.EmployeeId = 3
GROUP BY
    emp.EmployeeFirstName,
    emp.EmployeeLastName,
    emp.EmployeeId,
    YEAR(o.OrderDate)
ORDER BY
    OrderYear;




/*
	6) Create an Inline Table-Valued Function (TVF) to Get All Customer Orders by CustomerId

		Tables involved: [Sales].[Customer], [Sales].[Order], and [Sales].[OrderDetail]

			a. The function name must be Sales.utvf_GetAllCustomerOrdersByCustomerID with one parameter, @CustomerId, of type int.
			b. Utilize the tables [Sales].[Order] and [Sales].[OrderDetail].
			c. After creating the function, write a query to find all customer orders and items ordered.
			d. Perform a 'GROUP BY' summarization of the customer information using [Sales].[Customer] with a CROSS APPLY to Sales.utvf_GetAllCustomerOrdersByCustomerID.

		Sample Output:

			CustomerCompanyName	CustomerId	Number Of Orders	Number Of Items Ordered
			Customer NRZBB			1				6						12
			Customer MLTDN			2				4						10
			Customer KBUDE			3				7						17
*/

create function inlinetable (Sales.utvf_GetAllCustomerOrdersByCustomerID int)
returns table
as
return select