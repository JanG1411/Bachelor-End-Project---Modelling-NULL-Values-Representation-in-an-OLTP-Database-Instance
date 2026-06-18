SELECT
    sm.Name AS ship_method_name,
    COUNT(*) AS total_lines,
    SUM(CASE WHEN d.CarrierTrackingNumber IS NULL THEN 1 ELSE 0 END) AS null_count,
    CAST(SUM(CASE WHEN d.CarrierTrackingNumber IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS null_pct
FROM Sales.SalesOrderDetail d
JOIN Sales.SalesOrderHeader h
    ON d.SalesOrderID = h.SalesOrderID
JOIN Purchasing.ShipMethod sm
    ON h.ShipMethodID = sm.ShipMethodID
GROUP BY sm.Name
ORDER BY null_pct DESC;

SELECT
    h.Status,
    COUNT(*) AS total_lines,
    SUM(CASE WHEN d.CarrierTrackingNumber IS NULL THEN 1 ELSE 0 END) AS null_count,
    CAST(SUM(CASE WHEN d.CarrierTrackingNumber IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS null_pct
FROM Sales.SalesOrderDetail d
JOIN Sales.SalesOrderHeader h
    ON d.SalesOrderID = h.SalesOrderID
GROUP BY h.Status
ORDER BY h.Status;

SELECT
    sm.Name AS ship_method_name,
    h.Status AS order_status,
    COUNT(*) AS total_lines,
    SUM(CASE WHEN d.CarrierTrackingNumber IS NULL THEN 1 ELSE 0 END) AS null_count,
    CAST(SUM(CASE WHEN d.CarrierTrackingNumber IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS null_pct
FROM Sales.SalesOrderDetail d
JOIN Sales.SalesOrderHeader h
    ON d.SalesOrderID = h.SalesOrderID
JOIN Purchasing.ShipMethod sm
    ON h.ShipMethodID = sm.ShipMethodID
GROUP BY sm.Name, h.Status
ORDER BY ship_method_name, order_status;