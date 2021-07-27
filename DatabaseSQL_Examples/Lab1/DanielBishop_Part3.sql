-- Daniel Bishop

--1
CREATE TABLE employees
(
    EmployeeID NUMBER (38,0) PRIMARY KEY, --The way I normally do it would not work
    FirstName VARCHAR2(255 CHAR),
    LastName VARCHAR2(255 CHAR),
    Address VARCHAR2(255 CHAR),
    City VARCHAR2(255 CHAR),
    Provence VARCHAR2(255 CHAR),
    Postalcode VARCHAR2(255 CHAR),
    Phone VARCHAR2(255 CHAR),
    Salary VARCHAR2(255 CHAR)
)

ALTER TABLE ORDERS
ADD FOREIGN KEY (EMPLOYEEID) REFERENCES EMPLOYEES(EMPLOYEEID);

--1 - Insert
INSERT INTO Employees (EmployeeID, FirstName, LastName, Address, City, Provence, Postalcode, Phone, Salary)
VALUES ('123','Bob','Ross','Happy Trees Lane','Studio','CA', '789546', '555-555-5555', '100,000');

INSERT INTO Employees (EmployeeID, FirstName, LastName, Address, City, Provence, Postalcode, Phone, Salary)
VALUES ('124','Jane','Ross','Happy Trees Lane','Studio','CA', '789546', '555-555-5555', '100,000');

INSERT INTO Employees (EmployeeID, FirstName, LastName, Address, City, Provence, Postalcode, Phone, Salary)
VALUES ('125','Jimmy','Ross','Happy Trees Lane','Studio','CA', '789546', '555-555-5555', '100,000');

INSERT INTO Employees (EmployeeID, FirstName, LastName, Address, City, Provence, Postalcode, Phone, Salary)
VALUES ('126','Billy','Ross','Happy Trees Lane','Studio','CA', '789546', '555-555-5555', '100,000');

INSERT INTO Employees (EmployeeID, FirstName, LastName, Address, City, Provence, Postalcode, Phone, Salary)
VALUES ('127','Susie','Ross','Happy Trees Lane','Studio','CA', '789546', '555-555-5555', '100,000');

select * from employees


--2
ALTER TABLE Orders
ADD TotalSales VARCHAR2(255 CHAR);


--3
UPDATE Orders
SET TotalSales = SUM((ORDERDETAILS.UNITPRICE*ORDERDETAILS.QUANTITY)+ORDERS.FREIGHT);
