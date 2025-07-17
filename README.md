# Dynamic SQL and SQL Injection Security Guide

This guide is based on practical examples demonstrated by Jeff Honsowetz during the SQL Fundamentals session at Data Hikers Business Technologist Online Meetup. For hands-on practice, visit dbfiddle.uk and create a safe testing environment.

## What is Dynamic SQL?

Dynamic SQL is SQL code constructed and executed at runtime, rather than being hardcoded. It allows the structure of queries (tables, columns, conditions) to change based on user input, application logic, or external data. For example, instead of a fixed query like:

```sql
SELECT * FROM users WHERE age = 30
```

You might build a query where the column, table, or filter value is determined at runtime, such as:

```sql
SELECT * FROM $table WHERE $column = $value
```

Dynamic SQL is powerful for scenarios requiring flexibility, such as generating reports with varying filters or handling dynamic schemas. However, it’s prone to SQL injection if parameters aren’t sanitized properly. Always use parameterized queries or prepared statements to stay secure. Dynamic SQL can also be harder to debug and optimize compared to static SQL.

## What is SQL Injection Attack?

SQL Injection (SQLi) is a cyberattack where malicious SQL statements are inserted into an entry field for execution by a database. It’s a code injection technique targeting data-driven applications, most commonly web applications. The vulnerability arises when an application constructs database queries using unvalidated or improperly sanitized user input, mistakenly interpreting parts of the input as executable SQL code.

## Testing Your Knowledge

### Safe Practice Environment

**Step 1: Set Up a Safe Testing Environment**

You can safely test these concepts using dbfiddle.uk. Create a new fiddle to experiment with SQL queries in a controlled environment.

**Step 2: Create a Sample Database**

Create a sample `Customers` and `Orders` tables to test your queries:

```sql
CREATE TABLE [dbo].[Customers](
	[CustomerID] [varchar](40) NOT NULL,
	[CompanyName] [varchar](40) NULL,
	[ContactName] [varchar](30) NULL,
	[ContactTitle] [varchar](30) NULL,
	[Address] [varchar](60) NULL,
	[City] [varchar](15) NULL,
	[Region] [varchar](25) NULL,
	[PostalCode] [varchar](20) NULL,
	[Country] [varchar](15) NULL,
	[Phone] [varchar](24) NULL,
	[Latitude] [decimal](14, 10) NULL,
	[Longitude] [decimal](14, 10) NULL
) 

CREATE TABLE [dbo].[Orders](
	[OrderID] [int] NOT NULL,
	[CustomerID] [varchar](40) NULL,
	[OrderDate] [date] NULL,
	[Freight] [decimal](18, 4) NULL,
	[ShipName] [varchar](40) NULL,
	[ShipAddress] [varchar](60) NULL,
	[ShipCity] [varchar](15) NULL,
	[ShipRegion] [varchar](25) NULL,
	[ShipPostalCode] [varchar](20) NULL,
	[ShipCountry] [varchar](15) NULL
) ;

```
**Step 3: Run SQL Code**

Insert the SQL code into the batch field on dbfiddle.uk and click "Run" to execute.

**Step 4:  Insert Sample Data**

```

INSERT [dbo].[Customers] VALUES (N'ALFKI', N'Alfreds Futterkiste', N'Alfred Futter', N'Sales Representative', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany', N'030-0074321', CAST(52.5316770000 AS Decimal(14, 10)), CAST(13.3817770000 AS Decimal(14, 10)))
;
INSERT [dbo].[Customers] VALUES (N'ANATR', N'Ana Trujillo Emparedados y helados', N'ana tijo', N'Owner', N'Avda. de la Constitución 2222', N'México D.F.', NULL, N'05021', N'Mexico', N'(5) 555-4729', CAST(19.4326080000 AS Decimal(14, 10)), CAST(-99.1332090000 AS Decimal(14, 10)))
;
INSERT [dbo].[Customers] VALUES (N'AROUT', N'Around the Hor', N'Thomas Hardy', N'Sales Representative', N'120 Hanover Sq.', N'London', NULL, N'WA1 1DP', N'UK', N'(171) 555-7788', CAST(51.5098650000 AS Decimal(14, 10)), CAST(-0.1180920000 AS Decimal(14, 10)))
;
INSERT [dbo].[Customers] VALUES (N'BERGS', N'Berglunds snabbköp', N'Christina Berglund', N'Order Administrator', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Sweden', N'0921-12 34 65', CAST(65.5848160000 AS Decimal(14, 10)), CAST(22.1567040000 AS Decimal(14, 10)))
;
INSERT [dbo].[Customers] VALUES (N'BLONP', N'Blondesddsl père et fils', N'Frédérique Citeaux', N'Marketing Manager', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France', N'88.60.15.31', CAST(48.5800020000 AS Decimal(14, 10)), CAST(7.7500000000 AS Decimal(14, 10)))
;
INSERT [dbo].[Orders]  VALUES (10265, N'BLONP', CAST(N'1996-07-25' AS Date), CAST(55.2800 AS Decimal(18, 4)), N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France')
;
INSERT [dbo].[Orders]  VALUES (10278, N'BERGS', CAST(N'1996-08-12' AS Date), CAST(92.6900 AS Decimal(18, 4)), N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Sweden')
;
INSERT [dbo].[Orders]  VALUES (10280, N'BERGS', CAST(N'1996-08-14' AS Date), CAST(8.9800 AS Decimal(18, 4)), N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Sweden')
;
INSERT [dbo].[Orders]  VALUES (10297, N'BLONP', CAST(N'1996-09-04' AS Date), CAST(5.7400 AS Decimal(18, 4)), N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France')
;
INSERT [dbo].[Orders]  VALUES (10308, N'ANATR', CAST(N'1996-09-18' AS Date), CAST(1.6100 AS Decimal(18, 4)), N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', NULL, N'05021', N'Mexico')
;
INSERT [dbo].[Orders]  VALUES (10355, N'AROUT', CAST(N'1996-11-15' AS Date), CAST(41.9500 AS Decimal(18, 4)), N'Around the Hor', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')
;
INSERT [dbo].[Orders]  VALUES (10360, N'BLONP', CAST(N'1996-11-22' AS Date), CAST(131.7000 AS Decimal(18, 4)), N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France')
;
INSERT [dbo].[Orders]  VALUES (10383, N'AROUT', CAST(N'1996-12-16' AS Date), CAST(34.2400 AS Decimal(18, 4)), N'Around the Hor', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')
;
INSERT [dbo].[Orders]  VALUES (10384, N'BERGS', CAST(N'1996-12-16' AS Date), CAST(168.6400 AS Decimal(18, 4)), N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Sweden')
;
INSERT [dbo].[Orders]  VALUES (10436, N'BLONP', CAST(N'1997-02-05' AS Date), CAST(156.6600 AS Decimal(18, 4)), N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France')
;
INSERT [dbo].[Orders]  VALUES (10444, N'BERGS', CAST(N'1997-02-12' AS Date), CAST(3.5000 AS Decimal(18, 4)), N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Sweden')
;
INSERT [dbo].[Orders]  VALUES (10445, N'BERGS', CAST(N'1997-02-13' AS Date), CAST(9.3000 AS Decimal(18, 4)), N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Sweden')
;
INSERT [dbo].[Orders]  VALUES (10449, N'BLONP', CAST(N'1997-02-18' AS Date), CAST(53.3000 AS Decimal(18, 4)), N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France')
;
INSERT [dbo].[Orders]  VALUES (10453, N'AROUT', CAST(N'1997-02-21' AS Date), CAST(25.3600 AS Decimal(18, 4)), N'Around the Hor', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')
;
INSERT [dbo].[Orders]  VALUES (10524, N'BERGS', CAST(N'1997-05-01' AS Date), CAST(244.7900 AS Decimal(18, 4)), N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Sweden')
;
INSERT [dbo].[Orders]  VALUES (10558, N'AROUT', CAST(N'1997-06-04' AS Date), CAST(72.9700 AS Decimal(18, 4)), N'Around the Hor', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK')
;
INSERT [dbo].[Orders]  VALUES (10559, N'BLONP', CAST(N'1997-06-05' AS Date), CAST(8.0500 AS Decimal(18, 4)), N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France')
;
INSERT [dbo].[Orders]  VALUES (10584, N'BLONP', CAST(N'1997-06-30' AS Date), CAST(59.1400 AS Decimal(18, 4)), N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France')
;
INSERT [dbo].[Orders]  VALUES (10625, N'ANATR', CAST(N'1997-08-08' AS Date), CAST(43.9000 AS Decimal(18, 4)), N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', NULL, N'05021', N'Mexico')
;
INSERT [dbo].[Orders]  VALUES (10626, N'BERGS', CAST(N'1997-08-11' AS Date), CAST(138.6900 AS Decimal(18, 4)), N'Berglunds snabbköp', N'Berguvsvägen  8', N'Luleå', NULL, N'S-958 22', N'Sweden')
;
INSERT [dbo].[Orders]  VALUES (10628, N'BLONP', CAST(N'1997-08-12' AS Date), CAST(30.3600 AS Decimal(18, 4)), N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France')
;

```

**Step 5: Start with Safe Examples**

Below are examples to demonstrate static and dynamic SQL, along with their security implications.

#### Example A: Static SQL (Baseline)

```sql
SELECT
    o.OrderID,
    o.CustomerID,
    c.CompanyName,
    o.OrderDate,
    o.ShipCity
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
    ON o.CustomerID = c.CustomerID
WHERE o.ShipCity = 'Colchester';
```

**Security Level: SAFE**\
This is a static query with hardcoded values. No user input is involved, making it immune to SQL injection.

#### Example B: Basic Dynamic SQL

```sql
DECLARE @sql AS nvarchar(max);
SET @sql = '
SELECT
    o.OrderID,
    o.CustomerID,
    c.CompanyName,
    o.OrderDate,
    o.ShipCity
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
    ON o.CustomerID = c.CustomerID
WHERE o.ShipCity = ''Colchester''';
PRINT @sql;
EXEC (@sql);
```

**Security Level: SAFE**\
This dynamic SQL is still safe because the query string is hardcoded without user input. However, it demonstrates the structure of dynamic SQL.

#### Example C: String Concatenation

```sql
DECLARE @City AS nvarchar(200);
SET @City = 'Colchester';
DECLARE @sql AS nvarchar(max);
SET @sql = '
SELECT
    o.OrderID,
    o.CustomerID,
    c.CompanyName,
    o.OrderDate,
    o.ShipCity
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
    ON o.CustomerID = c.CustomerID
WHERE o.ShipCity = ''' + @City + '''';
PRINT @sql;
EXEC (@sql);
```

**Security Level: VULNERABLE**\
Direct string concatenation opens the door to SQL injection attacks if `@City` contains malicious input. For example, a malicious user could set `@City` to `'Colchester'; DROP TABLE Orders; --`.

#### Example D: Variable Declaration in Dynamic SQL

```sql
DECLARE @City AS nvarchar(200);
SET @City = 'Colchester';
DECLARE @sql AS nvarchar(max);
SET @sql = '
DECLARE @City AS nvarchar(200) = ''' + @City + ''';
SELECT
    o.OrderID,
    o.CustomerID,
    c.CompanyName,
    o.OrderDate,
    o.ShipCity
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
    ON o.CustomerID = c.CustomerID
WHERE o.ShipCity = @City';
PRINT @sql;
EXEC (@sql);
```

**Security Level: VULNERABLE**\
Even though a variable is used inside the dynamic SQL, the initial concatenation still creates a vulnerability. Malicious input in `@City` can still manipulate the query.

#### Example E: Parameterized Query (SECURE)

```sql
DECLARE @City AS nvarchar(200);
SET @City = 'Colchester';
DECLARE @sql AS nvarchar(max);
SET @sql = '
SELECT
    o.OrderID,
    o.CustomerID,
    c.CompanyName,
    o.OrderDate,
    o.ShipCity
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
    ON o.CustomerID = c.CustomerID
WHERE o.ShipCity = @City';
EXEC sp_executesql @sql, N'@City nvarchar(200)', @City = @City;
```

**Security Level: SECURE**\
Using `sp_executesql` with parameterized queries ensures that user input is treated as data, not executable code, preventing SQL injection.

**Step 5: Practice Running SQL Injections (For Educational Purposes Only)**

#### Example F: Check Initial Data

Before running SQL injection examples, verify the number of records in the `Orders` table:

```sql
SELECT COUNT(*) FROM [dbo].[Orders];
```

**Result**: Assume it returns 21 records.

#### Example G: Malicious DELETE Attack

```sql
DECLARE @City AS nvarchar(200);
SET @City = 'Colchester''; DELETE FROM [dbo].[Orders]; --';
DECLARE @sql AS nvarchar(max);
SET @sql = '
SELECT
    o.OrderID,
    o.CustomerID,
    c.CompanyName,
    o.OrderDate,
    o.ShipCity
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
    ON o.CustomerID = c.CustomerID
WHERE o.ShipCity = ''' + @City + '''';
PRINT @sql;
EXEC (@sql);
```

**Result: CATASTROPHIC**\
This query deletes all records from the `Orders` table due to the injected `DELETE` statement.

#### Example H: Data Extraction Attack

```sql
DECLARE @City AS nvarchar(200);
SET @City = 'Colchester'' AND 1=2 UNION SELECT table_schema, table_name, ''1'' FROM information_schema.tables; --';
DECLARE @sql AS nvarchar(max);
SET @sql = '
SELECT
    o.OrderID,
    o.CustomerID,
    c.CompanyName,
    o.OrderDate,
    o.ShipCity
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
    ON o.CustomerID = c.CustomerID
WHERE o.ShipCity = ''' + @City + '''';
PRINT @sql;
EXEC (@sql);
```

**Result: DATA BREACH**\
This query exposes database schema information by injecting a `UNION` clause, potentially revealing sensitive metadata.

## Why Use Dynamic SQL?

Instead of writing multiple static queries for different conditions (e.g., `SELECT ... WHERE city = 'London'`, `SELECT ... WHERE city = 'Paris'`), dynamic SQL allows you to write one flexible query:

```sql
SELECT ... WHERE city = @City
```

This reduces code duplication and improves maintainability.

## Key Security Insights

1. **Never Trust User Input**\
   Treat all user input as potentially malicious. Never concatenate user input directly into SQL strings.

2. **Use Parameterized Queries**\
   Always use `sp_executesql` with proper parameter binding:

   ```sql
   EXEC sp_executesql @sql, N'@param datatype', @param = @value;
   ```

3. **Validate Input**

   - Check data types.
   - Validate length constraints.
   - Use whitelist validation where possible.
   - Sanitize special characters.

4. **Principle of Least Privilege**

   - Use database accounts with minimal necessary permissions.
   - Avoid using `sa` or administrative accounts for application connections.
   - Grant only `SELECT`, `INSERT`, `UPDATE`, `DELETE` permissions as needed.

## Conclusion

Dynamic SQL is a powerful tool for enhancing application flexibility, but it requires careful implementation to avoid security vulnerabilities. String concatenation is a primary source of SQL injection risks, while parameterized queries using `sp_executesql` provide a secure alternative. Always validate input, follow the principle of least privilege, and test in safe environments like dbfiddle.uk to understand and mitigate risks.
