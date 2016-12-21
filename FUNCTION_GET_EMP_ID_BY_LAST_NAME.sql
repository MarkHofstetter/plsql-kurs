
  CREATE OR REPLACE FUNCTION "HR"."GET_EMP_ID_BY_LAST_NAME" 

(p_last_name employees.last_name%type)
RETURN NUMBER AS 
v_employee_id employees.employee_id%type;
BEGIN
   select employee_id 
    into v_employee_id
    from employees
   where last_name = p_last_name;  
   return v_employee_id;
   
   exception 
     when too_many_rows then
       return -1;   
     
END GET_EMP_ID_BY_LAST_NAME;
 
