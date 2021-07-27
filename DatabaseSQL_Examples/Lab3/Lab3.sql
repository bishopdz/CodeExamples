/*
Name: Daniel Bishop
Created: 02/07/2019
Updated: 02/09/2019
*/
SET SERVEROUTPUT ON;

/* 1.)
Title: Employees per Department
Description: This report returns the number of employees in each department.
*/
DECLARE
    cursor c_employees is
    
    select NVL(department_name, 'No department') as department_name, count(*) as number_of_employees
    from hr.employees e
    full join hr.departments d
        on d.department_id = e.department_id 
    group by department_name;
    
    employee_rec c_employees%rowtype;
BEGIN
    open c_employees;

        loop
            fetch c_employees into employee_rec;
            
            exit when c_employees%notfound;
                dbms_output.put_line(rpad('Department Name: ', 17)|| rpad(employee_rec.department_name, 20) || ' | ' || rpad('Number of Employees: ', 21) || rpad(employee_rec.number_of_employees, 17));
        
        end loop;
    close c_employees;
END;
/


/* 2.)
Title: Department, Manager, City
Description: This report returns the manager and city of each department.
*/
DECLARE
    cursor c_employees is
    select department_name, NVL(first_name, 'N/A') as first, NVL(last_name, ' N/A') as last, city
    from hr.employees e 
    full join hr.departments d
        on d.manager_id = e.employee_id
    join hr.locations l
        on l.location_id = d.location_id;
    employee_rec c_employees%rowtype;
BEGIN
    open c_employees;
        
        while c_employees%isopen
        loop
            fetch c_employees into employee_rec;
            
            exit when c_employees%notfound;
                dbms_output.put_line(rpad('Department Name: ', 17)|| rpad(employee_rec.department_name, 21)|| ' | ' || rpad('Manager Name: ', 15)|| rpad(employee_rec.first, 10) || ' ' || rpad(employee_rec.last, 10) || ' | ' || rpad('City: ', 6) || rpad(employee_rec.city, 20));
        end loop;
    close c_employees;
END;
/


/* 3.)
Title: Average Salary per Department
Description: This report returns the city, country, and average salary for each department.
*/
DECLARE

    --salary_avg number;
    
    cursor c_dept is
    
    select NVL(country_name, 'No Country') as country, NVL(city, 'No City') as city, NVL(department_name, 'No Department') as department, round(avg(salary), 2) as avg_sal
    from hr.departments d
    full join hr.locations l
        on l.location_id = d.location_id
    full join hr.employees e
        on e.department_id = d.department_id
    join hr.countries c
        on c.country_id = l.country_id
    group by country_name, city, department_name;
    
    dept_rec c_dept%rowtype;
BEGIN
    open c_dept;
        
        while c_dept%isopen
        loop
            fetch c_dept into dept_rec;
            
            exit when c_dept%notfound;
                        
                if dept_rec.avg_sal <> 0 then
                    dbms_output.put_line(rpad('Department Name: ', 17) || rpad(dept_rec.department, 20) || ' | ' || rpad('City: ', 7) || rpad(dept_rec.city, 20) || ' | ' || rpad('Country Name: ', 14) || rpad(dept_rec.country, 24) || ' | ' || rpad('Average Salary: ', 16) || dept_rec.avg_sal);
                else
                    dbms_output.put_line(rpad('Department Name: ', 17) || rpad(dept_rec.department, 20) || ' | ' || rpad('City: ', 7) || rpad(dept_rec.city, 20) || ' | ' || rpad('Country Name: ', 14) || rpad(dept_rec.country, 24) || ' | ' || rpad('Average Salary: ', 16) || 'No Salary');
                end if;
        end loop;
    close c_dept;
END;
/


/* 4.)
Title: Salary Difference
Description: This report returns the employee name, manager name, and difference between the manager's and employee's salaries
                for each job title.
*/
DECLARE

    cursor c_emp is
    
    select job_title, concat(concat(e.first_name, ' '), e.last_name) as employee, concat(concat(m.first_name, ' '), m.last_name) as manager, e.salary, m.salary as m_salary
    from hr.employees e
    full join hr.jobs j 
        on j.job_id = e.job_id
    inner join employees m on m.employee_id = e.manager_id;
        
    emp_rec c_emp%rowtype;
BEGIN
    open c_emp;

        loop
            fetch c_emp into emp_rec;
            
            exit when c_emp%notfound;
            
                dbms_output.put_line(rpad('Job Title: ', 11)|| rpad(emp_rec.job_title, 34)|| ' | ' || rpad('Employee Name: ', 15)|| rpad(emp_rec.employee, 20) || ' | ' || rpad(' Manager Name: ', 15)|| rpad(emp_rec.manager, 20) || ' | ' || rpad('Salary Difference: ', 20) || (emp_rec.m_salary - emp_rec.salary));

        end loop;
    close c_emp;
END;
/


/* 5.)
Title: Employee Information
Description:  This report returns the last name, job title, salary, and commission percent for each employee, that has a commission.
*/
DECLARE

    cursor c_emp is
    
    select last_name, job_title, salary, NVL(commission_pct, '0') as commission_pct
    from hr.employees e
    left join hr.jobs j 
        on j.job_id = e.job_id;
   
    emp_rec c_emp%rowtype;
BEGIN
    open c_emp;
        
        while c_emp%isopen
        loop
            fetch c_emp into emp_rec;
            
            exit when c_emp%notfound;
            
            if emp_rec.commission_pct <> 0 then
                dbms_output.put_line(rpad('Employee Last Name:', 20)|| rpad(emp_rec.last_name, 14)|| ' | ' || rpad('Job Title:', 11) || rpad(emp_rec.job_title, 22) || ' | ' ||  'Salary: ' || rpad(emp_rec.salary, 12) || ' | ' || rpad('Commission Percent: ', 20)|| emp_rec.commission_pct);     
            end if;
                
        end loop;
    close c_emp;
END;
/


/* 6.)
Title: Employee and Manager Hire Dates
Description: This report returns the hire date for each employee and the hire date for each manager who was hired after an the employee.
*/
DECLARE

    cursor c_emp is
    
    select concat(concat(e.first_name, ' '), e.last_name) as employee, e.hire_date, concat(concat(m.first_name, ' '), m.last_name) as manager, m.hire_date as m_date
    from hr.employees e
    inner join employees m on m.employee_id = e.manager_id;   
        
    emp_rec c_emp%rowtype;
BEGIN
    open c_emp;

        loop
            fetch c_emp into emp_rec;
            
            exit when c_emp%notfound;
            
            if emp_rec.m_date > emp_rec.hire_date then
                dbms_output.put_line(rpad('Employee Name: ', 16)|| rpad(emp_rec.employee, 20) || ' | ' || rpad('Employee Hire Date: ', 20) || rpad(emp_rec.hire_date, 20) ||  ' | ' || rpad('Manager Name: ', 15)|| rpad(emp_rec.manager, 20) || ' | ' || rpad('Manager Hire Date: ', 20) || emp_rec.m_date);
            else
                dbms_output.put_line(rpad('Employee Name: ', 16)|| rpad(emp_rec.employee, 20) || ' | ' || rpad('Employee Hire Date: ', 20) || rpad(emp_rec.hire_date, 20) ||  ' | ' || rpad('Manager Name: ', 15)|| rpad(emp_rec.manager, 20) || ' | ' || rpad('Manager Hire Date: ', 20) || 'Before Employee');
            end if;
            
        end loop;
    close c_emp;
END;
/


/* 7.)
Title: Departments with Commission Information
Description: This report returns the average, maximum, minimum, and number of employees for each department that pays commission.
*/
DECLARE
    cursor c_dept is
    
    select department_name, round(avg(salary), 2) as avg_sal, max(salary) as max_sal, min(salary) as min_sal, count(employee_id) as e_count
    from hr.departments d
    full join hr.employees e
        on e.department_id = d.department_id
    where commission_pct is not null and d.department_id is not null
    group by department_name;
        
    dept_rec c_dept%rowtype;
BEGIN
    open c_dept;
        
        while c_dept%isopen
        loop
            fetch c_dept into dept_rec;
            
            exit when c_dept%notfound;
            
                dbms_output.put_line(rpad('Department Name: ', 17)|| rpad(dept_rec.department_name, 8)|| ' | ' || rpad('Average Salary: ', 16)|| rpad(dept_rec.avg_sal, 10) || ' | ' || rpad('Maximum Salary: ', 15)|| rpad(dept_rec.max_sal, 8) || ' | ' || rpad('Minimum Salary: ', 16)|| rpad(dept_rec.min_sal, 8) || ' | ' || rpad('Number of Employees: ', 21)|| rpad(dept_rec.e_count, 17));
        
        end loop;
    close c_dept;
END;
/


/* 8.)
Title: Department Hiring Information
Description: This report returns the month, year, and number of employees hired that month per department.
*/
DECLARE
    cursor c_dept is
    
    select NVL(department_name, 'No Department') as department_name, extract(year from hire_date) as yy, extract(month from hire_date) as mm, count(employee_id) as e_count
    from hr.employees e 
    full join hr.departments d
        on d.department_id = e.department_id
    group by department_name, extract(year from hire_date), extract(month from hire_date)
    order by yy, mm, d.department_name, e_count;
          
    dept_rec c_dept%rowtype;
BEGIN
    open c_dept;
        
        while c_dept%isopen
        loop
            fetch c_dept into dept_rec;
            
            exit when c_dept%notfound;
            
                dbms_output.put_line(rpad('Department Name: ', 17)|| rpad(dept_rec.department_name, 22)|| ' | ' || rpad('Month of Hire: ', 15)|| rpad(dept_rec.mm, 4) || ' | ' || rpad('Year of Hire: ', 15)|| rpad(dept_rec.yy, 8) || ' | ' || rpad('Number of Employees Hired: ', 20) || dept_rec.e_count);
            
        end loop;
    close c_dept;
END;
/


/* 9.)
Title: Customer Skill Level
Description: This report returns the name, email, and half-pipe rating(skill rating) of each person, if they have a rating of at least 5.
*/
DECLARE
    stars varchar(10) := '';
    cursor c_allp is
    
    select concat(concat(lastname, ', '),firstname) as name, email, skilllevel
    from allpowder.customer c
    full join allpowder.customerskill s
        on s.customerid = c.customerid
    where skilllevel >= 5 and style = 'Freestyle'
    order by name;

    allp_rec c_allp%rowtype;
BEGIN
    open c_allp;
        
        while c_allp%isopen
        loop
        
            fetch c_allp into allp_rec;
            
            exit when c_allp%notfound;
            
            case
                when allp_rec.skilllevel = '5' then stars := '*****';
                when allp_rec.skilllevel = '6' then stars := '******';
                when allp_rec.skilllevel = '7' then stars := '*******';
                when allp_rec.skilllevel = '8' then stars := '********';
                when allp_rec.skilllevel = '9' then stars := '*********';
                when allp_rec.skilllevel = '10' then stars := '**********';
                else stars := 'Rating Error';
            end case;
            
            dbms_output.put_line(rpad('Name: ', 8)|| rpad(allp_rec.name, 22));
            dbms_output.put_line(rpad('Email: ', 8)|| allp_rec.email);
            dbms_output.put_line(rpad('Freestyle Rating: ', 18)|| rpad(stars, 17));
            dbms_output.put_line(' ');
            
        end loop;
    close c_allp;
END;
/

/* 10.)
Title: Style Statistics
Description: This report returns the minimum, maximum, and avgerage skill level for each style.
*/
DECLARE
cursor c_allp is

    select style, min(skilllevel) as min_num, max(skilllevel) as max_num, round(avg(skilllevel), 2) as avg_num
    from allpowder.customerskill
    group by style;
    
    allp_rec c_allp%rowtype;

BEGIN
    open c_allp;

        loop
            fetch c_allp into allp_rec;
            
            exit when c_allp%notfound;
            
                dbms_output.put_line(rpad('Style: ', 8)|| rpad(allp_rec.style, 25)|| ' | ' || rpad('Minimum Skill Level: ', 21)|| allp_rec.min_num || ' | ' || rpad('Maximum Skill Level: ', 21)|| allp_rec.max_num || ' | ' || 'Average Skill Level: ' || allp_rec.avg_num);
                
        end loop;
    close c_allp;
END;
/

