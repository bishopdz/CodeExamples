--The Package for all the reports
--David Beverley, Adam Collier, Zach Hall, and Daniel Bishop

create or replace PACKAGE REPORTS AS 
    PROCEDURE PhotographerSchedule (firstDate DATE, secondDate DATE);
    PROCEDURE WeeklySchedule (firstDate DATE, secondDate DATE);
    PROCEDURE AccountRecievable (firstDate DATE);
    PROCEDURE ClientReport (fName varchar, lName varchar, comp_name varchar);
    PROCEDURE PhotographerAvailability(fname varchar, lname varchar, the_date DATE);
    PROCEDURE PopularLocations;


END REPORTS;
/

create or replace PACKAGE BODY REPORTS AS

    PROCEDURE PhotographerSchedule (firstDate DATE, secondDate DATE) AS

    Cursor schedule IS 
        SELECT s.service_id, s.service_name, st.service_type, trunc(s.service_time) as f_date, s.service_time, s.end_time, es.emp_id, contract_id, e.first_name, e.last_name, l.city, l.state 
        from services s
        join service_types st on st.service_type_id = s.service_type_id
        JOIN contracts c ON c.service_id = s.service_id
        JOIN emp_services es ON es.service_id = s.service_id
        JOIN employees e ON e.emp_id = es.emp_id
        join locations l on l.location_id = s.location_id
        WHERE trunc(service_time) >= firstDate AND trunc(service_time) <= secondDate;
        
    schedule_rec schedule%rowtype;
BEGIN
        OPEN schedule;
        
    dbms_output.put_line(' - Photographer Upcoming Event Schedule - ');
    dbms_output.put_line( rpad('Contract Number' , 20) || rpad('Event Name' , 30) || rpad('Event Type' , 12) || rpad('Location' , 26) || rpad('Date', 14) || rpad('Start Time', 14) || rpad('End Time', 14));
    dbms_output.put_line( rpad('---------------' , 20) || rpad('----------' , 30) || rpad('----------' , 12) || rpad('--------' , 26) || rpad('----', 14) || rpad('----------', 14) || rpad('--------', 14));
   LOOP
      FETCH schedule INTO schedule_rec;
      dbms_output.put_line(  rpad(schedule_rec.contract_id,20) || rpad(schedule_rec.service_name, 30) || rpad(schedule_rec.service_type, 12) || rpad(schedule_rec.city || ', ' || schedule_rec.state, 25) || rpad(schedule_rec.f_date, 14)|| rpad(to_char(schedule_rec.service_time, 'hh:mi a.m.'), 14) || rpad(to_char(schedule_rec.end_time, 'hh:mi a.m.'), 14));
      EXIT WHEN schedule%NOTFOUND;

   END LOOP;
   CLOSE schedule;

END PhotographerSchedule;

    PROCEDURE WeeklySchedule (firstDate DATE, secondDate DATE) is
    
        Cursor schedule is
            Select service_time as sday, service_name AS sname, service_time AS stime, end_time AS etime
                FROM services s
                left join contracts c
                    on c.service_id = s.service_id
                WHERE trunc(service_time) > firstDate AND trunc(service_time) < secondDate
                ORDER BY service_time, stime;
    
                 v_name services.service_name%TYPE;
                 v_time services.service_time%TYPE;
                 v_etime services.end_time%TYPE;
                 v_day services.service_time%TYPE;
    
        BEGIN
           OPEN schedule;
           dbms_output.put_line(' - Service Schedule Report  - ');
           dbms_output.put_line( rpad('Date' , 25) || rpad('Service Name', 31) || rpad('Start Time', 14) || rpad('End Time', 14));
           dbms_output.put_line( rpad('----' , 25) || rpad('------------', 31) || rpad('----------', 14) || rpad('--------', 14));
           LOOP
              FETCH schedule INTO v_day, v_name, v_time, v_etime;
              EXIT WHEN schedule%NOTFOUND;
    
              dbms_output.put_line(  rpad(TO_CHAR( v_day, 'FmDay'),9) || ': ' || rpad(trunc(v_time), 10) || '    ' ||  rpad(v_name, 26) ||  '     '  || rpad(TO_CHAR(v_time, 'hh:mi a.m.'), 9) || '     ' || rpad(TO_CHAR(v_etime, 'hh:mi a.m.'), 10));
           END LOOP;
       CLOSE schedule;
    
    END WeeklySchedule;

    PROCEDURE AccountRecievable (firstdate DATE) AS
  Cursor accounts_recievable IS
    SELECT order_id, o.customer_id, balance, balance_paid, paid_in_full, s.service_time,deposit_amt
        FROM bishopdz.orders o
        JOIN bishopdz.customers c ON c.customer_id = o.customer_id
        JOIN bishopdz.contracts ct ON c.customer_id = ct.customer_id
        JOIN bishopdz.services s ON s.service_id = ct.service_id
        WHERE o.paid_in_full = 0
        order by o.customer_id, order_id;

         v_totalrecievable bishopdz.orders.balance%TYPE;
         v_order bishopdz.orders.order_id%TYPE;
         v_custID bishopdz.orders.customer_id%TYPE;
         v_serve_time bishopdz.services.service_time%TYPE;
         v_balance bishopdz.orders.balance%TYPE;
         v_balance_paid bishopdz.orders.balance_paid%TYPE;
         v_paid_in_full bishopdz.orders.paid_in_full%TYPE;
         v_deposit_amt bishopdz.contracts.deposit_amt%TYPE;


BEGIN
    OPEN accounts_recievable;
            LOOP
 FETCH accounts_recievable INTO v_order, v_custID, v_balance, v_balance_paid, v_paid_in_full,v_serve_time, v_deposit_amt;
                  EXIT WHEN accounts_recievable%NOTFOUND;


                    IF v_serve_time > add_months(firstDate,-1) THEN
                        dbms_output.put_line( 'Order: ' || v_order || ' is due this month.'  );
                        dbms_output.put_line( 'Customer: ' || v_custID || ' owes: ' || (v_balance - v_balance_paid));
                    elsif trunc(v_serve_time) < add_months(firstDate,-1) AND trunc(v_serve_time) > add_months(firstDate,-2) THEN
                        dbms_output.put_line( 'Order: ' || v_order || ' was due last month.' );
                        dbms_output.put_line( 'Customer: ' || v_custID || ' owes: ' || (v_balance - v_balance_paid));
                    elsif trunc(v_serve_time) < add_months(firstDate,-2) AND trunc(v_serve_time) > add_months(firstDate,-3) THEN 
                        dbms_output.put_line( 'Order: ' || v_order || ' was due two months ago.' );
                        dbms_output.put_line( 'Customer: ' || v_custID || ' owes: ' || (v_balance - v_balance_paid));
                    ELSE 
                        dbms_output.put_line( 'Order: ' || v_order || ' due over 3 months.' );
                        dbms_output.put_line( 'Customer: ' || v_custID || ' owes: ' || (v_balance - v_balance_paid));
                    END IF;
                        v_totalrecievable := v_totalrecievable + (v_balance - v_balance_paid);
                        dbms_output.put_line(' ');
                END LOOP;
                        dbms_output.put_line('Accounts recievable totals: ' || v_totalrecievable);

     CLOSE accounts_recievable;
END AccountRecievable;

    PROCEDURE ClientReport (fName varchar, lName varchar, comp_name varchar) is

       cursor c_name is
        
        select contract_id, cs.company_name, s.service_name, st.service_type, o.balance
            FROM customers cs
            JOIN contracts ct 
                ON cs.customer_id = ct.customer_id
            JOIN services s
                ON s.service_id = ct.service_id
            JOIN orders o
                on o.customer_id = cs.customer_id
            JOIN service_types st
                on st.service_type_id = s.service_type_id
            WHERE cs.company_name = comp_name
            FETCH FIRST ROW ONLY;
            
        com_rec c_name%rowtype;
        
       cursor c_null_name is
        
        select contract_id, cs.first_name, cs.last_name, s.service_name, st.service_type, o.balance
            FROM customers cs
            JOIN contracts ct 
                ON cs.customer_id = ct.customer_id
            JOIN services s
                ON s.service_id = ct.service_id
            JOIN orders o
                on o.customer_id = cs.customer_id
            JOIN service_types st
                on st.service_type_id = s.service_type_id
            WHERE cs.first_name = fname AND cs.last_name = lname
            order by contract_id desc
            FETCH FIRST ROW ONLY;
            
        cus_rec c_null_name%rowtype;
        
    BEGIN 
    
        IF comp_name IS NOT NULL THEN
            open c_name;
                fetch c_name into com_rec;
                IF comp_name = com_rec.company_name then
                    dbms_output.put_line(' - ' || 'CLIENT REPORT: COMPANY' ||' - ' );
                    dbms_output.put_line(rpad('Contract ID: ', 18)|| com_rec.contract_id);
                    dbms_output.put_line(rpad('Company Name: ', 18)|| comp_name);
                    dbms_output.put_line(rpad('Service Name: ', 18)|| com_rec.service_name);
                    dbms_output.put_line(rpad('Service Type: ', 18)|| com_rec.service_type);
                    dbms_output.put_line(rpad('Balance: ', 18)|| com_rec.balance);
                    dbms_output.put_line(' ');
                ELSE
                    dbms_output.put_line('No data');
                END IF;
            close c_name;
        ElsIf comp_name is null and fname is null and lname is null then
            dbms_output.put_line('Please use a valid search.');
        ELSE
            open c_null_name;
                fetch c_null_name into cus_rec;
                dbms_output.put_line(' - ' || 'CLIENT REPORT: INDIVIDUAL' ||' - ' );
                dbms_output.put_line(rpad('Contract ID: ', 18)|| cus_rec.contract_id);
                dbms_output.put_line(rpad('Full Name: ', 18)|| fname || ' ' || lname);
                dbms_output.put_line(rpad('Service Name: ', 18)|| cus_rec.service_name);
                dbms_output.put_line(rpad('Service Type: ', 18)|| cus_rec.service_type);
                dbms_output.put_line(rpad('Balance: ', 18)|| cus_rec.balance);
                dbms_output.put_line(' ');
            close c_null_name;
        END IF;
    
    END ClientReport;

    PROCEDURE PhotographerAvailability(fname varchar, lname varchar, the_date DATE) IS
      Cursor emp_avail IS 
    SELECT emp.emp_id, emp.first_name, emp.last_name, Eav.start_time, Eav.end_time
    FROM employees emp
    JOIN emp_availability Eav ON emp.emp_id = Eav.emp_id
    WHERE trunc(Eav.start_time) = the_date AND emp.first_name = fname AND emp.last_name = lname;

         v_empid employees.emp_id%TYPE;
         v_fname employees.first_name%TYPE;
         v_lname employees.last_name%TYPE;
         v_stime emp_availability.start_time%TYPE;
         v_etime emp_availability.end_time%TYPE;
    
    BEGIN
        OPEN emp_avail;
        
        FETCH emp_avail INTO v_empid, v_fname, v_lname, v_stime, v_etime;
                dbms_output.put_line(v_fname || ' ' || v_lname || ' is available: ');
                dbms_output.put_line(TO_CHAR(v_stime, 'hh:mi a.m.') || ' to ' || TO_CHAR(v_etime, 'hh:mi a.m.'));
        LOOP
            FETCH emp_avail INTO v_empid, v_fname, v_lname, v_stime, v_etime;
            EXIT WHEN emp_avail%NOTFOUND;
                    
            dbms_output.put_line(TO_CHAR(v_stime, 'hh:mi a.m.') || ' to ' || TO_CHAR(v_etime, 'hh:mi a.m.'));
                        
        END LOOP;
        
         CLOSE emp_avail;
    END PhotographerAvailability;

    PROCEDURE PopularLocations AS
        cursor loc is
        select l.city, l.state, count(s.location_id) as total
        from services s 
         join locations l
            on l.location_id = s.location_id
         left join service_types st
            on st.service_type_id = s.service_type_id
        group by l.city, l.state
        order by total desc;
        
        loc_rec loc%rowtype;
    
    BEGIN
            OPEN loc;
            
        dbms_output.put_line(' - Popular Locations - ');
        dbms_output.put_line( rpad('City' , 15) || rpad('State' , 15) || rpad('Total' , 15));
        dbms_output.put_line( rpad('----' , 15) || rpad('-----' , 15) || rpad('-----' , 15));
       LOOP
          FETCH loc INTO loc_rec;
          dbms_output.put_line(  rpad(loc_rec.city,15) || rpad(loc_rec.state, 15) || rpad(loc_rec.total, 15));
          EXIT WHEN loc%NOTFOUND;
    
       END LOOP;
       CLOSE loc;
    
    END PopularLocations;
END REPORTS;
/