
  CREATE OR REPLACE FORCE VIEW "HR"."V_EMP" ("EMPLOYEE_ID", "FIRST_NAME", "LAST_NAME", "HIRE_DATE", "SALARY", "DEPARTMENT_ID", "BONUS") AS 
  (select "EMPLOYEE_ID","FIRST_NAME","LAST_NAME","HIRE_DATE","SALARY","DEPARTMENT_ID","BONUS" from emp)
 