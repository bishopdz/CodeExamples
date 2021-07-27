-- Daniel Bishop

Create Table customers
(   
    CustomerID VARCHAR2(255 CHAR),
    CompanyName VARCHAR2(255 CHAR),
    ContactName VARCHAR2(255 CHAR),
    ContactTitle VARCHAR2(255 CHAR),
    Address VARCHAR2(255 CHAR),
    City VARCHAR2(255 CHAR),
    Region VARCHAR2(255 CHAR),
    PostalCode VARCHAR2(255 CHAR),
    Country VARCHAR2(255 CHAR) DEFAULT 'Canada',
    Phone VARCHAR2(255 CHAR),
    Fax VARCHAR2(255 CHAR),
    
    constraint customers_pk Primary Key (CustomerID)
);

Create Table shippers
(
    ShipperID NUMBER (38,0),
    CompanyName VARCHAR2(255 CHAR) Unique,
    
    constraint shippers_pk Primary Key (ShipperID)
);

Create Table orders
(   
    OrderID NUMBER (38,0),
    CustomerID VARCHAR2(255 CHAR),
    EmployeeID NUMBER (38,0),
    ShipName VARCHAR2(255 CHAR),
    ShipAddress VARCHAR2(255 CHAR),
    ShipCity VARCHAR2(255 CHAR),
    ShipRegion VARCHAR2(255 CHAR),
    ShipPostalCode VARCHAR2(255 CHAR),
    ShipCountry VARCHAR2(255 CHAR),
    ShipVia NUMBER (38,0),
    OrderDate date,
    RequireDate date,
    ShippedDate date,
    Freight NUMBER (7,2),

    constraint orders_pk Primary Key (OrderID),
    
    constraint fk_customers
        foreign key (CustomerID)
        references customers(CustomerID)--,
        
    --I commented this out because it complicated things when I ran the full script
    --constraint fk_employees
     --   foreign key (EmployeeID)
      --  references employees(EmployeeID)
            
);

Create Table orderDetails
(   
    OrderID NUMBER (38,0),
    ProductID NUMBER (38,0),
    UnitPrice NUMBER (7,2),
    Quantity NUMBER (10,0) DEFAULT '0',
    Discount FLOAT,
    
    constraint orderDetails_pk Primary Key (OrderID, ProductID),
    
   --I was unable to get it to accept this constraint 
   -- constraint fk_orders
    --    foreign key (OrderID)
      --  references orders(OrderID)
        --,
        
    constraint fk_products
        foreign key (ProductID)
        references products(ProductID)     
);

Create Table products
(
    ProductID NUMBER (38,0),
    SupplierID NUMBER (38,0),
    CategoryID NUMBER (38,0),
    ProductName VARCHAR2(255 CHAR),
    EnglishName VARCHAR2(255 CHAR),
    QuantityPerUnit VARCHAR2(255 CHAR),
    UnitPrice NUMBER (7,2),
    UnitsInStock NUMBER (10,0),
    UnitsOnOrder NUMBER (10,0),
    ReorderLevel NUMBER (10,0),
    Discontinued NUMBER(1,0) not null,
    
    constraint products_pk Primary Key (ProductID),
    
    constraint fk_suppliers
        foreign key (SupplierID)
        references suppliers(SupplierID)
);

Create Table suppliers
(
    SupplierID NUMBER (38,0),
    Name VARCHAR2(255 CHAR),
    Address VARCHAR2(255 CHAR),
    City VARCHAR2(255 CHAR),
    Province VARCHAR2(255 CHAR),
    
    constraint suppliers_pk Primary Key (SupplierID)
);