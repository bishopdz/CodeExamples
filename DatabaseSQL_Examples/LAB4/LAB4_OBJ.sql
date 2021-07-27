CREATE OR REPLACE TYPE COST_OBJ AS OBJECT 
(MANUFACTURER varchar2(30), 
 MODELNUMBER varchar2(30), 
 CATEGORY varchar2(30), 
 COST NUMBER(38,4), 
 LISTPRICE varchar2(30),
 QUANTITYONHAND NUMBER(38,4),
 TOTALCOST NUMBER(38,4),
 TOTALLISTPRICE NUMBER(38,4),
 TOTALPROFIT NUMBER(38,4),
 MEMBER PROCEDURE DISPLAY_CSV
); 
/


--PART 2--
SET SERVEROUTPUT ON;
CREATE OR REPLACE TYPE BODY COST_OBJ AS
    MEMBER PROCEDURE DISPLAY_CSV IS
BEGIN
    DBMS_OUTPUT.PUT_LINE ( '"' || 
           Manufacturer || '","' ||
           ModelNumber || '","' ||
           Category || '","' ||
           Cost || '","' ||
           ListPrice || '","' ||
           QuantityOnHand || '","' ||
           TotalCost || '","' ||
           TotalListPrice || '","' ||
           TotalProfit || '"');
END DISPLAY_CSV;
END;
/


CREATE OR REPLACE PROCEDURE COST_CSV_OBJ AS
    CURSOR cCSV IS
    select distinct 
           m.name Manufacturer, 
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
    
    
    CTR INT :=1; --COUNTER SET TO ONE
    TYPE CSVTABLE IS TABLE OF COST_OBJ;
    CSV COST_OBJ := COST_OBJ(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
    CTABLE CSVTABLE := CSVTABLE();
BEGIN
    FOR CROW IN CCSV LOOP
        CSV := COST_OBJ(CROW.MANUFACTURER, CROW.MODELNUMBER, CROW.CATEGORY, CROW.COST, CROW.LISTPRICE, CROW.QUANTITYONHAND, 
        CROW.TOTALCOST, CROW.TOTALLISTPRICE, CROW.TOTALPROFIT);
        CTABLE.EXTEND(1);
        CTABLE(CTR) := CSV;
        CTR := CTR +1;
        CSV.DISPLAY_CSV;
    END LOOP;
END;
/

EXECUTE ALLPOWDER.COST_CSV_OBJ;