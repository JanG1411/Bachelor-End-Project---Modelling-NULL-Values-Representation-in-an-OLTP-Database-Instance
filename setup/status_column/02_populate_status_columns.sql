-- Uniformly NOT_APPLICABLE attributes:

-- Size:
UPDATE Production.Product 
SET Size_null_reason = CASE
    WHEN Size IS NOT NULL THEN 'KNOWN'
    WHEN FinishedGoodsFlag = 0 THEN 'NOT_APPLICABLE'
    ELSE 'NOT_APPLICABLE'
END;

-- SizeUnitMeasureCode:
UPDATE Production.Product 
SET SizeUnitMeasureCode_null_reason = CASE
    WHEN SizeUnitMeasureCode IS NOT NULL THEN 'KNOWN'
    ELSE 'NOT_APPLICABLE'
END;

-- ProductLine:
UPDATE Production.Product 
SET ProductLine_null_reason = CASE
    WHEN ProductLine IS NOT NULL THEN 'KNOWN'
    ELSE 'NOT_APPLICABLE'
END;
 
-- Style:
UPDATE Production.Product 
SET Style_null_reason = CASE
    WHEN Style IS NOT NULL THEN 'KNOWN'
    ELSE 'NOT_APPLICABLE'
END;
 
-- ProductSubcategoryID:
UPDATE Production.Product 
SET ProductSubcategoryID_null_reason = CASE
    WHEN ProductSubcategoryID IS NOT NULL THEN 'KNOWN'
    WHEN FinishedGoodsFlag = 0            THEN 'NOT_APPLICABLE'
    ELSE 'NOT_APPLICABLE'
END;
 
-- ProductModelID:
UPDATE Production.Product 
SET ProductModelID_null_reason = CASE
    WHEN ProductModelID IS NOT NULL THEN 'KNOWN'
    WHEN FinishedGoodsFlag = 0      THEN 'NOT_APPLICABLE'
    ELSE 'NOT_APPLICABLE'
END;

-- CarrierTrackingNumber
UPDATE sod 
SET CarrierTrackingNumber_null_reason = CASE
    WHEN sod.CarrierTrackingNumber IS NOT NULL THEN 'KNOWN'
    ELSE 'NOT_APPLICABLE'
END
FROM Sales.SalesOrderDetail sod
INNER JOIN Sales.SalesOrderHeader soh
    ON soh.SalesOrderID = sod.SalesOrderID;
-- ── Mixed-status attributes ───────────────────────────────────
 
-- Color:
UPDATE Production.Product 
SET Color_null_reason = CASE
        WHEN Color IS NOT NULL THEN 'KNOWN'
        WHEN FinishedGoodsFlag = 0 THEN 'NOT_APPLICABLE'
        WHEN MakeFlag = 1 AND FinishedGoodsFlag = 1 THEN 'NOT_APPLICABLE'
        ELSE 'UNKNOWN'
END;
 
-- Weight and WeightUnitMeasureCode:
UPDATE Production.Product 
SET Weight_null_reason = CASE
    WHEN Weight IS NOT NULL THEN 'KNOWN'
    WHEN FinishedGoodsFlag = 0 THEN 'NOT_APPLICABLE'
    WHEN Style IS NOT NULL THEN 'NOT_APPLICABLE'
    ELSE 'UNKNOWN'
END;
 
UPDATE Production.Product 
SET WeightUnitMeasureCode_null_reason = CASE
    WHEN WeightUnitMeasureCode IS NOT NULL THEN 'KNOWN'
    WHEN FinishedGoodsFlag = 0 THEN 'NOT_APPLICABLE'
    WHEN Style IS NOT NULL THEN 'NOT_APPLICABLE'
    ELSE 'UNKNOWN'
END;
 
-- Class:
UPDATE Production.Product 
SET Class_null_reason = CASE
    WHEN Class IS NOT NULL THEN 'KNOWN'
    WHEN FinishedGoodsFlag = 0 THEN 'NOT_APPLICABLE'
    WHEN Name LIKE '%Touring Pedal%' OR Name LIKE '%Touring Wheel%' THEN 'UNKNOWN'
    ELSE 'NOT_APPLICABLE'
END;

-- MiddleName:
UPDATE Person.Person 
SET MiddleName_null_reason = CASE
    WHEN MiddleName IS NOT NULL THEN 'KNOWN'
    WHEN PersonType = 'GC' THEN 'UNKNOWN'
    ELSE 'NOT_APPLICABLE'
END;
 
-- CurrencyRateID:
UPDATE soh 
SET CurrencyRateID_null_reason = CASE
    WHEN soh.CurrencyRateID IS NOT NULL THEN 'KNOWN'
    WHEN st.CountryRegionCode = 'US' THEN 'NOT_APPLICABLE'
    ELSE 'UNKNOWN'
    END
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.SalesTerritory st
    ON st.TerritoryID = soh.TerritoryID;