SELECT
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN ProductSubcategoryID IS NULL THEN 'No subcategory'
         ELSE 'Has subcategory' END AS subcategory_status,
    COUNT(*) AS total,
    SUM(CASE WHEN Color IS NULL THEN 1 ELSE 0 END) AS null_count,
    CAST(SUM(CASE WHEN Color IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS null_pct
FROM Production.Product
GROUP BY
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END,
    CASE WHEN ProductSubcategoryID IS NULL THEN 'No subcategory'
         ELSE 'Has subcategory' END
ORDER BY finished_good, subcategory_status;

SELECT
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    COUNT(*) AS total,
    SUM(CASE WHEN Color IS NULL THEN 1 ELSE 0 END) AS null_count,
    CAST(SUM(CASE WHEN Color IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS null_pct
FROM Production.Product
GROUP BY
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END
ORDER BY make_status;

SELECT
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    COUNT(*) AS total,
    SUM(CASE WHEN Color IS NULL THEN 1 ELSE 0 END) AS null_count,
    CAST(SUM(CASE WHEN Color IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS null_pct
FROM Production.Product
GROUP BY
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END
ORDER BY finished_good, make_status;