-- AdventureWorks2019 Assessment 
-- by Arshdeep Randhawa
-- 02/12/2025 
-- Drop the view if it already exists to avoid conflicts
IF OBJECT_ID('dbo.SalesPerformanceViewByArsh', 'V') IS NOT NULL  
    DROP VIEW dbo.SalesPerformanceViewByArsh;  
GO  

CREATE VIEW SalesPerformanceViewByArsh AS
-- Step 1: Get all salespeople and their assigned territories, including those who may not have sales in a given quarter
WITH BaseData AS (
    SELECT 
        sp.BusinessEntityID AS SalespersonID,
        p.FirstName + ' ' + p.LastName AS SalespersonName,
        hr.HireDate,
        st.Name AS TerritoryName,
        DATEPART(QUARTER, sth.EndDate) AS Quarter,  -- Extract quarter from the territory history
        YEAR(sth.EndDate) AS SalesYear              -- Extract year from the territory history
    FROM Sales.SalesPerson sp
    JOIN Person.Person p ON sp.BusinessEntityID = p.BusinessEntityID
    JOIN HumanResources.Employee hr ON hr.BusinessEntityID = sp.BusinessEntityID
    JOIN Sales.SalesTerritoryHistory sth ON sp.BusinessEntityID = sth.BusinessEntityID
    JOIN Sales.SalesTerritory st ON sth.TerritoryID = st.TerritoryID
),
SalesData AS (
    -- Calculate Total Sales and Distinct Orders for each salesperson by quarter
    SELECT 
        bd.SalespersonID,
        bd.SalespersonName,
        bd.HireDate,
        bd.TerritoryName,
        DATEPART(QUARTER, soh.OrderDate) AS Quarter,
        YEAR(soh.OrderDate) AS SalesYear,
        COALESCE(SUM(soh.TotalDue), 0) AS TotalSales,
        COALESCE(COUNT(DISTINCT soh.SalesOrderID), 0) AS DistinctOrders
    FROM BaseData bd
    LEFT JOIN Sales.SalesOrderHeader soh ON bd.SalespersonID = soh.SalesPersonID
    WHERE YEAR(soh.OrderDate) = 2013
    GROUP BY bd.SalespersonID, bd.SalespersonName, bd.HireDate, bd.TerritoryName, 
             DATEPART(QUARTER, soh.OrderDate), YEAR(soh.OrderDate)
),
SalesRanking AS (
    -- Step 3: Rank salespeople by Total Sales (within their territory and globally)
    SELECT 
        sd.*,
        DENSE_RANK() OVER (PARTITION BY sd.TerritoryName, sd.Quarter ORDER BY sd.TotalSales DESC) AS TerritorySalesRank,
        DENSE_RANK() OVER (ORDER BY sd.TotalSales DESC) AS GlobalSalesRank
    FROM SalesData sd
),
RunningTotalSales AS (
    -- Step 4: Compute cumulative sales for each salesperson across all quarters
    SELECT 
        sr.*,
        SUM(sr.TotalSales) OVER (
            PARTITION BY sr.SalespersonID ORDER BY sr.SalesYear, sr.Quarter 
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS RunningTotalSales  -- Running sum of total sales per salesperson across quarters
    FROM SalesRanking sr
),
OrderRanking AS (
    -- Step 5: Rank salespeople by Distinct Orders (within their territory and globally)
    SELECT 
        rts.*,
        DENSE_RANK() OVER (PARTITION BY rts.TerritoryName, rts.Quarter ORDER BY rts.DistinctOrders DESC) AS TerritoryOrderRank,
        DENSE_RANK() OVER (ORDER BY rts.DistinctOrders DESC) AS GlobalOrderRank
    FROM RunningTotalSales rts
),
OverallRanking AS (
    -- Step 6: Compute Overall Rank by summing Global Sales Rank and Global Order Rank
    SELECT 
        orr.*,
        (orr.GlobalSalesRank + orr.GlobalOrderRank) AS OverallRank  -- Lower rank sum means better ranking
    FROM OrderRanking orr
)
-- Final Output: Order by Quarter and then by Overall Ranking
SELECT 
    SalespersonID,
    SalespersonName,
    HireDate,
    TerritoryName,
    SalesYear,
    Quarter,
    TotalSales,
	RunningTotalSales,
    DistinctOrders,
    TerritorySalesRank,
    GlobalSalesRank,
    TerritoryOrderRank,
    GlobalOrderRank,
    OverallRank
FROM OverallRanking
--ORDER BY QUARTER, OverallRank;
