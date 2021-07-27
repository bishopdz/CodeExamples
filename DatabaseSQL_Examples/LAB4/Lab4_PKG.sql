set serveroutput on;
CREATE PACKAGE SKISHOP AS PROCEDURE FREESTYLE_SKILL(SKILLLEVEL INTEGER, STYLE VARCHAR2);
END SKISHOP;
/
CREATE PACKAGE BODY SKISHOP AS PROCEDURE FREESTYLE_SKILL(SKILLLEVEL INTEGER, STYLE VARCHAR2) IS
cRow ALLPOWDER.CUSTOMER%ROWTYPE;
  CURSOR cSkills IS
    SELECT lastname, firstname, email, skilllevel
      from allpowder.customer c
     inner join allpowder.customerskill cs on c.customerid = cs.customerid
     where cs.skilllevel >= 6 and cs.style = 'Freestyle'
     order by skilllevel, lastname, firstname;
     
   cRow cSkills%ROWTYPE;
BEGIN
  FOR cRow IN cSkills LOOP
   DBMS_OUTPUT.PUT_LINE('Name  : ' || cRow.lastname || ', ' || cRow.firstname);
   DBMS_OUTPUT.PUT_LINE('Email : ' || cRow.email);
   DBMS_OUTPUT.PUT('Rating: ');
   FOR j in 1..cRow.skilllevel LOOP
     DBMS_OUTPUT.PUT('*');
   END LOOP;
   DBMS_OUTPUT.PUT_LINE('');
   DBMS_OUTPUT.NEW_LINE; 
  END LOOP;
  END FREESTYLE_SKILL;
END SKISHOP;
/

--PART 2--
SET SERVEROUTPUT ON;
CREATE OR REPLACE PACKAGE SKISHOP AS PROCEDURE MONTHLY_FEES(RENTDATE VARCHAR2, PAYMENTMETHOD VARCHAR2);
END SKISHOP;
/
CREATE OR REPLACE PACKAGE BODY SKISHOP AS 
FUNCTION RENTAL_FEES(RENTDATE IN VARCHAR2, RENTFEE IN INTEGER)
RETURN INTEGER IS
RENT_INT INTEGER;
CURSOR C1 IS SELECT
    TO_CHAR(RENTDATE, 'MONTH') AS MONTH, 
    SUM(RENTFEE) FROM ALLPOWDER.RENTAL;
    BEGIN OPEN C1;
    FETCH C1 INTO RENT_INT;
    IF C1%NOTFOUND
    THEN DBMS_OUTPUT.PUT_LINE('CURSOR NOT FOUND.');
    END IF;
    CLOSE C1;
    RETURN RENT_INT;
    EXPECTION THEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'AN ERROR WAS ENCOUNTERED ' || SQLCODE || ' ERROR');
    END RENTAL_FEES;

PROCEDURE MONTHLY_FEES(RENTDATE VARCHAR2, PAYMENTMETHOD VARCHAR2) IS
CROW ALLPOWDER.RENTAL%ROWTYPE;
CURSOR CMETHOD IS
    select to_char(r.rentdate,'Month') as mon, 
           r.paymentmethod as paymentmethod, 
           SUM(ri.rentfee) as rentfees
      from allpowder.rental r
     inner join allpowder.rentitem ri
            on r.rentid = ri.rentid
     group by to_char(r.rentdate,'Month'), to_char(r.rentdate,'MM'), r.paymentmethod
     order by to_char(r.rentdate,'MM'), r.paymentmethod;
  cRow cMethods%ROWTYPE;
  lastMonth VARCHAR2(12) := 'Month';
  total NUMBER(10,2) := 0;
BEGIN
  OPEN cMethods;
  LOOP
    FETCH cMethods INTO cRow;
    EXIT WHEN cMethods%NOTFOUND;
    IF lastMonth <> cRow.mon THEN
      IF lastMonth <> 'Month' THEN
        DBMS_OUTPUT.PUT_LINE(RPAD('-',31,'-'));
        DBMS_OUTPUT.PUT_LINE('   ' || RPAD('Total Rentals',18,' ') || ' : $' || TO_CHAR(total,'99,999'));
        total := 0;
      END IF;
      DBMS_OUTPUT.NEW_LINE;
      DBMS_OUTPUT.PUT_LINE(RPAD(cRow.mon || ' Rentals ',31,'-'));
      lastMonth := cRow.mon;
    END IF;
    DBMS_OUTPUT.PUT_LINE('   ' || RPAD(cRow.paymentmethod,18,' ') || ' : $' || TO_CHAR(cRow.rentfees,'9,999'));
    total := total + cRow.rentfees; 
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(RPAD('-',31,'-'));
  DBMS_OUTPUT.PUT_LINE('   ' || RPAD('Total Rentals',18,' ') || ' : $' || TO_CHAR(total,'99,999')); 
  CLOSE cMethods;
  END MONTHLY_RENTALS;
END SKISHOP;
/


--PART 3--
SET SERVEROUTPUT ON;
CREATE OR REPLACE PACKAGE SKISHOP AS PROCEDURE COST_CSV(NAME VARCHR2, MODELID INTEGER, CATEGORY VARCHAR2, COST INTEGER, 
LISTPRICE INTEGER, QUANTITYONHAND INTEGER);
END SKISHOP;
/
CREATE OR REPLACE PACKAGE BODY SKISHOP AS PROCEDURE COST_CSV(NAME VARCHR2, MODELID INTEGER, CATEGORY VARCHAR2, COST INTEGER, 
LISTPRICE INTEGER, QUANTITYONHAND INTEGER);
CROW ALLPOWDER.INVENTORY%ROWTYPE;

CURSOR cCSV IS
    select distinct m.name Manufacturer, 
           im.modelid ModelNumber, 
           im.category Category, 
           im.cost Cost, 
           im.listprice ListPrice, 
           i.quantityonhand QuantityOnHand,
           (im.cost)*i.quantityonhand TotalCost,
           (im.listprice)*i.quantityonhand TotalListPrice, 
           (im.listprice-im.cost)*i.quantityonhand TotalProfit
      from allpowder.inventory i
    inner join allpowder.itemmodel im on i.modelid = im.modelid
    inner join allpowder.manufacturer m on im.manufacturerid = m.manufacturerid
    order by 1, 2;
  cRow cCSV%ROWTYPE;
BEGIN
  FOR cRow in cCSV LOOP
    DBMS_OUTPUT.PUT_LINE ( '"' || cRow.Manufacturer || '","' ||
           cRow.ModelNumber || '","' ||
           cRow.Category || '","' ||
           cRow.Cost || '","' ||
           cRow.ListPrice || '","' ||
           cRow.QuantityOnHand || '","' ||
           cRow.TotalCost || '","' ||
           cRow.TotalListPrice || '","' ||
           cRow.TotalProfit || '"');
  END LOOP;
END COST_CSV;
END SKISHOP;
/