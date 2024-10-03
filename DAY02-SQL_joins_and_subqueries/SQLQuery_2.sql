--SELECT
--WHERE
--ORDER BY
--JOIN

--Aggregation functions: 
--1. COUNT(): 

SELECT Count(OrderID) AS TotalRows
FROM Orders

SELECT Count(*) AS TotalRows
FROM Orders

--COUNT(*) vs. COUNT(colName):  

SELECT FirstName, Region
FROM Employees

SELECT COUNT(*), COUNT(Region)
FROM Employees

-- GROUP BY: group rows that have the same values into the summary rows

--find total number of orders placed by each customers

SELECT c.CustomerID, c.ContactName, COUNT(o.OrderID) AS NumOfOrders
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.ContactName
ORDER BY NumOfOrders

--a more complex template: 
--only retreive total order numbers where customers located in USA or Canada, and order number should be greater than or equal to 10

SELECT c.CustomerID, c.ContactName, c.Country, COUNT(o.OrderID) AS NumOfOrders
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country IN ('USA', 'Canada')
GROUP BY c.CustomerID, c.ContactName, c.Country
HAVING COUNT(o.OrderID) >=10
ORDER BY NumOfOrders

--WHERE vs. HAVING

--1. Having is applied to group as a whole but WHERE is applied to individual rows
--2. WHERE goes before aggregation but HAVING goes after aggregation
--3. Where can be used in select,update or delete but having can only be used in select statements. 

SELECT *
FROM Products

UPDATE Products
SET UnitPrice = 20
WHERE ProductID = 2

--SELECT fields, aggreate(fields)
--FROM table JOIN table2 ON ...
--WHERE criteria --optional
--GROUP BY fields 
--HAVING criteria --optional 
--ORDER BY fields DESC --optional 

--SQL execution order

--FROM/JOIN -----> WHERE -----> GROUP BY ---->HAVING ---> SELECT ----> DISTINCT ---> ORDER BY
--                  |__________________________|
--                   cann't use alias from select

SELECT c.CustomerID, c.ContactName, c.Country AS Cty, COUNT(o.OrderID) AS NumOfOrders
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country IN ('USA', 'Canada')
GROUP BY c.CustomerID, c.ContactName, c.Country
HAVING COUNT(o.OrderID) >=10
ORDER BY NumOfOrders


--DISTINCT: 
--COUNT DISTINCT: 

SELECT Region
FROM Employees

SELECT COUNT(Region), COUNT(DISTINCT Region)
FROM Employees

--2. AVG(): returns the average value of a numeric column
--list average revenue for each customer

SELECT C.ContactName, C.City, AVG(od.Quantity * od.UnitPrice) AS AvgRevenue
FROM Customers c JOIN Orders o ON c.CustomerID=o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY C.ContactName, C.City
ORDER BY AvgRevenue

--3. SUM(): returns the sum value of a numeric column
--list sum of revenue for each customer

SELECT C.ContactName, C.City, SUM(od.Quantity * od.UnitPrice) AS SumRevenue
FROM Customers c JOIN Orders o ON c.CustomerID=o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY C.ContactName, C.City
ORDER BY SumRevenue

--4. MAX(): 
--list maxinum revenue from each customer

SELECT C.ContactName, C.City, MAX(od.Quantity * od.UnitPrice) AS MaxRevenue
FROM Customers c JOIN Orders o ON c.CustomerID=o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY C.ContactName, C.City
ORDER BY MaxRevenue

--5.MIN(): 
--list the cheapeast product bought by each customer
USE Northwind
GO
SELECT C.ContactName, C.City, od.ProductID, MIN(od.UnitPrice) AS CheapestProduct
FROM Customers c JOIN Orders o ON c.CustomerID=o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY C.ContactName, C.City,od.ProductID
ORDER BY CheapestProduct

--TOP predicate: returns certain number or certain percentage of records from a query
--retrieve top 5 most expensive products

SELECT TOP 5
    ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--retrieve top 10 percent most expensive products

SELECT TOP 10 PERCENT
    ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--list top 5 customers who created the most total revenue

SELECT TOP 5
    C.ContactName, C.City, SUM(od.Quantity * od.UnitPrice) AS SumRevenue
FROM Customers c JOIN Orders o ON c.CustomerID=o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY C.ContactName, C.City
ORDER BY SumRevenue DESC

--Subquery: a select statement that is embedded in another select statement

--find the customers from the same city where Alejandra Camino lives 

SELECT ContactName, City
FROM Customers
WHERE City IN (
    SELECT City
FROM Customers
WHERE ContactName ='Alejandra Camino'
)

--find customers who make any orders

--JOIN

SELECT DISTINCT c.ContactName, c.CustomerID, c.City, c.Country
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID

--Subquery

SELECT CustomerID, ContactName, City, Country
FROM Customers
WHERE CustomerID IN 
(SELECT DISTINCT CustomerID
FROM Orders )

--subquery vs. join

--1. JOIN can be only be used in FROM clause but subquery can be used in select, from, where, having, order by


--get the order information like which employees deal with which order but limit the employees location to London:

--JOIN

SELECT o.OrderDate, e.FirstName, e.LastName, e.City
FROM Orders o JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE e.City = 'London'
ORDER BY o.OrderDate, e.FirstName, e.LastName

--Subquery

SELECT o.OrderDate, (SELECT e1.FirstName
    FROM Employees e1
    WHERE e1.EmployeeID = o.EmployeeID) AS FirstName,
    (SELECT e2.LastName
    FROM Employees e2
    WHERE e2.EmployeeID = o.EmployeeID) AS LastName
FROM Orders o
WHERE (
    SELECT e3.City
FROM Employees e3
WHERE e3.EmployeeID = o.EmployeeID
)  IN ('London')
ORDER BY o.OrderDate,  LastName, FirstName

--2. Subquery is easy to understand and maintain. 

--Let's find the customers who never placed any order

--join 

-- SELECT C.CustomerID, C.ContactName, C.City, C.Country
SELECT *
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL

--Subquery

SELECT c.CustomerID, c.ContactName, C.City, c.Country
FROM Customers c
WHERE c.CustomerID NOT IN(
    SELECT DISTINCT CustomerID
FROM Orders
)

--3. Usually JOIN has a better performance than a subquery.

--Physical joins: Merge join, hash join, neested loop join 

--Correlated Subquery: in which the inner query  is dependent on the outer query

--Customer name and total number of orders by customer

--JOIN

SELECT c.CustomerID, c.ContactName, c.City, COUNT(o.OrderID) AS NumOfOrders
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.ContactName, c.City
ORDER BY NumOfOrders DESC

--Subquery

SELECT c.CustomerID, c.ContactName, c.City, (SELECT COUNT(o.OrderId)
    FROM orders o
    WHERE o.CustomerID = c.CustomerID) AS totalnumoforders
FROM Customers c
ORDER BY totalnumoforders DESC

--derived table: subquery in a from clause 

SELECT dt.ContactName, dt.City
FROM (SELECT *
    FROM Customers) dt


--get customers information and the number of orders made by each customer

--join 

SELECT c.CustomerID, c.ContactName, c.City, COUNT(o.OrderID) AS NumOfOrders
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.ContactName, c.City
ORDER BY NumOfOrders DESC

--derived table

SELECT c.CustomerID, c.ContactName, c.City, dt.TotalNumOfOrders
FROM Customers c LEFT JOIN (
    SELECT CustomerId, Count(OrderId) AS TotalNumOfOrders
    FROM Orders
    GROUP BY CustomerId
) dt ON c.CustomerID = dt.CustomerID
ORDER BY dt.TotalNumOfOrders DESC


--Union vs. Union ALL: 

--Comman features: 1. Both union and union all are used to combine result sets vertically. 

    SELECT City, Country
    FROM Customers
UNION
    SELECT City, Country
    FROM Employees

    SELECT City, Country
    FROM Customers
UNION ALL
    SELECT City, Country
    FROM Employees

--              2. They both follow the same criteria: i. the number of the columns must be the same
-- ii.the data type of each column must be identical. 

    SELECT City, Country, ContactName
    FROM Customers
UNION
    SELECT City, Country
    FROM Employees


    SELECT City, Country, Region
    FROM Customers
UNION
    SELECT City, Country, EmployeeID
    FROM Employees

--differences
--1. Union will remove all the duplicate values from the result sets but union all will not. 
    SELECT City, Country
    FROM Customers
UNION
    SELECT City, Country
    FROM Employees

    SELECT City, Country
    FROM Customers
UNION ALL
    SELECT City, Country
    FROM Employees

--2. With Union, the first column of the result set will be sorted in ascending manner automatically. 
--3. Union can not be used in recursive cte but union all can be. 


--Window Function: will operate on set of rows and return a single aggregated value for each row by adding an extra column. 

--RANK(): will give a rank based on a certian order. 

--give a rank for a product price

SELECT ProductID, ProductName, UnitPrice, RANK() OVER(ORDER BY UnitPrice DESC) RNK
FROM Products

--product with the 2nd highest price 

SELECT dt.ProductName, dt.RNK
FROM (SELECT ProductID, ProductName, UnitPrice, RANK() OVER(ORDER BY UnitPrice DESC) RNK
    FROM Products) dt
WHERE dt.RNK = 2

--DENSE_RANK(): if you don't want any value gap then go with desne rank. 

SELECT ProductID, ProductName, UnitPrice, RANK() OVER(ORDER BY UnitPrice DESC) RNK, DENSE_RANK() OVER(ORDER BY UnitPrice DESC) DENSE_RNK
FROM Products

--ROW_NUMBER(): give the ranking of the sorted record starting from 1

SELECT ProductID, ProductName, UnitPrice, RANK() OVER(ORDER BY UnitPrice DESC) RNK, DENSE_RANK() OVER(ORDER BY UnitPrice DESC) DENSE_RNK,
    ROW_NUMBER() OVER(ORDER BY UnitPrice DESC) RowNum
FROM Products


--partition by: it will divide the result set into small partitions and perform calculation on each subset. Partition by is always used in conjunction with windows fucntion

--list customers from every country with the ranking for number of orders

SELECT c.ContactName, c.Country, COUNT(O.OrderID) AS TotalNumOfOrders, RANK() OVER( PARTITION BY c.Country ORDER BY COUNT(O.OrderID) DESC ) RNK
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName, c.Country

--- find top 3 customers from every country with maximum orders

SELECT dt.ContactName, dt.Country, dt.TotalNumOfOrders, dt.RNK
FROM (SELECT c.ContactName, c.Country, COUNT(O.OrderID) AS TotalNumOfOrders, RANK() OVER( PARTITION BY c.Country ORDER BY COUNT(O.OrderID) DESC ) RNK
    FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.ContactName, c.Country) dt
WHERE dt.RNK <=3

--cte: common table expression: a temproray named result set to make your query more readable

WITH
    OrderCountCTE
    AS

    (
        SELECT c.ContactName, c.CustomerID, c.Country, COUNT(O.OrderID) AS TotalNumOfOrders, RANK() OVER( PARTITION BY c.Country ORDER BY COUNT(O.OrderID) DESC ) RNK
        FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
        GROUP BY c.ContactName, c.Country, c.CustomerID
    )
SELECT c.ContactName, c.City, c.Country, cte.TotalNumOfOrders, cte.RNK
FROM Customers c JOIN OrderCountCTE cte ON c.CustomerID = cte.CustomerID

--lifecycle: use in the very next select statement, within a batch

WITH
    OrderCountCTE
    AS

    (
        SELECT c.ContactName, c.CustomerID, c.Country, COUNT(O.OrderID) AS TotalNumOfOrders, RANK() OVER( PARTITION BY c.Country ORDER BY COUNT(O.OrderID) DESC ) RNK
        FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
        GROUP BY c.ContactName, c.Country, c.CustomerID
    )
SELECT c.ContactName, c.City, c.Country, cte.TotalNumOfOrders, cte.RNK
FROM Customers c JOIN OrderCountCTE cte ON c.CustomerID = cte.CustomerID

--recursive CTE:  cte that call itslef recursively

--1. Initalization
--2. Recusive Rule


SELECT EmployeeID, FirstName, ReportsTo
FROM Employees

--level 1: Andrew
--level 2: Nancy, Janet, Margaret, Steven, Laura
--level 3: Michael, Robert, Anne

WITH EmployeeCTE
AS
    (
        SELECT EmployeeID, FirstName, LastName, 1 lvl
    FROM Employees
    WHERE ReportsTo IS NULL
UNION ALL
    SELECT e.EmployeeID, e.FirstName, e.LastName, cte.lvl +1
    FROM Employees e INNER JOIN EmployeeCTE cte ON e.ReportsTo = cte.EmployeeID
)

SELECT *
FROM EmployeeCTE