-- EVALUATION SCRIPT: 6NF

SET NOCOUNT ON;

-- Clear buffer pool and procedure cache for a cold-cache start
CHECKPOINT;
DBCC DROPCLEANBUFFERS;
DBCC FREEPROCCACHE;

-- Enable I/O and timing output to the Messages tab
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

-- Results collector table

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

SELECT p.ProductID, p.Name,
'REASON NOT RECOVERABLE' AS weight_absence_reason
FROM Production.Product p
WHERE NOT EXISTS (
    SELECT 1 FROM Production.Product_Weight pw
    WHERE pw.ProductID = p.ProductID
);

-- Q3: Expressibility Check Query

SELECT COUNT(*) AS orders_without_currency_rate
FROM Sales.SalesOrderHeader soh
WHERE NOT EXISTS (
    SELECT 1
    FROM Sales.SalesOrderHeader_CurrencyRateID scr
    WHERE scr.SalesOrderID = soh.SalesOrderID
);

-- Q4: Multi-Join Overhead

SET @run = 1;
WHILE @run <= 5
BEGIN
    SET @t_start = SYSDATETIME();

    SELECT
        p.ProductID,
        p.Name,
        pc.Color,
        ps.Size,
        pw.Weight,
        pl.ProductLine,
        pcl.Class
    FROM Production.Product p
    INNER JOIN Production.Product_Color         pc  ON pc.ProductID  = p.ProductID
    INNER JOIN Production.Product_Size          ps  ON ps.ProductID  = p.ProductID
    INNER JOIN Production.Product_Weight        pw  ON pw.ProductID  = p.ProductID
    INNER JOIN Production.Product_ProductLine   pl  ON pl.ProductID  = p.ProductID
    INNER JOIN Production.Product_Class         pcl ON pcl.ProductID = p.ProductID;

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
        pl.ProductLine,
        COUNT(DISTINCT p.ProductID)             AS distinct_products,
        SUM(sod.OrderQty)                       AS total_qty_sold,
        COUNT(ctn.CarrierTrackingNumber)        AS tracked_shipments,
        COUNT(sod.SalesOrderDetailID)           AS total_order_lines
    FROM Production.Product p
    LEFT JOIN Production.Product_ProductLine pl
        ON pl.ProductID = p.ProductID
    INNER JOIN Sales.SalesOrderDetail sod
        ON sod.ProductID = p.ProductID
    LEFT JOIN Sales.SalesOrderDetail_CarrierTrackingNumber ctn
        ON  ctn.SalesOrderID        = sod.SalesOrderID
        AND ctn.SalesOrderDetailID  = sod.SalesOrderDetailID
    GROUP BY pl.ProductLine
    ORDER BY total_qty_sold DESC;

    SET @t_end = SYSDATETIME();
    INSERT INTO #results VALUES (
        'Q5', 'Cross-Domain Aggregation', @run,
        DATEDIFF(MICROSECOND, @t_start, @t_end)
    );
    SET @run = @run + 1;
END;

-- Q6: Aggregation Semantic Ambiguity
PRINT '=== Q6: Aggregation Semantic Ambiguity ===';

SET @run = 1;
WHILE @run <= 5
BEGIN
    SET @t_start = SYSDATETIME();

    SELECT
        COUNT(*)            AS total_products,
        COUNT(pw.Weight)    AS products_with_weight,
        AVG(pw.Weight)      AS avg_weight,
        MAX(pw.Weight)      AS max_weight,
        MIN(pw.Weight)      AS min_weight
    FROM Production.Product p
    LEFT JOIN Production.Product_Weight pw
        ON pw.ProductID = p.ProductID;

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
        CASE WHEN scr.CurrencyRateID IS NULL
             THEN 'No Rate'
             ELSE 'Rate Available'
        END                     AS rate_status,
        COUNT(*)                AS order_count,
        SUM(soh.TotalDue)       AS total_revenue,
        AVG(cr.AverageRate)     AS avg_exchange_rate
    FROM Sales.SalesOrderHeader soh
    LEFT JOIN Sales.SalesOrderHeader_CurrencyRateID scr
        ON scr.SalesOrderID = soh.SalesOrderID
    LEFT JOIN Sales.CurrencyRate cr
        ON cr.CurrencyRateID = scr.CurrencyRateID
    GROUP BY
        CASE WHEN scr.CurrencyRateID IS NULL
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