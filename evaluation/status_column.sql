-- EVALUATION SCRIPT: Status Column

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

SELECT
    Weight_null_reason      AS absence_reason,
    COUNT(*)                AS product_count,
    STRING_AGG(Name, ', ')  AS product_names
FROM Production.Product
WHERE Weight IS NULL
GROUP BY Weight_null_reason
ORDER BY product_count DESC;

-- Q3: Expressibility Check Query

SELECT
    CurrencyRateID_null_reason          AS absence_reason,
    COUNT(*)                            AS order_count,
    ROUND(COUNT(*) * 100.0 /
    SUM(COUNT(*)) OVER(), 2)        AS pct_of_missing
FROM Sales.SalesOrderHeader
WHERE CurrencyRateID IS NULL
GROUP BY CurrencyRateID_null_reason
ORDER BY order_count DESC;

-- Q4: Multi-Join Overhead

SET @run = 1;
WHILE @run <= 5
BEGIN
    SET @t_start = SYSDATETIME();

    SELECT
        ProductID,
        Name,
        Color,
        Size,
        Weight,
        ProductLine,
        Class
    FROM Production.Product
    WHERE Color_null_reason         = 'KNOWN'
      AND Size_null_reason          = 'KNOWN'
      AND Weight_null_reason        = 'KNOWN'
      AND ProductLine_null_reason   = 'KNOWN'
      AND Class_null_reason         = 'KNOWN';

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
        COUNT(DISTINCT p.ProductID)                                 AS distinct_products,
        SUM(sod.OrderQty)                                           AS total_qty_sold,
        COUNT(CASE WHEN sod.CarrierTrackingNumber_null_reason = 'KNOWN'
                   THEN sod.CarrierTrackingNumber END)              AS tracked_shipments,
        COUNT(sod.SalesOrderDetailID)                               AS total_order_lines
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
        COUNT(*)                                                AS total_products,
        COUNT(CASE WHEN Weight_null_reason = 'KNOWN'
                   THEN Weight END)                             AS products_with_weight,
        AVG(CASE WHEN Weight_null_reason = 'KNOWN'
                 THEN Weight END)                               AS avg_weight,
        MAX(CASE WHEN Weight_null_reason = 'KNOWN'
                 THEN Weight END)                               AS max_weight,
        MIN(CASE WHEN Weight_null_reason = 'KNOWN'
                 THEN Weight END)                               AS min_weight
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
        soh.CurrencyRateID_null_reason  AS rate_status,
        COUNT(*)                        AS order_count,
        SUM(soh.TotalDue)               AS total_revenue,
        AVG(cr.AverageRate)             AS avg_exchange_rate
    FROM Sales.SalesOrderHeader soh
    LEFT JOIN Sales.CurrencyRate cr
        ON cr.CurrencyRateID = soh.CurrencyRateID
    GROUP BY soh.CurrencyRateID_null_reason;

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