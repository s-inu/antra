-- 1.      List all cities that have both Employees and Customers.
SELECT DISTINCT e.City
FROM Employees e JOIN Customers c ON e.City = c.City;


-- 2.      List all cities that have Customers but no Employee.
--    a.      Use sub-query
SELECT DISTINCT c.City
FROM Customers c
WHERE c.City NOT IN (
  SELECT e.City
FROM Employees e
);

--    b.      Do not use sub-query
SELECT DISTINCT c.City
FROM Customers c LEFT JOIN Employees e ON c.City = e.City
WHERE e.City IS NULL;

-- 3.      List all products and their total order quantities throughout all orders.
SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantity
FROM Products p
  JOIN OrderDetails od
  ON p.ProductID = od.ProductID
GROUP BY p.ProductName;


-- 4.      List all Customer Cities
SELECT c.City, SUM(od.Quantity) AS TotalProductsOrdered
FROM Customers c
  JOIN Orders o ON c.CustomerID = o.CustomerID
  JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.City;


-- 5.      List all Customer Cities that have at least two customers.
SELECT c.City, COUNT(c.CustomerID) AS CustomerCount
FROM Customers c
GROUP BY c.City
HAVING COUNT(c.CustomerID) >= 2;


-- 6.      List all Customer Cities that have ordered at least two different kinds of products.
SELECT c.City, COUNT(DISTINCT od.ProductID) AS ProductCount
FROM Customers c
  JOIN Orders o
  ON c.CustomerID = o.CustomerID
  JOIN OrderDetails od
  ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID) >= 2;


-- 7.      List all Customers who have ordered products, but have the ‘ship city’ on the order different from their own customer cities.
SELECT c.CustomerID, c.City AS CustomerCity, o.ShipCity
FROM Customers c
  JOIN Orders o
  ON c.CustomerID = o.CustomerID
WHERE c.City <> o.ShipCity;


-- 8.      List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
WITH
  ProductPopularity
  AS
  (
    SELECT p.ProductID, p.ProductName, AVG(p.UnitPrice) AS AvgPrice, SUM(od.Quantity) AS TotalQuantity
    FROM Products p
      JOIN OrderDetails od
      ON p.ProductID = od.ProductID
    GROUP BY p.ProductID, p.ProductName
  ),
  CityOrderQuantities
  AS
  (
    SELECT p.ProductID, c.City, SUM(od.Quantity) AS CityQuantity
    FROM Products p
      JOIN OrderDetails od
      ON p.ProductID = od.ProductID
      JOIN Orders o
      ON od.OrderID = o.OrderID
      JOIN Customers c
      ON o.CustomerID = c.CustomerID
    GROUP BY p.ProductID, c.City
  )
SELECT TOP 5
  pp.ProductName, pp.AvgPrice, pp.TotalQuantity, coq.City
FROM ProductPopularity pp
  JOIN CityOrderQuantities coq
  ON pp.ProductID = coq.ProductID
WHERE coq.CityQuantity = (
  SELECT MAX(coq2.CityQuantity)
FROM CityOrderQuantities coq2
WHERE coq2.ProductID = coq.ProductID
)
ORDER BY pp.TotalQuantity DESC;



-- 9.      List all cities that have never ordered something but we have employees there.
--    a.      Use sub-query
SELECT DISTINCT e.City
FROM Employees e
WHERE e.City NOT IN (
  SELECT DISTINCT c.City
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
)

--    b.      Do not use sub-query
SELECT DISTINCT e.City
FROM Employees e
  LEFT JOIN Customers c
  ON e.City = c.City
  LEFT JOIN Orders o
  ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;


-- 10.  List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, and also the city of most total quantity of products ordered from. (tip: join  sub-query)
WITH
  EmployeeSales
  AS
  (
    SELECT e.City, COUNT(o.OrderID) AS TotalOrders
    FROM Employees e
      JOIN Orders o
      ON e.EmployeeID = o.EmployeeID
    GROUP BY e.City
  ),
  ProductOrders
  AS
  (
    SELECT c.City, SUM(od.Quantity) AS TotalQuantity
    FROM Customers c
      JOIN Orders o
      ON c.CustomerID = o.CustomerID
      JOIN OrderDetails od
      ON o.OrderID = od.OrderID
    GROUP BY c.City
  )
SELECT TOP 1
  es.City
FROM EmployeeSales es
  JOIN ProductOrders po
  ON es.City = po.City
ORDER BY es.TotalOrders DESC, po.TotalQuantity DESC;


-- 11.  How do you remove the duplicates record of a table?
WITH
  CTE
  AS
  (
    SELECT
      EmployeeID,
      LastName,
      FirstName,
      ROW_NUMBER() OVER (PARTITION BY LastName, FirstName ORDER BY EmployeeID) AS RowNum
    FROM Employees
  ) -- -- Assuming that duplicates are defined by matching 'LastName' and 'FirstName' columns
DELETE FROM CTE
WHERE RowNum > 1;

