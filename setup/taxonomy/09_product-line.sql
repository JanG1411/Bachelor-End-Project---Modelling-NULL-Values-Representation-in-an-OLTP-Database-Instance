SELECT
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    ProductLine,
    COUNT(*) AS total
FROM Production.Product
GROUP BY
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END,
    ProductLine
ORDER BY finished_good, make_status, ProductLine;

SELECT
    pc.Name AS category_name,
    ps.Name AS subcategory_name,
    ProductLine,
    COUNT(*) AS total
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc
    ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY
    pc.Name,
    ps.Name,
    ProductLine
ORDER BY category_name, subcategory_name, ProductLine;

SELECT
    pc.Name AS category_name,
    ps.Name AS subcategory_name,
    CASE WHEN FinishedGoodsFlag = 'true' THEN 'Finished good'
         ELSE 'Not finished good' END AS finished_good,
    CASE WHEN MakeFlag = 'true' THEN 'Manufactured'
         ELSE 'Purchased' END AS make_status,
    p.Name AS product_name,
    p.ProductLine,
    p.Class,
    p.Style
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc
    ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE p.ProductLine IS NULL
ORDER BY category_name, subcategory_name, product_name;