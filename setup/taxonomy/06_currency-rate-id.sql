SELECT
    st.Name AS territory_name,
    st.CountryRegionCode AS country,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN h.CurrencyRateID IS NULL THEN 1 ELSE 0 END) AS null_count,
    CAST(SUM(CASE WHEN h.CurrencyRateID IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS null_pct
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesTerritory st
    ON h.TerritoryID = st.TerritoryID
GROUP BY st.Name, st.CountryRegionCode
ORDER BY null_pct DESC;

SELECT
    CASE WHEN OnlineOrderFlag = 'true' THEN 'Online'
         ELSE 'Offline' END AS order_channel,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN CurrencyRateID IS NULL THEN 1 ELSE 0 END) AS null_count,
    CAST(SUM(CASE WHEN CurrencyRateID IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS null_pct
FROM Sales.SalesOrderHeader
GROUP BY CASE WHEN OnlineOrderFlag = 'true' THEN 'Online'
              ELSE 'Offline' END
ORDER BY order_channel;

SELECT
    st.Name AS territory_name,
    st.CountryRegionCode AS country,
    CASE WHEN h.OnlineOrderFlag = 'true' THEN 'Online'
         ELSE 'Offline' END AS order_channel,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN h.CurrencyRateID IS NULL THEN 1 ELSE 0 END) AS null_count,
    CAST(SUM(CASE WHEN h.CurrencyRateID IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS null_pct
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesTerritory st
    ON h.TerritoryID = st.TerritoryID
GROUP BY
    st.Name,
    st.CountryRegionCode,
    CASE WHEN h.OnlineOrderFlag = 'true' THEN 'Online'
         ELSE 'Offline' END
ORDER BY territory_name, order_channel;

SELECT
    h.SalesOrderID,
    st.Name AS territory_name,
    h.CurrencyRateID,
    cr.FromCurrencyCode,
    cr.ToCurrencyCode
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesTerritory st
    ON h.TerritoryID = st.TerritoryID
JOIN Sales.CurrencyRate cr
    ON h.CurrencyRateID = cr.CurrencyRateID
WHERE st.CountryRegionCode = 'US'
  AND h.CurrencyRateID IS NOT NULL
ORDER BY st.Name;

SELECT
    st.Name AS territory_name,
    CASE WHEN h.OnlineOrderFlag = 'true' THEN 'Online'
         ELSE 'Offline' END AS order_channel,
    CASE WHEN h.CurrencyRateID IS NULL THEN 'NULL'
         ELSE 'NOT NULL' END AS rate_status,
    COUNT(*) AS total,
    MIN(h.OrderDate) AS earliest_order,
    MAX(h.OrderDate) AS latest_order
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesTerritory st
    ON h.TerritoryID = st.TerritoryID
WHERE st.CountryRegionCode IN ('FR', 'DE')
GROUP BY
    st.Name,
    CASE WHEN h.OnlineOrderFlag = 'true' THEN 'Online'
         ELSE 'Offline' END,
    CASE WHEN h.CurrencyRateID IS NULL THEN 'NULL'
         ELSE 'NOT NULL' END
ORDER BY territory_name, order_channel, rate_status;

SELECT
    st.Name AS territory_name,
    CASE WHEN h.OnlineOrderFlag = 'true' THEN 'Online'
         ELSE 'Offline' END AS order_channel,
    CASE WHEN h.CurrencyRateID IS NULL THEN 'NULL'
         ELSE 'NOT NULL' END AS rate_status,
    cr.ToCurrencyCode,
    COUNT(*) AS total
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesTerritory st
    ON h.TerritoryID = st.TerritoryID
LEFT JOIN Sales.CurrencyRate cr
    ON h.CurrencyRateID = cr.CurrencyRateID
WHERE st.CountryRegionCode IN ('FR', 'DE', 'AU', 'CA', 'GB')
GROUP BY
    st.Name,
    CASE WHEN h.OnlineOrderFlag = 'true' THEN 'Online'
         ELSE 'Offline' END,
    CASE WHEN h.CurrencyRateID IS NULL THEN 'NULL'
         ELSE 'NOT NULL' END,
    cr.ToCurrencyCode
ORDER BY territory_name, order_channel, rate_status;
SELECT
    st.Name AS territory_name,
    st.CountryRegionCode AS country,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN h.CurrencyRateID IS NULL THEN 1 ELSE 0 END) AS null_count,
    CAST(SUM(CASE WHEN h.CurrencyRateID IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS null_pct
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesTerritory st
    ON h.TerritoryID = st.TerritoryID
GROUP BY st.Name, st.CountryRegionCode
ORDER BY null_pct DESC;

SELECT
    CASE WHEN OnlineOrderFlag = 'true' THEN 'Online'
         ELSE 'Offline' END AS order_channel,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN CurrencyRateID IS NULL THEN 1 ELSE 0 END) AS null_count,
    CAST(SUM(CASE WHEN CurrencyRateID IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS null_pct
FROM Sales.SalesOrderHeader
GROUP BY CASE WHEN OnlineOrderFlag = 'true' THEN 'Online'
              ELSE 'Offline' END
ORDER BY order_channel;

SELECT
    st.Name AS territory_name,
    st.CountryRegionCode AS country,
    CASE WHEN h.OnlineOrderFlag = 'true' THEN 'Online'
         ELSE 'Offline' END AS order_channel,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN h.CurrencyRateID IS NULL THEN 1 ELSE 0 END) AS null_count,
    CAST(SUM(CASE WHEN h.CurrencyRateID IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS null_pct
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesTerritory st
    ON h.TerritoryID = st.TerritoryID
GROUP BY
    st.Name,
    st.CountryRegionCode,
    CASE WHEN h.OnlineOrderFlag = 'true' THEN 'Online'
         ELSE 'Offline' END
ORDER BY territory_name, order_channel;

SELECT
    h.SalesOrderID,
    st.Name AS territory_name,
    h.CurrencyRateID,
    cr.FromCurrencyCode,
    cr.ToCurrencyCode
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesTerritory st
    ON h.TerritoryID = st.TerritoryID
JOIN Sales.CurrencyRate cr
    ON h.CurrencyRateID = cr.CurrencyRateID
WHERE st.CountryRegionCode = 'US'
  AND h.CurrencyRateID IS NOT NULL
ORDER BY st.Name;

SELECT
    st.Name AS territory_name,
    CASE WHEN h.OnlineOrderFlag = 'true' THEN 'Online'
         ELSE 'Offline' END AS order_channel,
    CASE WHEN h.CurrencyRateID IS NULL THEN 'NULL'
         ELSE 'NOT NULL' END AS rate_status,
    COUNT(*) AS total,
    MIN(h.OrderDate) AS earliest_order,
    MAX(h.OrderDate) AS latest_order
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesTerritory st
    ON h.TerritoryID = st.TerritoryID
WHERE st.CountryRegionCode IN ('FR', 'DE')
GROUP BY
    st.Name,
    CASE WHEN h.OnlineOrderFlag = 'true' THEN 'Online'
         ELSE 'Offline' END,
    CASE WHEN h.CurrencyRateID IS NULL THEN 'NULL'
         ELSE 'NOT NULL' END
ORDER BY territory_name, order_channel, rate_status;

SELECT
    st.Name AS territory_name,
    CASE WHEN h.OnlineOrderFlag = 'true' THEN 'Online'
         ELSE 'Offline' END AS order_channel,
    CASE WHEN h.CurrencyRateID IS NULL THEN 'NULL'
         ELSE 'NOT NULL' END AS rate_status,
    cr.ToCurrencyCode,
    COUNT(*) AS total
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesTerritory st
    ON h.TerritoryID = st.TerritoryID
LEFT JOIN Sales.CurrencyRate cr
    ON h.CurrencyRateID = cr.CurrencyRateID
WHERE st.CountryRegionCode IN ('FR', 'DE', 'AU', 'CA', 'GB')
GROUP BY
    st.Name,
    CASE WHEN h.OnlineOrderFlag = 'true' THEN 'Online'
         ELSE 'Offline' END,
    CASE WHEN h.CurrencyRateID IS NULL THEN 'NULL'
         ELSE 'NOT NULL' END,
    cr.ToCurrencyCode
ORDER BY territory_name, order_channel, rate_status;