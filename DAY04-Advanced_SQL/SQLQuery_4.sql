--basic queries: select, where, order by,join, aggregation functions, group by, having
--advanced topics: subquery, CTE, window function, pagination, top
--temp tables
--table variables
--stored procedures
--user defined fucntions

--check constraint: limit the value range that can be placed into a column. 

SELECT * FROM Employee


INSERT INTO Employee VALUES (5, 'Monster', 5000)
INSERT INTO Employee VALUES (6, 'Monster', -5000)

DELETE Employee

ALTER TABLE Employee
ADD CONSTRAINT Chk_Age_Employee CHECK(Age BETWEEN 18 AND 65)

INSERT INTO Employee VALUES(1, 'Fred', 24)

--identity property

CREATE TABLE Product(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    ProductName VARCHAR(20) UNIQUE NOT NULL,
    UnitPrice Money
)

SELECT *
FROM Product

INSERT INTO Product VALUES ('Green Tea', 3)
INSERT INTO Product VALUES ('Latte', 4)
INSERT INTO Product VALUES ('Cold Brew', 5)


--truncate vs. delete 
--1. Delete is DML so it will not reset the property value. Truncate is DDL so it will reset the property value. 
--2. DELETE can be used with WHERE clause but truncate can't be

TRUNCATE TABLE Product

DELETE Product
WHERE Id = 3


--DROP: is a DDL statement that will delete the whole table 

--referential integrity: implemented by foreign key

--department table and employee table 

CREATE TABLE Department (
    Id INT PRIMARY KEY,
    DepartmentName VARCHAR(20),
    Location VARCHAR(20)
)

DROP TABLE Employee

CREATE TABLE Employee (
    Id INT PRIMARY KEY, 
    EmployeeName VARCHAR(20),
    Age INT CHECK(Age Between 18 AND 65),
    --DepartmentId INT FOREIGN KEY REFERENCES Department(Id) ON DELETE SET NULL
    DepartmentId INT FOREIGN KEY REFERENCES Department(Id) ON DELETE CASCADE
)

select * from Department

SELECT * FROM Employee

INSERT INTO Department VALUES (1, 'IT', 'Chicago')
INSERT INTO Department VALUES(2, 'HR', 'Sterling')
INSERT INTO Department VALUES(3, 'QA', 'Paris')

INSERT INTO Employee VALUES (1, 'Fred', 44, 1)

INSERT INTO Employee VALUES (4, 'Fred', 44, 4)

DELETE FROM Department
WHERE Id = 1

DELETE FROM Employee
WHERE Id = 1


--Composite primary key

--student table
--class table
--enrollment table : conjunction table

CREATE TABLE Student(
    Id INT PRIMARY KEY,
    StudentName VARCHAR(20)
)

CREATE TABLE Class(
    Id INT PRIMARY KEY,
    ClasssName VARCHAR(20)
)

CREATE TABLE Enrollment(
    StudentId INT NOT NULL, 
    ClassId INT NOT NULL,
    CONSTRAINT PK_Enrollment PRIMARY KEY(StudentId, ClassId),
    CONSTRAINT FK_Enrollment_Student FOREIGN KEY(StudentId) REFERENCES Student(Id),
    CONSTRAINT FK_Enrollment_Class FOREIGN KEY(ClassId) REFERENCES Class(Id)
)

CREATE TABLE Enrollment(
    StudentId INT , 
    ClassId INT,
    CONSTRAINT PK_Enrollment PRIMARY KEY(StudentId, ClassId),
    CONSTRAINT FK_Enrollment_Student FOREIGN KEY(StudentId) REFERENCES Student(Id),
    CONSTRAINT FK_Enrollment_Class FOREIGN KEY(ClassId) REFERENCES Class(Id)
)

CREATE TABLE Enrollment(
    StudentId INT  FOREIGN KEY(StudentId) REFERENCES Student(Id), 
    ClassId INT FOREIGN KEY(ClassId) REFERENCES Class(Id),
    CONSTRAINT PK_Enrollment PRIMARY KEY(StudentId, ClassId)
)

DROP TABLE Enrollment


--Transaction: group of logically related DML statements that will either succeed together or fail together. 
--3 modes:
--1. Autocommit Transaction: default one
--2. Implicit Transaction: 
--3. Explicit Transaction : Commit or Rollback, BEGIN Transaction 

DROP TABLE Product

CREATE TABLE Product(
    Id INT PRIMARY KEY ,
    ProductName VARCHAR(20) UNIQUE NOT NULL,
    UnitPrice Money,
    Quantity INT
)

SELECT * FROM Product

INSERT INTO Product VALUES (1, 'Green Tea', 3, 100)
INSERT INTO Product VALUES (2, 'Latte', 4, 100)
INSERT INTO Product VALUES (3, 'Cold Brew',5, 100)


--Properties
--ACID
--1. Atomicity: work must be atomic. 
--2. Consistency: whatever happens in the middle of the transaction, it will never leave out database in the half completed state. 
--3. Isolation: locking the resource
--4. Durability: changes are permanent in the database 


--concurrency problem: when two or more users are trying to access the same data. 

--1. Dirty Read : Happens if t1 allows t2 to read the uncommitted data and then t1 rolls back; happens when transaction level is read uncommitted 
--and is solved by using read committed isolation level 
--2. Lost Update: heppens when t1 and t2 read and update the same data but t2 finsihes its work earlier even though t1 started the transaction first.
--happens when isolation level is read committted and is solved by updating isolation level to repeatable read
--3. Non Repeatable Read : happens when t1 reads the same data twice while t2 is updating the data, happens when isolation level is read committed
--solved by updating the isolation level to repeatable read
--4. Phantom Read: happens when t1 reads the same data twice while t2 is inserting the data; happens when isolation level is repeatable read
--solved by updating the isolation level to serializable 


--index: on-disk structure that increases the data retrieval speed; increases the speed of the select statement. 

--clustered index: sort the record; pk will automatically generate the clustered index; there can be only one clustered index in a table since data can be only sorted in one way

--non-clustered index: will not sort the data; generated by uniqiue key constraint; one table can have multiple non-clustered index

CREATE TABLE Customer(
    Id INT,
    FullName VARCHAR(20),
    City VARCHAR(20),
    Country VARCHAR(20)
)

SELECT *
FROM Customer

--clsutered index
CREATE CLUSTERED INDEX Cluster_IX_Customer_Id ON Customer(Id)

INSERT INTO Customer VALUES ( 2, 'David', 'Chicago', 'US')
INSERT INTO Customer VALUES ( 1, 'Fred', 'NY', 'US')

DROP TABLE Customer

--non clustered index
CREATE INDEX NonCluster_IX_Customer_City ON Customer(City)

--non clustered index: create on those fileds that are frequently used on join, where clause or aggregation fields

--disadvantages:
--1. cost extra space
--2. slow down other DML statements like insert, update and delete


--PERFORMANCE TUNING 
--1. look into the execution plan/sql profiler 
--2. Create index wisely
--3. avoid unnecessary joins
--4. Avoid Select * 
--5. use a derived table to avoid grouping of non-aggregated field.
--6. if the query is implelmented using subquery, you can check if you can use join to replace subquery. 

