SET SERVEROUTPUT ON;
--1.)
create table countries
as (select * from hr.countries);
create table departments
as (select * from hr.departments);
create table employees
as (select * from hr.employees);
create table job_history
as (select * from hr.job_history);
create table jobs
as (select * from hr.jobs);
create table locations
as (select * from hr.locations);
create table regions
as (select * from hr.regions);

--2.)
DECLARE
    message varchar2(20) := 'Hello, World!';
BEGIN
    dbms_output.put_line(message);
END;

--3.)
create table Test
(
    key varchar2(255) Primary Key,
    value varchar2(255)
);

--4.)
DECLARE
    a number; b number;
    num_small number; num_large number;
    PROCEDURE   findMin(w in number, x in number, y out number, z out number) is
    
    BEGIN
        if x < w then
            y:=x;
            z:=w;
        else
            z:=x;
            y:=w;
        END IF;
    END;
BEGIN
    a:=23; b:=45;
    findMin(a,b,num_small,num_large);
    dbms_output.put_line('Minimum of (23, 45): ' || num_small);
    dbms_output.put_line('Maximum of (23, 45): ' || num_large);
END;

--5.)
declare
	n number:=23;
 
begin
	if mod(n,2)=0
	then
		dbms_output.put_line('number is even');
	else
		dbms_output.put_line('number is odd');
	end if;
end;

--6.)
DECLARE
    vacancy_count number;
    
    BEGIN
     select COUNT(*) into vacancy_count
        from employees
            where department_id = 50;
            
      if vacancy_count >= '45' then
        dbms_output.put_line('There are no vacancies');
     else
         dbms_output.put_line('There are vacancies');
    END IF;
END;


--7.)
DECLARE
    persons_info employees%rowtype;
    incentive number;
BEGIN
    select * into persons_info
        from employees
        where employee_id = 145;
        
    incentive := (persons_info.salary * persons_info.commission_pct); 
    
    dbms_output.put_line(incentive);
END;


--8.)
DECLARE
    height number := 10;
    width number := 5;
    hypotenuse number;
BEGIN   
    hypotenuse := SQRT((height * height)+(width * width)); 
    
    dbms_output.put_line(hypotenuse);
END;


--9.)
DECLARE
    grade number := 100;
    letter_grade varchar2(20);
BEGIN   
    CASE
    WHEN grade >= 90 Then
        dbms_output.put_line('A');
    WHEN grade >= 80 Then
        dbms_output.put_line('B');
    WHEN grade >= 70 Then
        dbms_output.put_line('C');
    WHEN grade >= 60 Then
        dbms_output.put_line('D');
    WHEN grade < 60 Then
        dbms_output.put_line('F');
    ELSE
        dbms_output.put_line('No Grade');
    END CASE;
END;


--10.)
BEGIN
    update employees
    set salary = 1000
    where employee_id = 122;
END;

