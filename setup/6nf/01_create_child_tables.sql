CREATE TABLE Person.Person_MiddleName (
    BusinessEntityID  INT           NOT NULL,
    MiddleName        NVARCHAR(50)  NOT NULL,
    CONSTRAINT PK_Person_MiddleName PRIMARY KEY (BusinessEntityID),
    CONSTRAINT FK_Person_MiddleName_BusinessEntityID
        FOREIGN KEY (BusinessEntityID) REFERENCES Person.Person(BusinessEntityID)
);

CREATE TABLE Production.Product_Color (
    ProductID  INT           NOT NULL,
    Color      NVARCHAR(15)  NOT NULL,
    CONSTRAINT PK_Product_Color PRIMARY KEY (ProductID),
    CONSTRAINT FK_Product_Color_ProductID
        FOREIGN KEY (ProductID) REFERENCES Production.Product(ProductID)
);

CREATE TABLE Production.Product_Size (
    ProductID  INT           NOT NULL,
    Size       NVARCHAR(5)   NOT NULL,
    CONSTRAINT PK_Product_Size PRIMARY KEY (ProductID),
    CONSTRAINT FK_Product_Size_ProductID
        FOREIGN KEY (ProductID) REFERENCES Production.Product(ProductID)
);

CREATE TABLE Production.Product_SizeUnitMeasureCode (
    ProductID           INT      NOT NULL,
    SizeUnitMeasureCode NCHAR(3) NOT NULL,
    CONSTRAINT PK_Product_SizeUnitMeasureCode PRIMARY KEY (ProductID),
    CONSTRAINT FK_Product_SizeUnitMeasureCode_ProductID
        FOREIGN KEY (ProductID) REFERENCES Production.Product(ProductID)
);

CREATE TABLE Production.Product_WeightUnitMeasureCode (
    ProductID             INT      NOT NULL,
    WeightUnitMeasureCode NCHAR(3) NOT NULL,
    CONSTRAINT PK_Product_WeightUnitMeasureCode PRIMARY KEY (ProductID),
    CONSTRAINT FK_Product_WeightUnitMeasureCode_ProductID
        FOREIGN KEY (ProductID) REFERENCES Production.Product(ProductID)
);

CREATE TABLE Production.Product_Weight (
    ProductID  INT             NOT NULL,
    Weight     DECIMAL(8, 2)   NOT NULL,
    CONSTRAINT PK_Product_Weight PRIMARY KEY (ProductID),
    CONSTRAINT FK_Product_Weight_ProductID
        FOREIGN KEY (ProductID) REFERENCES Production.Product(ProductID)
);

CREATE TABLE Production.Product_ProductLine (
    ProductID    INT     NOT NULL,
    ProductLine  NCHAR(2) NOT NULL,
    CONSTRAINT PK_Product_ProductLine PRIMARY KEY (ProductID),
    CONSTRAINT FK_Product_ProductLine_ProductID
        FOREIGN KEY (ProductID) REFERENCES Production.Product(ProductID)
);

CREATE TABLE Production.Product_Class (
    ProductID  INT      NOT NULL,
    Class      NCHAR(2) NOT NULL,
    CONSTRAINT PK_Product_Class PRIMARY KEY (ProductID),
    CONSTRAINT FK_Product_Class_ProductID
        FOREIGN KEY (ProductID) REFERENCES Production.Product(ProductID)
);

CREATE TABLE Production.Product_Style (
    ProductID  INT      NOT NULL,
    Style      NCHAR(2) NOT NULL,
    CONSTRAINT PK_Product_Style PRIMARY KEY (ProductID),
    CONSTRAINT FK_Product_Style_ProductID
        FOREIGN KEY (ProductID) REFERENCES Production.Product(ProductID)
);

CREATE TABLE Production.Product_ProductSubcategoryID (
    ProductID            INT  NOT NULL,
    ProductSubcategoryID INT  NOT NULL,
    CONSTRAINT PK_Product_ProductSubcategoryID PRIMARY KEY (ProductID),
    CONSTRAINT FK_Product_ProductSubcategoryID_ProductID
        FOREIGN KEY (ProductID) REFERENCES Production.Product(ProductID),
    CONSTRAINT FK_Product_ProductSubcategoryID_SubcatID         -- preserve semantic FK
        FOREIGN KEY (ProductSubcategoryID)
        REFERENCES Production.ProductSubcategory(ProductSubcategoryID)
);

CREATE TABLE Production.Product_ProductModelID (
    ProductID      INT  NOT NULL,
    ProductModelID INT  NOT NULL,
    CONSTRAINT PK_Product_ProductModelID PRIMARY KEY (ProductID),
    CONSTRAINT FK_Product_ProductModelID_ProductID
        FOREIGN KEY (ProductID) REFERENCES Production.Product(ProductID),
    CONSTRAINT FK_Product_ProductModelID_ModelID                -- preserve semantic FK
        FOREIGN KEY (ProductModelID)
        REFERENCES Production.ProductModel(ProductModelID)
);

CREATE TABLE Sales.SalesOrderDetail_CarrierTrackingNumber (
    SalesOrderID        INT           NOT NULL,
    SalesOrderDetailID  INT           NOT NULL,
    CarrierTrackingNumber NVARCHAR(25) NOT NULL,
    CONSTRAINT PK_SalesOrderDetail_CarrierTrackingNumber
        PRIMARY KEY (SalesOrderID, SalesOrderDetailID),
    CONSTRAINT FK_SalesOrderDetail_CarrierTrackingNumber_Parent
        FOREIGN KEY (SalesOrderID, SalesOrderDetailID)
        REFERENCES Sales.SalesOrderDetail(SalesOrderID, SalesOrderDetailID)
);

CREATE TABLE Sales.SalesOrderHeader_CurrencyRateID (
    SalesOrderID    INT  NOT NULL,
    CurrencyRateID  INT  NOT NULL,
    CONSTRAINT PK_SalesOrderHeader_CurrencyRateID PRIMARY KEY (SalesOrderID),
    CONSTRAINT FK_SalesOrderHeader_CurrencyRateID_SalesOrderID
        FOREIGN KEY (SalesOrderID) REFERENCES Sales.SalesOrderHeader(SalesOrderID),
    CONSTRAINT FK_SalesOrderHeader_CurrencyRateID_CurrencyRateID  -- preserve semantic FK
        FOREIGN KEY (CurrencyRateID) REFERENCES Sales.CurrencyRate(CurrencyRateID)
);