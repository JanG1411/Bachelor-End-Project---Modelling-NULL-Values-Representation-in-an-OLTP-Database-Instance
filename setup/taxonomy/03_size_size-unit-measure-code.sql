SELECT
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    COUNT(*) AS total,
    SUM(CASE WHEN Size IS NULL THEN 1 ELSE 0 END) AS null_count,
    CAST(SUM(CASE WHEN Size IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS null_pct
FROM Production.Product
GROUP BY
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END
ORDER BY finished_good, make_status;

SELECT
    CASE WHEN Size IS NULL THEN 'Size NULL'
         ELSE 'Size present' END AS size_status,
    CASE WHEN SizeUnitMeasureCode IS NULL THEN 'Unit NULL'
         ELSE 'Unit present' END AS unit_status,
    COUNT(*) AS total
FROM Production.Product
GROUP BY
    CASE WHEN Size IS NULL THEN 'Size NULL'
         ELSE 'Size present' END,
    CASE WHEN SizeUnitMeasureCode IS NULL THEN 'Unit NULL'
         ELSE 'Unit present' END
ORDER BY size_status, unit_status;

SELECT
    ProductID,
    Name,
    ProductNumber,
    Size,
    SizeUnitMeasureCode,
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    ProductSubcategoryID
FROM Production.Product
WHERE Size IS NOT NULL
  AND SizeUnitMeasureCode IS NULL
ORDER BY FinishedGoodsFlag, MakeFlag;