
  CREATE OR REPLACE FUNCTION "HR"."TRY_TO_NUMBER" 
(p_val in varchar2)
RETURN NUMBER AS 
  v_number number;
BEGIN
  v_number := to_number(p_val);
  return v_number;
  exception
  when VALUE_ERROR then     
   RETURN 0;  
END TRY_TO_NUMBER;
 
