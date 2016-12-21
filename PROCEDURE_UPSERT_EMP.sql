
  CREATE OR REPLACE PROCEDURE "HR"."UPSERT_EMP" 
 
/* salary und department_name übergeben

*/

(
  p_first_name   emp.first_name%type,
  p_last_name   IN  emp.last_name%type,
  p_hire_date   IN  emp.hire_date%type 
     default sysdate,
  p_employee_id OUT emp.employee_id%type,
  p_salary      IN  emp.salary%type,
  p_department_name IN departments.department_name%type
  )
   authid definer -- vs current_user
AS 
v_department_id emp.department_id%type;
v_employee_id   emp.employee_id%type := null;
BEGIN
select department_id into v_department_id
  from departments where 
       department_name = p_department_name;

begin 
select employee_id into v_employee_id 
  from emp
 where last_name = p_last_name and
       first_name = p_first_name;
exception when no_data_found then        
  null;
end;

if v_employee_id is null then
  insert into emp (
    employee_id,
    first_name,
    last_name,
    hire_date,
    salary,
    department_id
  ) values (
    employees_seq.nextval,
    p_first_name,
    p_last_name,
    p_hire_date,
    p_salary,
    v_department_id
  ) returning employee_id into p_employee_id;
else 
  update emp set
    last_name = p_last_name,
    salary    = p_salary,
    department_id = v_department_id
   where employee_id = v_employee_id;
   p_employee_id := v_employee_id;
end if;  
  
END UPSERT_EMP;
 
