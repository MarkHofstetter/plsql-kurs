
  CREATE OR REPLACE PROCEDURE "HR"."EXPORT_OBJECTS" 
(p_object_name varchar2 default null,
 p_object_type varchar2 default null
)
AS 
  v_filehandle utl_file.file_type;
  v_filename   varchar2(200);
  v_ddl        varchar2(30000);
BEGIN
/*
entweder:
+ vom übergebenen OBJECT die DDL in eine gleichnamige Datei ausgeben
oder
+ über alle user objects gehen und ebenfalls DDL in datei ausgeben
*/
  for r in (select object_name,
                       object_type
                  from user_objects where status = 'VALID' and
                  object_type = 'PROCEDURE') 
                  loop
  
  v_filehandle := utl_file.fopen('DATA_DIR', 
    r.object_type||'_'||r.object_name||'.sql', 'w');
  
  begin 
  v_ddl := SYS.dbms_metadata.get_ddl( r.object_type, r.object_name);
  exception
    when others then
      v_ddl := SQLERRM;
  end;    
  utl_file.putf(v_filehandle, v_ddl);
  utl_file.fclose(v_filehandle);
  end loop;
 
END EXPORT_OBJECTS;
 
