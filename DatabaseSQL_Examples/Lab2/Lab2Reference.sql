SET SERVEROUTPUT ON;

--message
DECLARE
    message varchar2(20) := 'Hello, World!';
BEGIN
    dbms_output.put_line(message);
END;

--constant
DECLARE
    emp_id number(6,0) := 199;
    max_increase constant number := 0.15;
BEGIN
    Null;
END;

--variable
DECLARE
    emp_id number;
    dept_id number := 80;
BEGIN
    select employee_id into emp_id
        from hr.employees
            where department_id = dept_id
                and first_name = 'John';
    
    dbms_output.put_line(emp_id);
END;

--subprogram
DECLARE
    a number; b number; c number;
    PROCEDURE   findMin(x in number, y in number, z out number) is
    
    BEGIN
        if x < y then
            z:=x;
        else
            z:=y;
        END IF;
    END;
BEGIN
    a:=23; b:=45;
    findMin(a,b,c);
    dbms_output.put_line('Minimum of (23, 45): ' || c);
END;

--bind
VARIABLE return_value number;
    
BEGIN
    :return_value := 7.5;
END;

--VariableTypes  %TYPE - will match a DB column, %ROWTYPE - will match row

--CaseAndIf
CASE
    WHEN job_id = 'PU_CLERK' THEN
        if sal < 3000 then
            sal_raise := 0.12;
        else
            sal_raise := 0.09;
        end if;
    else
        dbms_output.put_line('No Raise.');
END CASE;

--LOOPS
LOOP
END LOOP

LOOP
    EXIT WHEN total > 25000;
END LOOP;

FOR i IN 1..100 LOOP
END LOOP

WHILE salary < 15000 LOOP
END LOOP

--Cursor - Attributes: %Found, %notfound, %isopen - checks if cursor is open, %row count - returns number of rows
DECLARE
    CURSOR emp_Cursor IS
        select last_name, salary
        from hr.employees
            where salary > 3000;
        
        employee_rec emp_Cursor%Rowtype;
BEGIN
    OPEN emp_cursor;
    
    loop 
        fetch emp_cursor into employee_rec;
        
        exit when emp_cursor%notfound;
            dbms_output.put_line(' Employee Name: ' || employee_rec.last_name );
    end loop;
    
    close emp_cursor;
END;


--StoredProcedure
create or replace procedure my_procedure
(
    name in varchar2,
    dept_id in number
) as
begin
    -- do stuff
    null;
end my_procedure;


--StoredFunction
create or replace function my_function
(
    name in varchar2,
    dept_id in number
) return varchar2 as
begin
    -- do stuff
    return varchar2Value
end my_function;

--StoredTrigger
create or replace trigger my_trigger
before
insert or update or delete
    of animal_type, name on animal
for each row
begin
    -- do stuff
    null;
end;


--Package
create package cust_sal as
    procedure find_sal(c_id customers.id%type);
end cust_sal;


--package body
create package cust_sal as
    procedure find_sal(c_id customers.id%type) is
        c_salary Customers.Salary%type;
    begin
        select salary into c_salary
            from customers
        where customer_id = c_id;
        dbms_output.put_line('Salary: ' || c_salary );
    end find_sal;
    
end cust_sal;



--TempTables
create global temporary table shop_cart (
    item_num number,
    qty number,
    price number(6,2))
    on commit delete rows;
    
--TempTableExa
insert into shop_cart values (1932, 5, 21.52);

select * from shop_cart; --new row is visible

commit; --clears the table if
        --on commit delete row
select * from shop_cartl