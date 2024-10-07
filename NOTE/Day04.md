local temp table vs global temp table
- ??? while & for loop
- ??? enhanced operator += support
- `#` vs `##`
- life scope
  - local
    - current query
    - ??? tempdb/
  - global
    - across sessions
    - ??? tempdb/
    - ??? non-duplicate
- ??? Insert, Values vs Value

table variable
- single batch life scope

!!!temp table vs table variable
- both tempdb/
- life scope
- >100 rows vs <100
- no stored procedure nor user defined function vs yes

view
- forever
- ??? motivation

stored procedure
- life scope: forever
- Programmability/Stored Procedures
- advantages
  - reuse
  - prevent SQL injection, because it takes params
- input type(default) & output type
- ??? rule of thumb
- ??? end-user
- ??? delete and update sp

SQL injection


trigger
??? DDL, DML


functions
- Programmability/Scalar-valued Functions
- built-ins
- user defined function
  - ??? simply return
  - ??? how does built-ins take param
  - ??? dbo is an object `dbo.GetTotalRevenue`

sp vs udf
- sp: DML, select, insert, update, delete
- `EXEC` sp; udf in statement
- sp: optional input/output param; udf: optional input, required output
- ??? sp can call udf, but udf cannot call sp

pagination
- `OFFSET n ROWS`,`FETCH NEXT n ROWS ONLY`

top vs offset
- top: top several, w/ or w/o `ORDER BY`
- offset and fetch: only with `ORDER BY`

normalization
??? normalization
- 1st normal form: atomic value
- 2nd: no partial dependency
- 3rd: no transitive dep
- one-to-many
- many-to-many

constraints
null, null, null
- `NOT NULL`
- `UNIQUE`
- `PRIMARY KEY`

`UNIQUE` vs `PRIMARY KEY`
- `UNIQUE` allows single one `null`, but `PRIMARY KEY` does not
- multiple unique keys but only one primary key is allowed
```sql
-- composite key example
CREATE TABLE Employees (
    EmployeeID INT,
    DepartmentID INT,
    StartDate DATE,
    -- Define composite primary key on EmployeeID and DepartmentID
    PRIMARY KEY (EmployeeID, DepartmentID)
);
```
- The table keeps sorted in `PRIMARY KEY` [MS Learn](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-table-keys#:~:text=SQL%20Server%20keeps%20the%20table%20sorted%20in%20primary%20key%20order)
- ??? primary key creates *clustered index* by default, while unique key creates non-clustered index