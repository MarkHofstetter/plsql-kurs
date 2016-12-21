
  CREATE OR REPLACE TRIGGER "HR"."TRG_V_EMP_DEP_DML" 
INSTEAD OF INSERT OR DELETE OR UPDATE ON V_EMP_DEP 
for each row
BEGIN
  if inserting then 
    insert into emp (
      employee_id,
      first_name,
      last_name,
      hire_date,
      department_id
    ) values (
      seq.nextval,
      :new.first_name,
      :new.last_name,
      sysdate,
      (select department_id from departments
        where department_name = :new.department_name)
    );
  end if;
END;
ALTER TRIGGER "HR"."TRG_V_EMP_DEP_DML" ENABLE
 
