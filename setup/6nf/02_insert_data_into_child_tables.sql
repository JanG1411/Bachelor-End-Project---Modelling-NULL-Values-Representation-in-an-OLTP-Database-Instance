INSERT INTO Person.Person_MiddleName (BusinessEntityID, MiddleName)
SELECT BusinessEntityID, MiddleName
FROM   Person.Person
WHERE  MiddleName IS NOT NULL;

INSERT INTO Production.Product_Color (ProductID, Color)
SELECT ProductID, Color
FROM   Production.Product
WHERE  Color IS NOT NULL;

INSERT INTO Production.Product_Size (ProductID, Size)
SELECT ProductID, Size
FROM   Production.Product
WHERE  Size IS NOT NULL;

INSERT INTO Production.Product_SizeUnitMeasureCode (ProductID, SizeUnitMeasureCode)
SELECT ProductID, SizeUnitMeasureCode
FROM   Production.Product
WHERE  SizeUnitMeasureCode IS NOT NULL;

INSERT INTO Production.Product_WeightUnitMeasureCode (ProductID, WeightUnitMeasureCode)
SELECT ProductID, WeightUnitMeasureCode
FROM   Production.Product
WHERE  WeightUnitMeasureCode IS NOT NULL;

INSERT INTO Production.Product_Weight (ProductID, Weight)
SELECT ProductID, Weight
FROM   Production.Product
WHERE  Weight IS NOT NULL;

INSERT INTO Production.Product_ProductLine (ProductID, ProductLine)
SELECT ProductID, ProductLine
FROM   Production.Product
WHERE  ProductLine IS NOT NULL;

INSERT INTO Production.Product_Class (ProductID, Class)
SELECT ProductID, Class
FROM   Production.Product
WHERE  Class IS NOT NULL;

INSERT INTO Production.Product_Style (ProductID, Style)
SELECT ProductID, Style
FROM   Production.Product
WHERE  Style IS NOT NULL;

INSERT INTO Production.Product_ProductSubcategoryID (ProductID, ProductSubcategoryID)
SELECT ProductID, ProductSubcategoryID
FROM   Production.Product
WHERE  ProductSubcategoryID IS NOT NULL;

INSERT INTO Production.Product_ProductModelID (ProductID, ProductModelID)
SELECT ProductID, ProductModelID
FROM   Production.Product
WHERE  ProductModelID IS NOT NULL;

INSERT INTO Sales.SalesOrderHeader_CurrencyRateID (SalesOrderID, CurrencyRateID)
SELECT SalesOrderID, CurrencyRateID
FROM   Sales.SalesOrderHeader
WHERE  CurrencyRateID IS NOT NULL;

INSERT INTO Sales.SalesOrderDetail_CarrierTrackingNumber (SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber)
SELECT SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber
FROM   Sales.SalesOrderDetail
WHERE  CarrierTrackingNumber IS NOT NULL;