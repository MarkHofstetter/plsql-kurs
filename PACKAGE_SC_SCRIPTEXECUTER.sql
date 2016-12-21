
  CREATE OR REPLACE PACKAGE "HR"."SC_SCRIPTEXECUTER" IS

function getVersion return number;

function getDDL(in_schema_cd varchar2,in_type_cd varchar2,in_name_tx varchar2) return clob;

END;
CREATE OR REPLACE PACKAGE BODY "HR"."SC_SCRIPTEXECUTER" IS

function getVersion return number is
begin
  return 0;
end;

function getDDL(in_schema_cd varchar2, in_type_cd varchar2, in_name_tx varchar2) return clob is
  v_cl clob;
  v_originalDDL_cl clob;
  v_type_cd varchar2(200);
  v_regExpSpecialChars_tx varchar2(255) := '([][)(}{.$*+?,|^\])';
begin

    if in_type_cd='PACKAGE BODY' then
      v_type_cd:='PACKAGE';
    elsif in_type_cd='TYPE BODY' then
      v_type_cd:='TYPE';
    else
      v_type_cd:=in_type_cd;
    end if;

    if in_type_cd = 'TRIGGER'  then
      dbms_metadata.set_transform_param(dbms_metadata.session_transform,'SQLTERMINATOR',true);
    else
      dbms_metadata.set_transform_param(dbms_metadata.session_transform,'SQLTERMINATOR',false);
    end if;

    if in_type_cd='PACKAGE' then
      dbms_metadata.set_transform_param(dbms_metadata.session_transform,'SPECIFICATION',true);
      dbms_metadata.set_transform_param(dbms_metadata.session_transform,'BODY',false);
    end if;

    if in_type_cd='TYPE' then
      dbms_metadata.set_transform_param(dbms_metadata.session_transform,'SPECIFICATION',true);
      dbms_metadata.set_transform_param(dbms_metadata.session_transform,'BODY',false);
    end if;

    if in_type_cd='PACKAGE BODY' then
      dbms_metadata.set_transform_param(dbms_metadata.session_transform,'SPECIFICATION',false);
      dbms_metadata.set_transform_param(dbms_metadata.session_transform,'BODY',true);
    end if;

    if in_type_cd='TYPE BODY' then
      dbms_metadata.set_transform_param(dbms_metadata.session_transform,'SPECIFICATION',false);
      dbms_metadata.set_transform_param(dbms_metadata.session_transform,'BODY',true);
    end if;


    v_originalDDL_cl := dbms_metadata.get_ddl(v_type_cd, in_name_tx,in_schema_cd);
    v_cl := v_originalDDL_cl;

    -- remove schema name...
    v_cl := regexp_replace(v_cl,regexp_replace(upper('"'|| in_schema_cd ||'"."'||in_name_tx||'"'), v_regExpSpecialChars_tx, '\\\1'),'#{sc.schema}.'||upper(in_name_tx), 1, 1, 'i');

    -- strange bug in XE-Vista-ibrahim
    -- regexp_replace returns null in PLSQL but works fine in SQL
    if v_cl is null or dbms_lob.getlength(v_cl) < 10 then
      begin
        select regexp_replace(v_originalDDL_cl,regexp_replace(upper('"'|| in_schema_cd ||'"."'||in_name_tx||'"'), v_regExpSpecialChars_tx, '\\\1'),'#{sc.schema}.'||upper(in_name_tx), 1, 1, 'i')
          into v_cl
        from dual;
      exception
        when no_data_found then
          null;
      end;
    end if;

    if in_type_cd = 'TRIGGER' then
      v_cl:= dbms_lob.substr(v_cl,dbms_lob.instr(v_cl,'/'||chr(10)||'ALTER TRIGGER')-1,1);
    elsif in_type_cd = 'SYNONYM' then
      v_cl:= replace(replace(v_cl, upper('"'|| in_schema_cd ||'".'), '#{sc.schema}.'), '"', '');
    end if;
    -- trim for convenience
    v_cl := rtrim(rtrim(v_cl),chr(10));
    v_cl := ltrim(ltrim(v_cl,chr(10)));
  return v_cl;
exception
  when others then
    return v_cl;
end;


END;
 
