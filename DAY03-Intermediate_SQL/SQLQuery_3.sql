--aggregation functions + group by 
--subquery 
--derived tables
--union vs. union all 
--window function 
--cte

--temp table: store the data temproraily 

--local temp table: # 
--lifescope: is within the connection that created it. 
--stored in the tempdb database

CREATE TABLE #LocalTemp(
    Num INT
)
DECLARE @Variable INT = 1
WHILE (@Variable <= 10)
BEGIN 
INSERT INTO #LocalTemp(Num) VALUES (@Variable)
SET @Variable = @Variable + 1
END

SELECT *
FROM #LocalTemp


SELECT * 
FROM tempdb.sys.tables

--global temp table: ##
--lifescope: can be accessed by different sessions, also stored in tempdb

CREATE TABLE ##GlobalTemp(
    Num INT
)
DECLARE @Variable2 INT = 1
WHILE (@Variable2 <= 10)
BEGIN 
INSERT INTO ##GlobalTemp(Num) VALUES (@Variable2)
SET @Variable2 = @Variable2 + 1
END

SELECT *
FROM ##GlobalTemp

SELECT * 
FROM tempdb.sys.tables


--table variable: a variable of table type
--lifescope: submit and use within a single batch

DECLARE @today DATETIME
select @today = GETDATE()
PRINT @today


DECLARE @WeekDays TABLE (
    DayNum INT, 
    DayAbb VARCHAR(20),
    WeekName VARCHAR (20)
)
INSERT INTO  @WeekDays VALUES
(1, 'Mon', 'Monday'),
(2, 'Tue', 'Tuesday'),
(3, 'Wed', 'Wednesday'),
(4, 'Thus', 'Thursday'),
(5, 'Fri', 'Friday')


SELECT *
FROM @WeekDays


--temp tables vs. table variables
--1. Both are stored in tempdb database. 
--2. scope: local/global temp table; table variable: current batch
--3. size:>100 rows, go with temp tables, size<100 rows then go with table variables. 
--4. we can't use temp table in stored procedures or user defined functions but can use table variable in sp or udf. 


--View: virtual table that contains data from one or multiple tables. 

USE SepBatch
GO

SELECT *
FROM Employee

INSERT INTO Employee VALUES 
(1, 'Fred', 5000),
(2, 'Laura', 7000),
(3, 'Amy', 6000)


CREATE VIEW vwEmp 
AS 
SELECT Id, EName, Salary
FROM Employee

SELECT *
FROM vwEmp


--stored procedure: preprepared sql query that we can save in our database and reuse it whenever we want to. 

BEGIN
    PRINT 'Hello Anonymous Block'
END


CREATE PROC spHello
AS
BEGIN 
    PRINT 'Hello Anonymous Block'
END

EXEC spHello


--Advantages of sp:  
--1. it will allow you to reuse the same logic. 
--2. it can be used to prevent sql injection becuase it can take parameters. 

--sql injection: hackers inject malicious code into our SQL queries thus, destroying our database. 

SELECT Id, Name
FROM User 
WHERE Id = 1 UNION ALL SELECT Id, Password From User

SELECT Id, Name
FROM User 
WHERE Id = 1 OR 1 =1 

SELECT Id, Name
FROM User 
WHERE Id = 1 DROP TABLE User


--input: default type

CREATE PROC spAddNumbers
@a int, 
@b int
AS
BEGIN
    PRINT @a + @b
End 

EXEC spAddNumbers 1, 2

--output

CREATE PROC spGetName
@Id INT,
@EName VARCHAR(20) OUT
AS
BEGIN 
    SELECT @EName = EName
    FROM Employee
    WHERE Id = @Id
END


BEGIN
    DECLARE @En VARCHAR(20)
    EXEC spGetName 1, @En OUT
    PRINT @En
END

--sp can also return tables

CREATE Proc spGetAllEmp
AS
BEGIN
    SELECT *
    FROM Employee
END

EXEC spGetAllEmp


--trigger: special type of sp that will automatically run when there is an event that occurs. 
--DML Trigger
--DDL Trigger
--LogOn Trigger


--lifescope sp and views: will stay in db forever as long as you don't drop them 


--FUNCTIONS:
--Biilt-in:
--User defined functions:  for calculations

CREATE FUNCTION GetTotalRevenue (@price money, @discount real, @quantity int)
RETURNS money
AS
BEGIN
    DECLARE @revenue money
    SET @revenue = @price * (1-@discount) * @quantity
    RETURN @revenue
END


SELECT UnitPrice, Quantity, Discount, dbo.GetTotalRevenue(UnitPrice, Discount, Quantity) AS Revenue
FROM [Order Details]


--benefit of using udf:

CREATE FUNCTION ExpensiveProduct(@threshold money)
RETURNS TABLE
AS 
RETURN SELECT *
        FROM Products
        WHERE UnitPrice > @threshold

SELECT *
FROM dbo.ExpensiveProduct(10)

--sp vs. udf
--1. Usage: sp for DML, udf for calculations
--2. how to call: sp will be called by its name after exec keyword but udf must be called in sql statements
--3. input/output: sp may or may not have input or output parameters.But udf may or may not have input parameter but it must have output parameter. 
--4. sp can be used to call udf but udf can not call sp.


--Pagination: 

--OFFSET: skip 
--FETCH NEXT x ROWS: Select

SELECT CustomerId, ContactName, City
FROM Customers 
ORDER BY CustomerId
OFFSET 10 Rows

SELECT CustomerId, ContactName, City
FROM Customers 
ORDER BY CustomerId
OFFSET 92 Rows

SELECT CustomerId, ContactName, City
FROM Customers 
ORDER BY CustomerId
OFFSET 10 Rows
FETCH NEXT 10 ROWS ONLY

--TOP vs offset, fetch next

--Top: fetch top several records, use it with or without ORDER BY 
--offset and fetch: only use it with ORDER BY

DECLARE @PageNum INT 
DECLARE @RowsOfPage INT 
DECLARE @MaxTablePage FLOAT
SET @PageNum =1
SET @RowsOfPage = 10
SELECT @MaxTablePage = Count(*) FROM Customers
SET @MaxTablePage = CEILING(@MaxTablePage/@RowsOfPage)
WHILE @PageNum <= @MaxTablePage
BEGIN
SELECT CustomerId, ContactName, City
FROM Customers 
ORDER BY CustomerId
OFFSET (@PageNum -1) * @RowsOfPage ROWS
FETCH NEXT @RowsOfPage ROWS ONLY
SET @PageNum = @PageNum + 1
END

--Normalization

--one to many relationship: 
--many to many relationship: create a conjuntion table
--student table and class table : enrollment table 
 

 -- student table ---- enrollment table --- class table 


--Constraints

USE SepBatch
GO

DROP TABLE Employee

CREATE TABLE Employee(
    Id INT PRIMARY KEY , 
    EName VARCHAR(20) NOT NULL,
    Age INT
)

INSERT INTO Employee VALUES (1, 'Sam', 45)
INSERT INTO Employee VALUES (null, 'Fiona', 23)

SELECT *
FROM Employee

INSERT INTO Employee VALUES (null, null, null)


--primary key vs. unique constraint
--1. Unique key will accept one and only null value but primary key will not accept any null value. 
--2. One table can have multiple unique keys but only one pk. 
--3. pk will sort the data by default but unique key will not. 
--4. Pk will create clustered index by default and unique keu will create non clustered index. 


DELETE  Employee

INSERT INTO Employee VALUES (4, 'Sam', 45)
INSERT INTO Employee VALUES (2, 'Fiona', 23)
INSERT INTO Employee VALUES (3, 'Fred', 45)
INSERT INTO Employee VALUES (1, 'Stella', 23)