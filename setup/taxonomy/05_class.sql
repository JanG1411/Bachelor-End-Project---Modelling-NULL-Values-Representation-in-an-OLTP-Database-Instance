SELECT
    pc.Name AS category_name,
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    Class,
    COUNT(*) AS total
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc
    ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY
    pc.Name,
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END,
    Class
ORDER BY category_name, finished_good, make_status, Class;

SELECT
    CASE WHEN ProductLine IS NULL THEN 'ProductLine NULL'
         ELSE 'ProductLine present' END AS productline_status,
    CASE WHEN Class IS NULL THEN 'Class NULL'
         ELSE 'Class present' END AS class_status,
    COUNT(*) AS total
FROM Production.Product
GROUP BY
    CASE WHEN ProductLine IS NULL THEN 'ProductLine NULL'
         ELSE 'ProductLine present' END,
    CASE WHEN Class IS NULL THEN 'Class NULL'
         ELSE 'Class present' END
ORDER BY productline_status, class_status;

SELECT
    pc.Name AS category_name,
    ps.Name AS subcategory_name,
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    ProductLine,
    Class,
    COUNT(*) AS total
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc
    ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE ProductLine IS NOT NULL
  AND Class IS NULL
GROUP BY
    pc.Name,
    ps.Name,
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END,
    ProductLine,
    Class
ORDER BY category_name, subcategory_name;


SELECT
    ps.Name AS subcategory_name,
    p.Name AS product_name,
    p.ProductLine,
    p.Class,
    p.Weight,
    p.WeightUnitMeasureCode
FROM Production.Product p
JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
WHERE ps.Name IN ('Wheels', 'Pedals')
ORDER BY ps.Name, p.ProductLine, p.Name;
SELECT
    pc.Name AS category_name,
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    Class,
    COUNT(*) AS total
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc
    ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY
    pc.Name,
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END,
    Class
ORDER BY category_name, finished_good, make_status, Class;

SELECT
    CASE WHEN ProductLine IS NULL THEN 'ProductLine NULL'
         ELSE 'ProductLine present' END AS productline_status,
    CASE WHEN Class IS NULL THEN 'Class NULL'
         ELSE 'Class present' END AS class_status,
    COUNT(*) AS total
FROM Production.Product
GROUP BY
    CASE WHEN ProductLine IS NULL THEN 'ProductLine NULL'
         ELSE 'ProductLine present' END,
    CASE WHEN Class IS NULL THEN 'Class NULL'
         ELSE 'Class present' END
ORDER BY productline_status, class_status;

SELECT
    pc.Name AS category_name,
    ps.Name AS subcategory_name,
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    ProductLine,
    Class,
    COUNT(*) AS total
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc
    ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE ProductLine IS NOT NULL
  AND Class IS NULL
GROUP BY
    pc.Name,
    ps.Name,
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END,
    ProductLine,
    Class
ORDER BY category_name, subcategory_name;


SELECT
    ps.Name AS subcategory_name,
    p.Name AS product_name,
    p.ProductLine,
    p.Class,
    p.Weight,
    p.WeightUnitMeasureCode
FROM Production.Product p
JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
WHERE ps.Name IN ('Wheels', 'Pedals')
ORDER BY ps.Name, p.ProductLine, p.Name;