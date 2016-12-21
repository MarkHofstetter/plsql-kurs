
  CREATE OR REPLACE FUNCTION "HR"."PARAM_NUMBER" 
(v_name in varchar2)
RETURN NUMBER  
result_cache relies_on (parameters)
as
  v_val_number number;
BEGIN
  select val_number into v_val_number
    from parameters 
    where name = v_name;
  RETURN v_val_number;  
END PARAM_NUMBER;
 
