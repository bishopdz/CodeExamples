SET SERVEROUTPUT ON;


--Popular locations
select l.city, l.state, count(s.location_id) as total
from services s 
 join locations l
    on l.location_id = s.location_id
 left join service_types st
    on st.service_type_id = s.service_type_id
group by l.city, l.state
order by total desc;

--Popular services at each location
select l.city, l.state, st.service_type, count(s.service_type_id) as st_count
from services s 
 join locations l
    on l.location_id = s.location_id
 left join service_types st
    on st.service_type_id = s.service_type_id
group by l.city, l.state, st.service_type
order by City, st_count desc;

--Most popular services
select st.service_type, count(s.service_type_id) as st_count
from services s 
 left join service_types st
    on st.service_type_id = s.service_type_id
group by st.service_type
order by st_count desc;

--Most popular packages
select p.package_name, count(op.package_id) as count
from order_packages op
 left join packages p
    on p.package_id = op.package_id
group by p.package_name
order by count desc;


--Client Report
DECLARE
    fName varchar(30) := 'Vielka';
    lName varchar(30) := 'Dejesus';
    company_name varchar(100) := 'Proin Sed Corp.';

    cursor c_name is
    
    select cs.customer_id, cs.company_name, Count(contract_id) as total
        FROM customers cs
        JOIN contracts ct 
            ON cs.customer_id = ct.customer_id
        WHERE company_name = cs.company_name
        GROUP BY cs.company_name, cs.customer_id
        order by total desc
        FETCH FIRST ROW ONLY;
        
    com_rec c_name%rowtype;
    
   cursor c_null_name is
    
    select cs.first_name, cs.last_name, Count(contract_id) as total 
        FROM customers cs
        JOIN contracts ct 
            ON cs.customer_id = ct.customer_id
        WHERE cs.first_name = fname AND cs.last_name = lname
        GROUP BY cs.first_name, cs.last_name
        order by total desc
        FETCH FIRST ROW ONLY;
        
    cus_rec c_null_name%rowtype;
    
BEGIN 

    IF company_name IS NOT NULL THEN
        open c_name;
            fetch c_name into com_rec;
            dbms_output.put_line('Company Name: ' || company_name);
        close c_name;
    ELSE
        open c_null_name;
            fetch c_null_name into cus_rec;
            dbms_output.put_line('First Name: ' || fname);
        close c_null_name;
    END IF;

END;
/

--Weekly Schedule
DECLARE
    firstDate DATE := '01-MAY-19';
    secondDate DATE := '08-JUL-19';



    Cursor schedule IS 
        Select service_time as sday, service_name AS sname, service_time AS stime, end_time AS etime
            FROM services s
            left join contracts c
                on c.service_id = s.service_id
            WHERE trunc(service_time) > firstDate AND trunc(service_time) < secondDate
            ORDER BY service_time;

             v_name services.service_name%TYPE;
             v_time services.service_time%TYPE;
             v_etime services.end_time%TYPE;
             v_day services.service_time%TYPE;

BEGIN
   OPEN schedule;
   LOOP
      FETCH schedule INTO v_day, v_name, v_time, v_etime;
      EXIT WHEN schedule%NOTFOUND;

      dbms_output.put_line(  TO_CHAR( v_day, 'FmDay') || ', ' || trunc(v_time) || '    ' ||  v_name ||  '     '  || TO_CHAR(v_time, 'hh:mm a.m.') || TO_CHAR(v_etime, 'hh:mm a.m.'));
   END LOOP;
   CLOSE schedule;

END;
/

--Photographer Schedule
DECLARE
    firstDate DATE := '01-MAY-19';
    secondDate DATE := '08-JUL-19';



    Cursor schedule IS 
        SELECT s.service_id, s.service_name, st.service_type, trunc(s.service_time), es.emp_id, contract_id
        FROM services s
        join service_types st on st.service_type_id = s.service_type_id
        JOIN contracts c ON c.service_id = s.service_id
        JOIN emp_services es ON es.service_id = s.service_id
        WHERE trunc(service_time) >= firstDate AND trunc(service_time) <= secondDate;
        
    schedule_rec schedule%rowtype;
BEGIN
        OPEN schedule;
   LOOP
      FETCH schedule INTO schedule_rec;
      EXIT WHEN schedule%NOTFOUND;

      dbms_output.put_line(schedule_rec.service_name);
   END LOOP;
   CLOSE schedule;

END;
/