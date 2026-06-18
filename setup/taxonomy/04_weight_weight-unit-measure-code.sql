SELECT
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    COUNT(*) AS total,
    SUM(CASE WHEN Weight IS NULL THEN 1 ELSE 0 END) AS weight_null,
    CAST(SUM(CASE WHEN Weight IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS weight_null_pct,
    SUM(CASE WHEN WeightUnitMeasureCode IS NULL THEN 1 ELSE 0 END) AS unit_null,
    CAST(SUM(CASE WHEN WeightUnitMeasureCode IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS unit_null_pct
FROM Production.Product
GROUP BY
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END
ORDER BY finished_good, make_status;

SELECT
    CASE WHEN Weight IS NULL THEN 'Weight NULL'
         ELSE 'Weight present' END AS weight_status,
    CASE WHEN WeightUnitMeasureCode IS NULL THEN 'Unit NULL'
         ELSE 'Unit present' END AS unit_status,
    COUNT(*) AS total
FROM Production.Product
GROUP BY
    CASE WHEN Weight IS NULL THEN 'Weight NULL'
         ELSE 'Weight present' END,
    CASE WHEN WeightUnitMeasureCode IS NULL THEN 'Unit NULL'
         ELSE 'Unit present' END
ORDER BY weight_status, unit_status;

SELECT
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    ps.Name AS subcategory_name,
    COUNT(*) AS total,
    SUM(CASE WHEN p.Weight IS NULL THEN 1 ELSE 0 END) AS weight_null,
    CAST(SUM(CASE WHEN p.Weight IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS weight_null_pct
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
GROUP BY
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END,
    ps.Name
HAVING SUM(CASE WHEN p.Weight IS NULL THEN 1 ELSE 0 END) > 0
ORDER BY finished_good, make_status, subcategory_name;


SELECT
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    ps.Name AS subcategory_name,
    pc.Name AS category_name,
    COUNT(*) AS total,
    SUM(CASE WHEN p.Weight IS NULL THEN 1 ELSE 0 END) AS weight_null,
    CAST(SUM(CASE WHEN p.Weight IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS weight_null_pct
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc
    ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END,
    ps.Name,
    pc.Name
HAVING SUM(CASE WHEN p.Weight IS NULL THEN 1 ELSE 0 END) > 0
ORDER BY finished_good, make_status, pc.Name, subcategory_name;

SELECT
    ps.Name AS subcategory_name,
    pc.Name AS category_name,
    p.Name AS product_name,
    p.Weight,
    p.WeightUnitMeasureCode,
    CASE WHEN p.MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc
    ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE ps.Name IN ('Wheels', 'Pedals')
   OR (pc.Name = 'Accessories' AND p.Weight IS NULL)
ORDER BY pc.Name, ps.Name, p.Name;