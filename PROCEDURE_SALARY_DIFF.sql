
  CREATE OR REPLACE PROCEDURE "HR"."SALARY_DIFF" AS 
/* über die nach salary geordnete Liste
aller emp gehen
und den Namen und das Gehalt 
und die Differenz zu VORHERIGEN Gehalt ausgeben

mit der funktion bonus den bonus berechnen
und auf das Gehalt des nächsthöheren limitieren
*/
cursor c_emp is 
  select * from emp
    order by salary desc ;

v_salary_prev number := 0;
v_diff        number := 0;

BEGIN
  
  for r_emp in c_emp loop
  v_diff := r_emp.salary - v_salary_prev;
  dbms_output.put_line(  r_emp.last_name || ' ' ||                         
                         r_emp.salary    || ' ' ||                         
                         v_diff);
  v_salary_prev := r_emp.salary;                        
  end loop;
  
END SALARY_DIFF;
 
