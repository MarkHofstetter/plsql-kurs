
  CREATE OR REPLACE TRIGGER "HR"."TRG_CHECK_NAME" 
BEFORE ALTER OR CREATE ON HR.SCHEMA 
BEGIN
  dbms_output.put_line(ora_sysevent     ||' '||
                       ora_dict_obj_name||' '||
                       ora_dict_obj_type);
                       
  if ora_dict_obj_type = 'TABLE' and
     not regexp_like(ora_dict_obj_name, '^\w{3}_')
  then 
     raise_application_error(-20100, 'wrong table name');
  end if;
     
END;
ALTER TRIGGER "HR"."TRG_CHECK_NAME" DISABLE
 
