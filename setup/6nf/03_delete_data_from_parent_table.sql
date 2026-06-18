---------  MiddleName ---------
BEGIN TRANSACTION;

--  Drop the check constraint
ALTER TABLE Person.Person
    DROP CONSTRAINT CHK_Person_MiddleName_consistency;

--  Drop the index
DROP INDEX IX_Person_LastName_FirstName_MiddleName ON Person.Person;

--  Drop the column
ALTER TABLE Person.Person
    DROP COLUMN MiddleName;

COMMIT;

---------  Color ---------

BEGIN TRANSACTION;

ALTER TABLE Production.Product
    DROP CONSTRAINT CHK_Product_Color_consistency;

ALTER TABLE Production.Product
    DROP COLUMN Color;

COMMIT;

---------  Size ---------

BEGIN TRANSACTION;

ALTER TABLE Production.Product
    DROP CONSTRAINT CHK_Product_Size_consistency;

ALTER TABLE Production.Product
    DROP COLUMN Size;

COMMIT;

---------  Class ---------

BEGIN TRANSACTION;

ALTER TABLE Production.Product
    DROP CONSTRAINT CK_Product_Class;

ALTER TABLE Production.Product
    DROP CONSTRAINT CHK_Product_Class_consistency;

ALTER TABLE Production.Product
    DROP COLUMN Class;

COMMIT;

---------  ProductLine ---------

BEGIN TRANSACTION;

ALTER TABLE Production.Product
    DROP CONSTRAINT CK_Product_ProductLine;

ALTER TABLE Production.Product
    DROP CONSTRAINT CHK_Product_ProductLine_consistency;

ALTER TABLE Production.Product
    DROP COLUMN ProductLine;

COMMIT;

---------  Style ---------

BEGIN TRANSACTION;

ALTER TABLE Production.Product
    DROP CONSTRAINT CK_Product_Style;

ALTER TABLE Production.Product
    DROP CONSTRAINT CHK_Product_Style_consistency;

ALTER TABLE Production.Product
    DROP COLUMN Style;

COMMIT;

---------  WeightUnitMeasureCode ---------

BEGIN TRANSACTION;

ALTER TABLE Production.Product
    DROP CONSTRAINT FK_Product_UnitMeasure_WeightUnitMeasureCode;

ALTER TABLE Production.Product
    DROP CONSTRAINT CHK_Product_WeightUnitMeasureCode_consistency;

ALTER TABLE Production.Product
    DROP COLUMN WeightUnitMeasureCode;

COMMIT;

---------  SizeUnitMeasureCode ---------

BEGIN TRANSACTION;

ALTER TABLE Production.Product
    DROP CONSTRAINT FK_Product_UnitMeasure_SizeUnitMeasureCode;

ALTER TABLE Production.Product
    DROP CONSTRAINT CHK_Product_SizeUnitMeasureCode_consistency;

ALTER TABLE Production.Product
    DROP COLUMN SizeUnitMeasureCode;

COMMIT;

---------  Weight ---------

BEGIN TRANSACTION;

ALTER TABLE Production.Product
    DROP CONSTRAINT CK_Product_Weight;

ALTER TABLE Production.Product
    DROP CONSTRAINT CHK_Product_Weight_consistency;

ALTER TABLE Production.Product
    DROP COLUMN Weight;

COMMIT;

---------  ProductSubcategoryID ---------

BEGIN TRANSACTION;

ALTER TABLE Production.Product
   DROP CONSTRAINT FK_Product_ProductSubcategory_ProductSubcategoryID;

ALTER TABLE Production.Product
    DROP CONSTRAINT CHK_Product_ProductSubcategoryID_consistency;

ALTER TABLE Production.Product
    DROP COLUMN ProductSubcategoryID;

COMMIT;

---------  ProductModelID ---------
SELECT OBJECT_DEFINITION(OBJECT_ID('Production.vProductAndDescription'));

BEGIN TRANSACTION;

DROP VIEW Production.vProductAndDescription;

ALTER TABLE Production.Product
    DROP CONSTRAINT FK_Product_ProductModel_ProductModelID;

ALTER TABLE Production.Product
    DROP CONSTRAINT CHK_Product_ProductModelID_consistency;

ALTER TABLE Production.Product
    DROP COLUMN ProductModelID;

COMMIT;

-- 4. Recreate the view using the child table
CREATE VIEW Production.vProductAndDescription
WITH SCHEMABINDING
AS
SELECT
    p.ProductID,
    p.Name,
    pm.Name            AS ProductModel,
    pmx.CultureID,
    pd.Description
FROM Production.Product p
    INNER JOIN Production.Product_ProductModelID pmi   -- child table replaces direct column
        ON pmi.ProductID = p.ProductID
    INNER JOIN Production.ProductModel pm
        ON pm.ProductModelID = pmi.ProductModelID
    INNER JOIN Production.ProductModelProductDescriptionCulture pmx
        ON pm.ProductModelID = pmx.ProductModelID
    INNER JOIN Production.ProductDescription pd
        ON pmx.ProductDescriptionID = pd.ProductDescriptionID;

---------  CarrierTrackingNumber ---------

BEGIN TRANSACTION;

ALTER TABLE Sales.SalesOrderDetail
    DROP CONSTRAINT CHK_SalesOrderDetail_CarrierTrackingNumber_consistency;

ALTER TABLE Sales.SalesOrderDetail
    DROP COLUMN CarrierTrackingNumber;

COMMIT;

--------- CurrencyRateID ---------

BEGIN TRANSACTION;

ALTER TABLE Sales.SalesOrderHeader
    DROP CONSTRAINT FK_SalesOrderHeader_CurrencyRate_CurrencyRateID;

ALTER TABLE Sales.SalesOrderHeader
    DROP CONSTRAINT CHK_SalesOrderHeader_CurrencyRateID_consistency;

ALTER TABLE Sales.SalesOrderHeader
    DROP COLUMN CurrencyRateID;

COMMIT;

ALTER TABLE Person.Person
    DROP CONSTRAINT DF_Person_MiddleName_null_reason;

ALTER TABLE Person.Person
    DROP COLUMN MiddleName_null_reason;

ALTER TABLE Sales.SalesOrderDetail
    DROP CONSTRAINT DF_SalesOrderDetail_CarrierTrackingNumber_null_reason;

ALTER TABLE Sales.SalesOrderDetail
    DROP COLUMN CarrierTrackingNumber_null_reason;