ALTER TABLE Person.Person
ADD CONSTRAINT CHK_Person_MiddleName_consistency
CHECK (
    (MiddleName IS NOT NULL AND MiddleName_null_reason = 'KNOWN')
    OR
    (MiddleName IS NULL AND MiddleName_null_reason IN ('NOT_APPLICABLE', 'UNKNOWN'))
);

ALTER TABLE Sales.SalesOrderHeader
ADD CONSTRAINT CHK_SalesOrderHeader_CurrencyRateID_consistency
CHECK (
    (CurrencyRateID IS NOT NULL AND CurrencyRateID_null_reason = 'KNOWN')
    OR
    (CurrencyRateID IS NULL AND CurrencyRateID_null_reason IN ('NOT_APPLICABLE', 'UNKNOWN'))
);

ALTER TABLE Production.Product
ADD CONSTRAINT CHK_Product_Color_consistency
CHECK (
    (Color IS NOT NULL AND Color_null_reason = 'KNOWN')
    OR
    (Color IS NULL AND Color_null_reason IN ('NOT_APPLICABLE', 'UNKNOWN'))
);

ALTER TABLE Production.Product
ADD CONSTRAINT CHK_Product_Size_consistency
CHECK (
    (Size IS NOT NULL AND Size_null_reason = 'KNOWN')
    OR
    (Size IS NULL AND Size_null_reason IN ('NOT_APPLICABLE', 'UNKNOWN'))
);

ALTER TABLE Production.Product
ADD CONSTRAINT CHK_Product_SizeUnitMeasureCode_consistency
CHECK (
    (SizeUnitMeasureCode IS NOT NULL AND SizeUnitMeasureCode_null_reason = 'KNOWN')
    OR
    (SizeUnitMeasureCode IS NULL AND SizeUnitMeasureCode_null_reason IN ('NOT_APPLICABLE', 'UNKNOWN'))
);

ALTER TABLE Production.Product
ADD CONSTRAINT CHK_Product_Weight_consistency
CHECK (
    (Weight IS NOT NULL AND Weight_null_reason = 'KNOWN')
    OR
    (Weight IS NULL AND Weight_null_reason IN ('NOT_APPLICABLE', 'UNKNOWN'))
);

ALTER TABLE Production.Product
ADD CONSTRAINT CHK_Product_WeightUnitMeasureCode_consistency
CHECK (
    (WeightUnitMeasureCode IS NOT NULL AND WeightUnitMeasureCode_null_reason = 'KNOWN')
    OR
    (WeightUnitMeasureCode IS NULL AND WeightUnitMeasureCode_null_reason IN ('NOT_APPLICABLE', 'UNKNOWN'))
);

ALTER TABLE Production.Product
ADD CONSTRAINT CHK_Product_ProductLine_consistency
CHECK (
    (ProductLine IS NOT NULL AND ProductLine_null_reason = 'KNOWN')
    OR
    (ProductLine IS NULL AND ProductLine_null_reason IN ('NOT_APPLICABLE', 'UNKNOWN'))
);

ALTER TABLE Production.Product
ADD CONSTRAINT CHK_Product_Class_consistency
CHECK (
    (Class IS NOT NULL AND Class_null_reason = 'KNOWN')
    OR
    (Class IS NULL AND Class_null_reason IN ('NOT_APPLICABLE', 'UNKNOWN'))
);

ALTER TABLE Production.Product
ADD CONSTRAINT CHK_Product_Style_consistency
CHECK (
    (Style IS NOT NULL AND Style_null_reason = 'KNOWN')
    OR
    (Style IS NULL AND Style_null_reason IN ('NOT_APPLICABLE', 'UNKNOWN'))
);

ALTER TABLE Production.Product
ADD CONSTRAINT CHK_Product_ProductSubcategoryID_consistency
CHECK (
    (ProductSubcategoryID IS NOT NULL AND ProductSubcategoryID_null_reason = 'KNOWN')
    OR
    (ProductSubcategoryID IS NULL AND ProductSubcategoryID_null_reason IN ('NOT_APPLICABLE', 'UNKNOWN'))
);

ALTER TABLE Production.Product
ADD CONSTRAINT CHK_Product_ProductModelID_consistency
CHECK (
    (ProductModelID IS NOT NULL AND ProductModelID_null_reason = 'KNOWN')
    OR
    (ProductModelID IS NULL AND ProductModelID_null_reason IN ('NOT_APPLICABLE', 'UNKNOWN'))
);

ALTER TABLE Sales.SalesOrderDetail
ADD CONSTRAINT CHK_SalesOrderDetail_CarrierTrackingNumber_consistency
CHECK (
    (CarrierTrackingNumber IS NOT NULL AND CarrierTrackingNumber_null_reason = 'KNOWN')
    OR
    (CarrierTrackingNumber IS NULL AND CarrierTrackingNumber_null_reason IN ('NOT_APPLICABLE', 'UNKNOWN'))
);