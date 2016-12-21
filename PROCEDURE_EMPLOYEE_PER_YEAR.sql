
  CREATE OR REPLACE PROCEDURE "HR"."EMPLOYEE_PER_YEAR" AS 
/* 
ermitteln das jahr wo der chronolisch erste 
employee angestellt wurde, analog den letzten

iterieren über alle Jahre

zählen pro jahr in der schleife wieviel angestellte
es in den jeweiligen jahren angestellt wurden
*/
v_year_min number;
v_year_max number;
v_c        number;
BEGIN
   select min(extract(year from (hire_date))),
          max(extract(year from (hire_date)))
            into v_year_min, v_year_max
     from emp;
     
   for i in v_year_min .. v_year_max loop
     select count(employee_id) into v_c
       from emp where 
       extract(year from hire_date) = i;
     dbms_output.put_line('Year: ' || i || 
                          ' Count: ' || v_c);
   end loop;
  
END EMPLOYEE_PER_YEAR;
 
