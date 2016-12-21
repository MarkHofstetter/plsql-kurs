
  CREATE OR REPLACE FORCE VIEW "HR"."V_EMP_DEP" ("FIRST_NAME", "LAST_NAME", "DEPARTMENT_NAME") AS 
  (
select first_name,
       last_name,
       department_name
  from departments d right join emp e 
    on d.department_id = e.department_id
)
 
