
  CREATE OR REPLACE PROCEDURE "HR"."DENORMALIZE_JOBS_PER_EMP" 
  
  (p_employee_id 
     in employees.employee_id%type default null)
  as
  cursor c_jobs_per_employee
    (cp_employee_id employees.employee_id%type)
  is select * from job_history where   
    employee_id = cp_employee_id;
BEGIN
  NULL;
END DENORMALIZE_JOBS_PER_EMP;
 
