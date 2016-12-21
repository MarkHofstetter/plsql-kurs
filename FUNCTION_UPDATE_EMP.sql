
  CREATE OR REPLACE FUNCTION "HR"."UPDATE_EMP" 
(p_last_name varchar2)
RETURN number AS 
BEGIN
  update emp set salary = salary +400
    where last_name = p_last_name;
  
  return 0;
END UPDATE_EMP;
 
