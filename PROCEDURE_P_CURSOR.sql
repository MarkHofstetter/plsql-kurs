
  CREATE OR REPLACE PROCEDURE "HR"."P_CURSOR" AS 

 cursor c_emp is 
  select *
    from emp
         order by salary;

-- r_emp c_emp%rowtype;

BEGIN
  
  for r_emp in c_emp loop
 -- for r_emp in ( select * from emp order by salary
 --   ) loop
    dbms_output.put_line(c_emp%rowcount || ' ' ||
                         r_emp.last_name || ' ' ||
                         r_emp.salary);
  end loop;

  
  
END P_CURSOR;
 
