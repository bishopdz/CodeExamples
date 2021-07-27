/*  Lab 8 - Data Warehouse Creation Script  */
/*  CSCI 3020 - Database Advanced Concepts  */

/*
  SNOWFLAKE SCHEMA
  
  Dimension Tables:
	Animal
	Customer
    DateLookup
	EMPLOYEE
	MERCHANDISE
	SUPPLIER
    
  Fact Tables:
    ORDERS
    SALES
*/

DROP TABLE ANIMAL CASCADE CONSTRAINTS;
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE DATELOOKUP CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE MERCHANDISE CASCADE CONSTRAINTS;
DROP TABLE ORDERS CASCADE CONSTRAINTS;
DROP TABLE SALES CASCADE CONSTRAINTS;
DROP TABLE SUPPLIER CASCADE CONSTRAINTS;

/******************************************************************************/
/* DIMENSION TABLES
/******************************************************************************/
CREATE TABLE DateLookup (
  DateID NUMBER(38,0),
  TheDate DATE,
  Month VARCHAR2(3),
  Day VARCHAR2(2),
  Year VARCHAR2(4),
  PRIMARY KEY (DateID)
);

CREATE TABLE Animal (
  ANIMALID	NUMBER(38,0),
  NAME	VARCHAR2(50 BYTE),
  CATEGORY	VARCHAR2(50 BYTE),
  BREED	VARCHAR2(50 BYTE),
  DATEBORN	DATE,
  GENDER	VARCHAR2(50 BYTE),
  REGISTERED	VARCHAR2(50 BYTE),
  COLOR	VARCHAR2(50 BYTE),
  LISTPRICE	NUMBER(38,4),
  PRIMARY KEY (AnimalID)
);

CREATE TABLE Supplier (
  SUPPLIERID	NUMBER(38,0),
  NAME	VARCHAR2(50 BYTE),
  CONTACTNAME	VARCHAR2(50 BYTE),
  PHONE	VARCHAR2(50 BYTE),
  ADDRESS VARCHAR2(50 BYTE),
  CITY	VARCHAR2(50 BYTE),
  STATE	VARCHAR2(50 BYTE),
  ZIPCODE	VARCHAR2(50 BYTE),
  PRIMARY KEY (SupplierID)
);

CREATE TABLE Merchandise (
  MerchandiseID NUMBER(38,0),
  DESCRIPTION	VARCHAR2(50 BYTE),
  QUANTITYONHAND	NUMBER(38,0),
  LISTPRICE	NUMBER(38,4),
  CATEGORY	VARCHAR2(50 BYTE),
  PRIMARY KEY (MerchandiseID)
);

CREATE TABLE Employee (
  EMPLOYEEID	NUMBER(38,0),
  NAME	VARCHAR2(101 BYTE),
  ADDRESS	VARCHAR2(200 BYTE),
  DATEHIRED	NUMBER(38,0),
  PRIMARY KEY (EmployeeID),
  FOREIGN KEY (DATEHIRED) REFERENCES DateLookup(DateID)
);

CREATE TABLE Customer (
  CUSTOMERID	NUMBER(38,0),
  PHONE	VARCHAR2(50 BYTE),
  FIRSTNAME	VARCHAR2(50 BYTE),
  LASTNAME	VARCHAR2(50 BYTE),
  ADDRESS	VARCHAR2(50 BYTE),
  CITY	VARCHAR2(50 BYTE),
  STATE	VARCHAR2(50 BYTE),
  ZIPCODE	VARCHAR2(50 BYTE),
  PRIMARY KEY (CustomerID)
);

/******************************************************************************/
/* FACT TABLES
/******************************************************************************/
CREATE TABLE Orders (
  OrderID NUMBER(38,0),
  OrderDate NUMBER(38,0),
  ReceivedDate NUMBER(38,0),
  Quantity NUMBER(38,0),
  Cost NUMBER(38,4),
  ShippingCost NUMBER(38,4),
  AnimalID NUMBER(38,0),
  MerchandiseID NUMBER(38,0),
  SupplierID NUMBER(38,0),
  EmployeeID NUMBER(38,0),
  PRIMARY KEY (OrderID),
  FOREIGN KEY (OrderDate) REFERENCES DateLookup(DateID),
  FOREIGN KEY (ReceivedDate) REFERENCES DateLookup(DateID),
  FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID),
  FOREIGN KEY (MerchandiseID) REFERENCES Merchandise(MerchandiseID),
  FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
  FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Sales (
  SaleFactID NUMBER(38,0),
  SaleID NUMBER(38,0),
  SaleDate NUMBER(38,0),
  EmployeeID NUMBER(38,0),
  CustomerID NUMBER(38,0),
  AnimalID NUMBER(38,0),
  MerchandiseID NUMBER(38,0),
  Quantity  NUMBER(38,0),
  SalePrice  NUMBER(38,4),
  SalesTax  NUMBER(38,4),
  PRIMARY KEY (SaleFactID),
  FOREIGN KEY (SaleDate) REFERENCES DateLookup(DateID),
  FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID),
  FOREIGN KEY (MerchandiseID) REFERENCES Merchandise(MerchandiseID),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);


/*  Lab 8 - Data Warehouse ETL Script  */
/*  CSCI 3020 - Database Advanced Concepts  */


INSERT INTO datelookup
SELECT Row_number()
         over (
           ORDER BY dt ASC),
       dt,
       month,
       day,
       year
FROM   (SELECT DISTINCT orderdate                  Dt,
                        To_char(orderdate, 'MON')  Month,
                        To_char(orderdate, 'DD')   Day,
                        To_char(orderdate, 'YYYY') Year
        FROM   petstore.animalorder
        UNION
        SELECT DISTINCT orderdate                  Dt,
                        To_char(orderdate, 'MON')  Month,
                        To_char(orderdate, 'DD')   Day,
                        To_char(orderdate, 'YYYY') Year
        FROM   petstore.merchandiseorder
        UNION
        SELECT DISTINCT datehired                  Dt,
                        To_char(datehired, 'MON')  Month,
                        To_char(datehired, 'DD')   Day,
                        To_char(datehired, 'YYYY') Year
        FROM   petstore.employee
        UNION
        SELECT DISTINCT saledate                  Dt,
                        To_char(saledate, 'MON')  Month,
                        To_char(saledate, 'DD')   Day,
                        To_char(saledate, 'YYYY') Year
        FROM   petstore.sale)
ORDER  BY dt ASC;

INSERT INTO employee
SELECT e.employeeid,
       e.lastname
       || ', '
       || e.firstname,
       e.address,
       d.dateid
FROM   petstore.employee e
       join datelookup d
         ON e.datehired = d.thedate;

INSERT INTO supplier
SELECT s.supplierid,
       s.name,
       s.contactname,
       s.phone,
       s.address,
       c.city,
       c.state,
       s.zipcode
FROM   petstore.supplier s
       join petstore.city c
         ON s.cityid = c.cityid;

INSERT INTO animal
SELECT a.animalid,
       a.name,
       a.category,
       a.breed,
       a.dateborn,
       a.gender,
       a.registered,
       a.color,
       a.listprice
FROM   petstore.animal a;

INSERT INTO merchandise
SELECT DISTINCT m.itemid,
                m.description,
                m.quantityonhand,
                m.listprice,
                m.category
FROM   petstore.merchandise m;

INSERT INTO customer
SELECT DISTINCT cu.customerid,
                cu.phone,
                cu.firstname,
                cu.lastname,
                cu.address,
                c.city,
                c.state,
                cu.zipcode
FROM   petstore.customer cu
       join petstore.city c
         ON cu.cityid = c.cityid;

/
INSERT INTO orders
SELECT Row_number()
         over (
           ORDER BY orderdateid),
       orderdateid,
       receivedateid,
       quantity,
       cost,
       shippingcost,
       animalid,
       merchandiseid,
       supplierid,
       employeeid
FROM   (SELECT order_date.dateid   orderdateid,
               RECEIVE_DATE.dateid receivedateid,
               moi.quantity        quantity,
               moi.cost            cost,
               mo.shippingcost     shippingcost,
               NULL                animalid,-- Animal ID,
               moi.ponumber        merchandiseid,-- Merchandise ID
               mo.supplierid       supplierid,
               mo.employeeid       employeeid
        FROM   petstore.merchandiseorder mo
               left join petstore.orderitem moi
                      ON mo.ponumber = moi.ponumber
               left join datelookup order_date
                      ON mo.orderdate = order_date.thedate
               left join datelookup receive_date
                      ON mo.receivedate = receive_date.thedate
        UNION
        SELECT order_date.dateid   orderdateid,
               RECEIVE_DATE.dateid receivedateid,
               1                   quantity,
               -- Quantity here is always 1 for animal orders.
               aoi.cost            cost,
               ao.shippingcost     shippingcost,
               aoi.animalid        animalid,
               NULL                merchandiseid,
               -- Merchandise ID is always null for animal orders.
               ao.supplierid       supplierid,
               ao.employeeid       employeeid
        FROM   petstore.animalorder ao
               left join petstore.animalorderitem aoi
                      ON ao.orderid = aoi.orderid
               left join datelookup order_date
                      ON ao.orderdate = order_date.thedate
               left join datelookup receive_date
                      ON ao.receivedate = receive_date.thedate);

/
INSERT INTO sales
SELECT Row_number()
         over (
           ORDER BY saleid),
       saleid,
       saledateid,
       employeeid,
       customerid,
       animalid,
       merchandiseid,
       quantity,
       saleprice,
       salestax
FROM   (SELECT saleid,
               SALEDATE.dateid SaleDateID,
               s.employeeid,
               s.customerid,
               sa.animalid,
               NULL            MerchandiseID,
               1               Quantity,
               sa.saleprice,
               s.salestax
        FROM   petstore.sale s
               NATURAL join petstore.saleanimal sa
                            left join datelookup saledate
                                   ON s.saledate = saledate.thedate
        UNION
        SELECT saleid          saleid,
               SALEDATE.dateid SaleDateID,
               s.employeeid    EmployeeID,
               s.customerid    CustomerID,
               NULL            AnimalID,
               si.itemid       MerchandiseID,
               si.quantity     Quantity,
               si.saleprice    SalePrice,
               s.salestax      SalesTax
        FROM   petstore.sale s
               NATURAL join petstore.saleitem si
                            left join datelookup saledate
                                   ON s.saledate = saledate.thedate
        ORDER  BY 1);

COMMIT;
