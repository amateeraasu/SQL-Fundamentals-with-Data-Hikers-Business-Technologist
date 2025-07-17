# Sample Dataset
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

# Sample Data

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

#Example A: Static SQL (Baseline)

SELECT 
   o.[OrderID]
  ,o.[CustomerID]
  ,c.[CompanyName]
  ,o.[OrderDate]
  ,o.[shipCity]
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
ON o.[CustomerID] = c.[CustomerID]  
Where o.shipCity = 'Colchester'


# Example B: Basic Dynamic SQL

DECLARE @sql as nvarchar(max)
SET @sql = '

SELECT
   o.[OrderID]
  ,o.[CustomerID]
  ,c.[CompanyName]
  ,o.[OrderDate]
  ,o.[shipCity]
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
ON o.[CustomerID] = c.[CustomerID]  
WHERE o.shipCity = ''Colchester''
'
PRINT(@sql)
Exec(@sql)

#Example C: String Concatenation

DECLARE @City as nvarchar(200)
SET @City = 'Colchester'

DECLARE @sql as nvarchar(max)
SET @sql = '
SELECT 
   o.[OrderID]
  ,o.[CustomerID]
  ,c.[CompanyName]
  ,o.[OrderDate]
  ,o.[shipCity]
FROM  [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
ON o.[CustomerID] = c.[CustomerID]  
WHERE o.shipCity = ''' + @City + N'''
'
PRINT(@sql)
Exec(@sql)

# Example D: Variable Declaration in Dynamic SQL

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

# Example E: Parameterized Query (SECURE)

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

# Example F: Check Initial Data

SELECT COUNT(*) FROM [dbo].[Orders];

# Example G: Malicious DELETE Attack

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

# Example H: Data Extraction Attack

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


