
  CREATE OR REPLACE FUNCTION "HR"."ROWS_IN_TABLE" 
  (p_table_name varchar2)
RETURN NUMBER AS 
  v_count number; 
  v_sql varchar2(1000);
BEGIN
  
  v_sql := 'select count(*) from '||p_table_name;  
  execute immediate v_sql into v_count;
  
  return v_count;
  
END ROWS_IN_TABLE;
 
