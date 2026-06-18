-- EVALUATION SCRIPT: Baseline

SET NOCOUNT ON;

-- Clear buffer pool and procedure cache for a cold-cache start
CHECKPOINT;
DBCC DROPCLEANBUFFERS;
DBCC FREEPROCCACHE;

-- Enable I/O and timing output to the Messages tab
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

-- Results collector table
-- NOTE: elapsed_us stores microseconds despite the column name

DROP TABLE IF EXISTS #results;
CREATE TABLE #results (
    query_id        VARCHAR(5),
    query_name      VARCHAR(100),
    run_number      INT,
    elapsed_us      BIGINT
);

-- Timing variables
DECLARE @run        INT;
DECLARE @t_start    DATETIME2;
DECLARE @t_end      DATETIME2;

-- Q1: Control Query

SET @run = 1;
WHILE @run <= 5
BEGIN
    SET @t_start = SYSDATETIME();

    SELECT
        soh.SalesOrderID,
        soh.OrderDate,
        soh.TotalDue,
        sod.OrderQty,
        sod.UnitPrice,
        sod.LineTotal
    FROM Sales.SalesOrderHeader soh
    INNER JOIN Sales.SalesOrderDetail sod
        ON sod.SalesOrderID = soh.SalesOrderID
    WHERE soh.TotalDue > 1000
    ORDER BY soh.TotalDue DESC;

    SET @t_end = SYSDATETIME();
    INSERT INTO #results VALUES (
        'Q1', 'Control Query', @run,
        DATEDIFF(MICROSECOND, @t_start, @t_end)
    );
    SET @run = @run + 1;
END;

-- Q2: Expressibility Check Query

SELECT ProductID, Name,
'REASON UNKNOWN TO QUERY ENGINE' AS weight_absence_reason
FROM Production.Product
WHERE Weight IS NULL;

-- Q3: Expressibility Check Query

SELECT COUNT(*) AS orders_without_currency_rate
FROM Sales.SalesOrderHeader
WHERE CurrencyRateID IS NULL;

-- Q4: Multi-Join Overhead

SET @run = 1;
WHILE @run <= 5
BEGIN
    SET @t_start = SYSDATETIME();

    SELECT
        p.ProductID,
        p.Name,
        p.Color,
        p.Size,
        p.Weight,
        p.ProductLine,
        p.Class
    FROM Production.Product p
    WHERE p.Color       IS NOT NULL
      AND p.Size        IS NOT NULL
      AND p.Weight      IS NOT NULL
      AND p.ProductLine IS NOT NULL
      AND p.Class       IS NOT NULL;

    SET @t_end = SYSDATETIME();
    INSERT INTO #results VALUES (
        'Q4', 'Multi-Join Overhead', @run,
        DATEDIFF(MICROSECOND, @t_start, @t_end)
    );
    SET @run = @run + 1;
END;

-- Q5: Cross-Domain Aggregation

SET @run = 1;
WHILE @run <= 5
BEGIN
    SET @t_start = SYSDATETIME();

    SELECT
        p.ProductLine,
        COUNT(DISTINCT p.ProductID)         AS distinct_products,
        SUM(sod.OrderQty)                   AS total_qty_sold,
        COUNT(sod.CarrierTrackingNumber)    AS tracked_shipments,
        COUNT(sod.SalesOrderDetailID)       AS total_order_lines
    FROM Production.Product p
    INNER JOIN Sales.SalesOrderDetail sod
        ON sod.ProductID = p.ProductID
    GROUP BY p.ProductLine
    ORDER BY total_qty_sold DESC;

    SET @t_end = SYSDATETIME();
    INSERT INTO #results VALUES (
        'Q5', 'Cross-Domain Aggregation', @run,
        DATEDIFF(MICROSECOND, @t_start, @t_end)
    );
    SET @run = @run + 1;
END;

-- Q6: Aggregation Semantic Ambiguity

SET @run = 1;
WHILE @run <= 5
BEGIN
    SET @t_start = SYSDATETIME();

    SELECT
        COUNT(*)            AS total_products,
        COUNT(Weight)       AS products_with_weight,
        AVG(Weight)         AS avg_weight,
        MAX(Weight)         AS max_weight,
        MIN(Weight)         AS min_weight
    FROM Production.Product;

    SET @t_end = SYSDATETIME();
    INSERT INTO #results VALUES (
        'Q6', 'Aggregation Semantic Ambiguity', @run,
        DATEDIFF(MICROSECOND, @t_start, @t_end)
    );
    SET @run = @run + 1;
END;

-- Q7: Outer Join on a Nullable Foreign Key

SET @run = 1;
WHILE @run <= 5
BEGIN
    SET @t_start = SYSDATETIME();

    SELECT
        CASE WHEN cr.CurrencyRateID IS NULL
             THEN 'No Rate'
             ELSE 'Rate Available'
        END                     AS rate_status,
        COUNT(*)                AS order_count,
        SUM(soh.TotalDue)       AS total_revenue,
        AVG(cr.AverageRate)     AS avg_exchange_rate
    FROM Sales.SalesOrderHeader soh
    LEFT JOIN Sales.CurrencyRate cr
        ON cr.CurrencyRateID = soh.CurrencyRateID
    GROUP BY
        CASE WHEN cr.CurrencyRateID IS NULL
             THEN 'No Rate'
             ELSE 'Rate Available'
        END;

    SET @t_end = SYSDATETIME();
    INSERT INTO #results VALUES (
        'Q7', 'Outer Join Nullable FK', @run,
        DATEDIFF(MICROSECOND, @t_start, @t_end)
    );
    SET @run = @run + 1;
END;

-- Disable statistics output

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

-- TIMING SUMMARY

SELECT
    query_id,
    query_name,
    AVG(elapsed_us)                         AS avg_elapsed_us,
    MIN(elapsed_us)                         AS min_elapsed_us,
    MAX(elapsed_us)                         AS max_elapsed_us,
    MAX(elapsed_us) - MIN(elapsed_us)       AS range_us
FROM #results
WHERE run_number > 1
GROUP BY query_id, query_name
ORDER BY query_id;