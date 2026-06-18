SELECT
    pc.Name AS category_name,
    ps.Name AS subcategory_name,
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    Style,
    COUNT(*) AS total
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc
    ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY
    pc.Name,
    ps.Name,
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END,
    Style
ORDER BY category_name, subcategory_name, Style;

SELECT
    CASE WHEN ProductLine IS NULL THEN 'ProductLine NULL'
         ELSE 'ProductLine present' END AS productline_status,
    CASE WHEN Class IS NULL THEN 'Class NULL'
         ELSE 'Class present' END AS class_status,
    CASE WHEN Style IS NULL THEN 'Style NULL'
         ELSE 'Style present' END AS style_status,
    COUNT(*) AS total
FROM Production.Product
GROUP BY
    CASE WHEN ProductLine IS NULL THEN 'ProductLine NULL'
         ELSE 'ProductLine present' END,
    CASE WHEN Class IS NULL THEN 'Class NULL'
         ELSE 'Class present' END,
    CASE WHEN Style IS NULL THEN 'Style NULL'
         ELSE 'Style present' END
ORDER BY productline_status, class_status, style_status;
SELECT
    pc.Name AS category_name,
    ps.Name AS subcategory_name,
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    Style,
    COUNT(*) AS total
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc
    ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY
    pc.Name,
    ps.Name,
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END,
    Style
ORDER BY category_name, subcategory_name, Style;

SELECT
    CASE WHEN ProductLine IS NULL THEN 'ProductLine NULL'
         ELSE 'ProductLine present' END AS productline_status,
    CASE WHEN Class IS NULL THEN 'Class NULL'
         ELSE 'Class present' END AS class_status,
    CASE WHEN Style IS NULL THEN 'Style NULL'
         ELSE 'Style present' END AS style_status,
    COUNT(*) AS total
FROM Production.Product
GROUP BY
    CASE WHEN ProductLine IS NULL THEN 'ProductLine NULL'
         ELSE 'ProductLine present' END,
    CASE WHEN Class IS NULL THEN 'Class NULL'
         ELSE 'Class present' END,
    CASE WHEN Style IS NULL THEN 'Style NULL'
         ELSE 'Style present' END
ORDER BY productline_status, class_status, style_status;