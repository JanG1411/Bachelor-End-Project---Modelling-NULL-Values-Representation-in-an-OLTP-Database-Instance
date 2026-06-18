-- Alter tables by adding columns, setting default value to 'KNOWN'

ALTER TABLE Person.Person
ADD MiddleName_null_reason VARCHAR(20) NOT NULL
    CONSTRAINT DF_Person_MiddleName_null_reason DEFAULT 'KNOWN';

ALTER TABLE Production.Product
ADD Color_null_reason              VARCHAR(20) NOT NULL
        CONSTRAINT DF_Product_Color_null_reason DEFAULT 'KNOWN',
    Size_null_reason               VARCHAR(20) NOT NULL
        CONSTRAINT DF_Product_Size_null_reason DEFAULT 'KNOWN',
    SizeUnitMeasureCode_null_reason VARCHAR(20) NOT NULL
        CONSTRAINT DF_Product_SizeUnitMeasureCode_null_reason DEFAULT 'KNOWN',
    Weight_null_reason             VARCHAR(20) NOT NULL
        CONSTRAINT DF_Product_Weight_null_reason DEFAULT 'KNOWN',
    WeightUnitMeasureCode_null_reason VARCHAR(20) NOT NULL
        CONSTRAINT DF_Product_WeightUnitMeasureCode_null_reason DEFAULT 'KNOWN',
    ProductLine_null_reason        VARCHAR(20) NOT NULL
        CONSTRAINT DF_Product_ProductLine_null_reason DEFAULT 'KNOWN',
    Class_null_reason              VARCHAR(20) NOT NULL
        CONSTRAINT DF_Product_Class_null_reason DEFAULT 'KNOWN',
    Style_null_reason              VARCHAR(20) NOT NULL
        CONSTRAINT DF_Product_Style_null_reason DEFAULT 'KNOWN',
    ProductSubcategoryID_null_reason VARCHAR(20) NOT NULL
        CONSTRAINT DF_Product_ProductSubcategoryID_null_reason DEFAULT 'KNOWN',
    ProductModelID_null_reason     VARCHAR(20) NOT NULL
        CONSTRAINT DF_Product_ProductModelID_null_reason DEFAULT 'KNOWN';

ALTER TABLE Sales.SalesOrderDetail
ADD CarrierTrackingNumber_null_reason VARCHAR(20) NOT NULL
    CONSTRAINT DF_SalesOrderDetail_CarrierTrackingNumber_null_reason DEFAULT 'KNOWN';

ALTER TABLE Sales.SalesOrderHeader
ADD CurrencyRateID_null_reason VARCHAR(20) NOT NULL
    CONSTRAINT DF_SalesOrderHeader_CurrencyRateID_null_reason DEFAULT 'KNOWN';