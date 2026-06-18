SELECT
    CASE WHEN ProductSubcategoryID IS NULL THEN 'Subcat NULL'
         ELSE 'Subcat present' END AS subcat_status,
    CASE WHEN ProductModelID IS NULL THEN 'Model NULL'
         ELSE 'Model present' END AS model_status,
    COUNT(*) AS total
FROM Production.Product
GROUP BY
    CASE WHEN ProductSubcategoryID IS NULL THEN 'Subcat NULL'
         ELSE 'Subcat present' END,
    CASE WHEN ProductModelID IS NULL THEN 'Model NULL'
         ELSE 'Model present' END
ORDER BY subcat_status, model_status;

SELECT
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    COUNT(*) AS total,
    SUM(CASE WHEN ProductSubcategoryID IS NULL THEN 1 ELSE 0 END) AS subcat_null,
    CAST(SUM(CASE WHEN ProductSubcategoryID IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS subcat_null_pct,
    SUM(CASE WHEN ProductModelID IS NULL THEN 1 ELSE 0 END) AS model_null,
    CAST(SUM(CASE WHEN ProductModelID IS NULL THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)) AS model_null_pct
FROM Production.Product
GROUP BY
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END
ORDER BY finished_good, make_status;

SELECT
    pc.Name AS category_name,
    ps.Name AS subcategory_name,
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    p.Name AS product_name,
    p.ProductSubcategoryID,
    p.ProductModelID,
    p.ProductLine,
    p.Class
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc
    ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE (p.ProductSubcategoryID IS NULL OR p.ProductModelID IS NULL)
  AND FinishedGoodsFlag = 'true'
ORDER BY category_name, subcategory_name, product_name;