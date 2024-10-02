
USE Northwind
GO

--SELECT statement: 
--1. SELECT all columns and rows

SELECT *
FROM Customers

--2. SELECT a list of columns

SELECT CustomerId, CompanyName, ContactName
FROM Customers

SELECT c.CompanyName, c.City
FROM Customers AS c

--avoid using SELECT *

--1. unnecessary data

SELECT *
FROM Employees

--2. Naming conflicts

SELECT *
FROM Employees

SELECT *
FROM Customers

SELECT *
FROM Customers c Join Orders o ON C.CustomerID = o.CustomerID JOIN Employees e ON e.EmployeeID = o.EmployeeID

--3. SELECT DISTINCT Value: removes all the duplicate values 
--list all the cities that employees are located at

SELECT City
FROM Employees

SELECT DISTINCT City
FROM Employees

SELECT City, Country
FROM Employees

SELECT DISTINCT City, Country
FROM Employees

--4. SELECT combined with plain text: retrieve the full name of employees

SELECT FirstName, LastName, FirstName + ' ' + LastName AS FullName
FROM Employees


--identifiers: simply the names given to the database, tables, views, sp, etc. 

--1.Regular Identifier: i) first charcter: lowercase A-z, uppercase A-z, @, #
                                --@ : define or declare a variable
                                DECLARE @today DATETIME
                                SELECT @today = GETDATE()
                                PRINT @today

                                --# : temp tables
                                    --# : local temp table
                                    --## : global temp table 

                      --ii) Subsequent character: a-z, A-Z, 0-9, @, #, $
                      --iii) must not be a sql reserve word
                      --iv) embedded space is not allowed 

--2. Delimited Identifier: [] or " "

SELECT FirstName, LastName, FirstName + ' ' + LastName AS "Full Name"
FROM Employees

SELECT *
FROM [Order Details]

--WHERE statement: filter the records row by row 

--Customers who are from Germany

SELECT c.ContactName, c.Country, c.City
FROM Customers c
WHERE Country = 'Germany'


--Product which price is $18

SELECT p.ProductID, p.UnitPrice
FROM Products p
WHERE UnitPrice = 18

--2. Customers who are not from UK

SELECT c.ContactName, c.Country, c.City
FROM Customers c
WHERE Country != 'UK'

SELECT c.ContactName, c.Country, c.City
FROM Customers c
WHERE Country <> 'UK'

--IN Operator: 
--E.g: Orders that ship to USA AND Canada

SELECT o.OrderID, o.ShipCity, o.ShipCountry
FROM Orders o
WHERE ShipCountry = 'USA' OR ShipCountry = 'Canada'


SELECT o.OrderID, o.ShipCity, o.ShipCountry
FROM Orders o
WHERE ShipCountry IN ('USA', 'Canada')

--BETWEEN Operator: 
--1. retreive products whose price is between 20 and 30.

SELECT p.ProductName, p.UnitPrice
FROM Products p
WHERE UnitPrice >=20 AND UnitPrice <=30

SELECT p.ProductName, p.UnitPrice
FROM Products p
WHERE UnitPrice BETWEEN 20 AND 30


--NOT Operator: 

-- list orders that does not ship to USA or Canada

SELECT o.OrderID, o.ShipCity, o.ShipCountry
FROM Orders o
WHERE ShipCountry NOT IN ('USA', 'Canada')

SELECT o.OrderID, o.ShipCity, o.ShipCountry
FROM Orders o
WHERE NOT ShipCountry  IN ('USA', 'Canada')


SELECT p.ProductName, p.UnitPrice
FROM Products p
WHERE UnitPrice NOT BETWEEN 20 AND 30

SELECT p.ProductName, p.UnitPrice
FROM Products p
WHERE not UnitPrice  BETWEEN 20 AND 30

--NULL Value: 
--check which employees' region information is empty

SELECT e.FirstName, e.LastName, e.Region
FROM Employees e
WHERE Region is NULL

--exclude the employees whose region is null

SELECT e.FirstName, e.LastName, e.Region
FROM Employees e
WHERE Region is not NULL


--Null in numerical operation

CREATE TABLE TestSalary(EId int primary key identity(1,1), Salary money, Comm money)
INSERT INTO TestSalary VALUES(2000, 500), (2000, NULL),(1500, 500),(2000, 0),(NULL, 500),(NULL,NULL)

SELECT *
FROM TestSalary

SELECT Salary, Comm, ISNULL(Salary, 0) + ISNULL(Comm, 0) AS TotalCompensation
FROM TestSalary


--LIKE Operator: used to create search experession

--1. Work with % wildcard character: 

--retrieve all the employees whose last name starts with D

SELECT e.FirstName, e.LastName, e.BirthDate
FROM Employees e
WHERE LastName LIKE 'D%'


--2. Work with [] and % to search in ranges: 

--find customers whose postal code starts with number between 0 and 3

SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode LIKE '[0-3]%'


--3. Work with NOT: 

SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode NOT LIKE '[0-3]%'

--4. Work with ^: 

SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode  LIKE '[^0-3]%'

--Customer name starting from letter A but not followed by l-n

SELECT ContactName, PostalCode
FROM Customers
WHERE ContactName LIKE 'A[^l-n]%'

--ORDER BY statement: sort the result set in the ascending order or descending order

--1. retrieve all customers except those in Boston and sort by Name

SELECT ContactName, City
FROM Customers
WHERE City != 'Boston'
ORDER BY ContactName

SELECT ContactName, City
FROM Customers
WHERE City != 'Boston'
ORDER BY ContactName DESC

--2. retrieve product name and unit price, and sort by unit price in descending order

SELECT p.ProductName, p.UnitPrice
FROM Products p
ORDER BY UnitPrice DESC

--3. Order by multiple columns

SELECT p.ProductName, p.UnitPrice
FROM Products p
ORDER BY UnitPrice DESC, ProductName DESC

SELECT p.ProductName, p.UnitPrice
FROM Products p
ORDER BY 2 DESC, 1 DESC


--JOIN: 

--1. INNER JOIN: return the records that have matching values in both tables in the realted column

--find employees who have deal with any orders

SELECT e.FirstName + ' '+ e.LastName AS "Full Name", o.OrderDate
FROM Employees AS e INNER JOIN Orders AS o ON e.EmployeeID = o.EmployeeID

--get cusotmers information and corresponding order date

SELECT c.ContactName, c.City, c.Address, o.OrderDate
FROM Customers c INNER JOIN Orders o ON c.CustomerID= o.CustomerID

SELECT c.ContactName, c.City, c.Address, o.OrderDate
FROM Customers c, Orders o
WHERE c.CustomerID = o.CustomerID

--join multiple tables:
--get customer name, the corresponding employee who is responsible for this order, and the order date

SELECT c.ContactName, e.FirstName + ' '+ e.LastName AS "Full Name", o.OrderDate
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID

--add detailed information about quantity and price, join Order details

SELECT c.ContactName, e.FirstName + ' '+ e.LastName AS "Full Name", o.OrderDate, od.UnitPrice
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID 
INNER JOIN [Order Details] od ON od.OrderID = O.OrderID


--2. OUTER JOIN: 

--1) LEFT OUTER JOIN: return all the records from the left table and matching records from the right table, if we can't find any matcing records 
--then for that row, we are going to return null. 

--list all customers whether they have made any purchase or not

SELECT C.ContactName, c.CompanyName, c.City, o.OrderDate
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID


--JOIN with WHERE: 
--customers who never placed any order

SELECT C.ContactName, c.CompanyName, c.City, o.OrderDate
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate IS Null

--2) RIGHT OUTER JOIN: return all the records from the right table and matching records from the left table, if we can't find any matching records 
--then for that row, we are going to return null. 

--list all customers whether they have made any purchase or not

SELECT C.ContactName, c.CompanyName, c.City, o.OrderDate
FROM Orders o RIGHT JOIN Customers c ON c.CustomerID = o.CustomerID
ORDER BY o.OrderDate


--3) FULL OUTER JOIN: return all the rows from both left and right table even if no matching value is found.

--Match all customers and suppliers by country.

SELECT C.ContactName as customer, c.Country as customerCountry, s.Country as supplierCountry, s.ContactName as Supplier
FROM Customers c FULL JOIN Suppliers s ON c.Country = S.Country


--3. CROSS JOIN: cartesian product of two tables 

SELECT *
FROM Customers

SELECT *
From Orders

SELECT *
FROM Customers CROSS JOIN Orders 

--* SELF JOIN：joins a table with itself


SELECT EmployeeID, FirstName, LastName, ReportsTo
FROM Employees


--CEO : Andrew
--Mangers: Nancy, Janet, Margaret, Steven, Laura
--Employee: Michael, Robert, Anne

--find emloyees with the their manager name

SELECT e.FirstName + ' ' + e.LastName AS Employee, m.FirstName+ ' '+m.LastName As Manager
FROM Employees e INNER JOIN Employees m ON e.ReportsTo = m.EmployeeID

SELECT e.FirstName + ' ' + e.LastName AS Employee, m.FirstName+ ' '+m.LastName As Manager
FROM Employees e LEFT JOIN Employees m ON e.ReportsTo = m.EmployeeID

--Batch Directives

USE Northwind
GO

CREATE DATABASE SepBatch
GO
USE SepBatch
GO
CREATE TABLE Employee(Id int, EName varchar(20), Salary money)

