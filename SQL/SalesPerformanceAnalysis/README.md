# Advanced SQL Queries

## [Sales Performance Analysis](https://github.com/arshrandhawa/portfolio/blob/main/SQL/SalesPerformanceViewByArsh.sql) – Project Overview 
This project focuses on analyzing sales performance using **SQL** with complex queries to rank salespeople, track total sales, calculate running totals, and generate territory-based performance insights. It is designed to handle large datasets efficiently, leveraging **Common Table Expressions (CTEs), ranking functions, and advance SQL techniques** for optimization.

## Key Features & Insights

### 1. Sales Performance Metrics
- Extracted **total sales** using the `TotalDue` column.
- Calculated **distinct order counts** to assess order volume per salesperson.

### 2. Ranking Salespeople
- Ranked salespeople **within each territory** based on total sales.
- Ranked salespeople **across all territories** for company-wide performance insights.

### 3. Running Totals & Historical Sales Trends
- Implemented **quarterly running totals** to track cumulative sales performance over time.
- Used **window functions** for efficient aggregation of sales data.

### 4. Overall Ranking System
- Defined **overall ranking** by combining **sales rank and order count rank** to measure comprehensive performance.
- Ensured that salespeople **without sales data** for a given quarter were still included if they were active in that territory.

### TODO: Performance Optimization
- **Indexing** to reduce query execution time and improve efficiency.
- **Clustered and Non-Clustered Indexes** on key tables like `SalesOrderHeader` and `SalesPerson` to optimize query performance.

## Technologies Used
- **SQL Server (T-SQL)**
- **Common Table Expressions (CTEs)**
- **Ranking Functions ( `DENSE_RANK()`)**
- **Window Functions (`SUM() OVER`, `COUNT() OVER`)**

## How to Use
1. Use Adventure Works 2019 on SQL Server
2. Clone the repository and set up an **SQL Server instance**.
3. Load the provided **SQL scripts** into your database environment.
4. Execute queries to analyze sales performance across different dimensions.

---
This project highlights **data-driven decision-making**, **query optimization**, and **advanced SQL techniques** 🚀
