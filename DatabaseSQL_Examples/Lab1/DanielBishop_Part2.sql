-- Daniel Bishop

--1
SELECT CUSTOMERID, ORDERID, ORDERDATE
FROM ORDERS
WHERE ORDERDATE LIKE '%-14%'

--2
ALTER TABLE CUSTOMERS
ADD ACTIVE VARCHAR2(5 CHAR) DEFAULT 'TRUE';

--3 -- I tried this multiple different ways to get this but I was unsucessful.
 SELECT CompanyName, ORDERDATE, SUM(QUANTITY * UNITPRICE + FREIGHT)
 FROM ORDERS
 INNER JOIN ORDERDETAILS ON ORDERS.ORDERID = ORDERDETAILS.ORDERID
 INNER JOIN CUSTOMERS ON ORDERS.CUSTOMERID = CUSTOMERS.CUSTOMERID
 WHERE ORDERS.ORDERDATE < '01-Sept-2012'
 
-- SELECT CompanyName, ORDERDATE, SUM(QUANTITY * UNITPRICE + FREIGHT)
-- FROM ORDERS
-- WHERE ORDERS.CUSTOMERID=CUSTOMERS.CUSTOMERID 
--    AND ORDERS.ORDERID = ORDERDETAILS.ORDERID 
--    AND ORDERS.ORDERDATE < '01-Sept-2012'

--4
SELECT ORDERID, SHIPNAME, SHIPADDRESS, CUSTOMERID
FROM ORDERS
WHERE SHIPVIA = '3'

--5
SELECT *
FROM CUSTOMERS
INNER JOIN ORDERS ON CUSTOMERS.CUSTOMERID = ORDERS.CUSTOMERID
WHERE ORDERDATE NOT LIKE '%-11%'

--6 
SELECT *
FROM PRODUCTS
WHERE PRODUCTID NOT IN (SELECT PRODUCTID FROM ORDERDETAILS);

--7
SELECT CUSTOMERID, CONTACTNAME, ORDERID
FROM 
(SELECT CUSTOMERS.CUSTOMERID, CONTACTNAME, ORDERS.ORDERID
FROM ORDERS 
INNER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMERID = ORDERS.CUSTOMERID 
WHERE ORDERS.SHIPCITY LIKE '%Londo%'); --There wasn't a London.

--8
SELECT PRODUCTNAME, NAME
FROM PRODUCTS
INNER JOIN SUPPLIERS ON PRODUCTS.SUPPLIERID = SUPPLIERS.SUPPLIERID
WHERE PRODUCTS.SUPPLIERID = '1' OR PRODUCTS.SUPPLIERID = '2';

--9
SELECT PRODUCTNAME, QUANTITYPERUNIT
FROM PRODUCTS
WHERE QUANTITYPERUNIT LIKE '%boxes%';

