
  CREATE OR REPLACE FUNCTION "HR"."GET_EMPLOYEE_ID_BY_FULLNAME" 
 
 (p_first_name in employees.first_name%type,
  p_last_name  in employees.last_name%type)
 RETURN NUMBER AS 
 v_employee_id employees.employee_id%type;
BEGIN
  select employee_id into v_employee_id
    from employees
   where first_name = p_first_name
     and last_name  = p_last_name;
     
  RETURN v_employee_id;
END GET_EMPLOYEE_ID_BY_FULLNAME;
 
