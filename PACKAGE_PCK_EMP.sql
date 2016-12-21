
  CREATE OR REPLACE PACKAGE "HR"."PCK_EMP" AS 

  v_praefix varchar2(10) := 'emp';

  function get_emps_per_dep_as_table(
     p_department_name departments.department_name%type)
     RETURN t_vc30 pipelined;
  
  procedure calc_bonus;
  
  procedure calc_bonus(p_employee_id emp.employee_id%type);
  
  procedure calc_bonus(p_first_name emp.first_name%type,
                       p_last_name emp.last_name%type);
  
  procedure request_lock(p_employee_id emp.employee_id%type);
  
  procedure release_lock(p_employee_id emp.employee_id%type);
  
  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
  PROCEDURE UPSERT (
    p_first_name   emp.first_name%type,
    p_last_name   IN  emp.last_name%type,
    p_hire_date   IN  emp.hire_date%type 
      default sysdate,
    p_employee_id OUT emp.employee_id%type,
    p_salary      IN  emp.salary%type,
    p_department_name IN departments.department_name%type
  );

  procedure print_last_id;

END PCK_EMP;
CREATE OR REPLACE PACKAGE BODY "HR"."PCK_EMP" AS

  v_department_id emp.department_id%type;
  v_employee_id   emp.employee_id%type := null;
  
  cursor c_emp is 
     select * from emp 
     for update of bonus nowait;
     
     
  function get_emps_per_dep_as_table(
     p_department_name departments.department_name%type)
     RETURN t_vc30 pipelined
  as 
  begin
  for r_emp in (select last_name
                  from emp e join departments d
                    on e.department_id = d.department_id
                 where department_name = p_department_name) 
                 loop
          pipe row(r_emp.last_name);
  end loop;  
                      
  
  end;
     
  function allocate_lock(p_employee_id emp.employee_id%type)
  return varchar2 as 
    v_lock_handle varchar2(128);
  begin 
    dbms_lock.allocate_unique(
      v_praefix || p_employee_id,  -- lockname
      v_lock_handle,
      10                     --expiration_specs 
    );
    return v_lock_handle;
  end;
  
  procedure request_lock(p_employee_id emp.employee_id%type)
  as
  v_lock_handle varchar2(128);
  v_ret integer;
  begin
    v_lock_handle := allocate_lock(p_employee_id);
    dbms_output.put_line(v_lock_handle);
    
    v_ret := dbms_lock.request(
      lockhandle => v_lock_handle,
      -- lockmode   => dbms_lock.NL_MODE,
      timeout    => 1,
      release_on_commit => true
      );
    
    dbms_output.put_line(v_ret);   
    
  end;
  
  procedure release_lock(p_employee_id emp.employee_id%type)
  as
  v_ret integer;
  v_lock_handle varchar2(128);  
  begin
    v_lock_handle := allocate_lock(p_employee_id);
    dbms_output.put_line(v_lock_handle);
    v_ret := dbms_lock.release(lockhandle => v_lock_handle);
    dbms_output.put_line(v_ret);       
  end;
  
  procedure calc_bonus
  as  
  begin
  for r_emp in c_emp loop
    update emp set bonus = bonus(p_salary    => r_emp.salary,
                                 p_hire_date => r_emp.hire_date,
                 p_percent   => pck_declarations.v_bonus_percentage
                --p_percent   =>  param_number('bonus_perc')
                )
     where current of c_emp;
  end loop;
  
  /*
  update emp set bonus = bonus(p_salary    => r_emp.salary,
                                 p_hire_date => r_emp.hire_date,
                                 p_percent   => 0.05);
  */                                 
  end;

  procedure calc_bonus(p_employee_id emp.employee_id%type)
  as
  begin
    update emp set bonus = bonus(p_salary => salary,
                                 p_hire_date => hire_date,
                 p_percent   => pck_declarations.v_bonus_percentage)
                 where employee_id = p_employee_id;  
  end;
  
  procedure calc_bonus(p_first_name emp.first_name%type,
                       p_last_name emp.last_name%type)
  as
    v_employee_id emp.employee_id%type;
  begin
    select employee_id into v_employee_id 
      from emp 
     where first_name = p_first_name and
           last_name  = p_last_name;     
    calc_bonus(p_employee_id => v_employee_id);
  end;
  

  PROCEDURE UPSERT (
    p_first_name   emp.first_name%type,
    p_last_name   IN  emp.last_name%type,
    p_hire_date   IN  emp.hire_date%type 
      default sysdate,
    p_employee_id OUT emp.employee_id%type,
    p_salary      IN  emp.salary%type,
    p_department_name IN departments.department_name%type
  ) AS    
  BEGIN
  
  begin
  select department_id into v_department_id
    from departments where 
         department_name = p_department_name;
  exception when no_data_found then
    dbms_output.put_line('kein department '||  p_department_name);
--    raise_application_error(-20001, 
--                            p_department_name);
    raise pck_declarations.e_no_department_found;
  end;
  
  begin 
  select employee_id into v_employee_id 
    from emp
   where last_name = p_last_name and
         first_name = p_first_name;
  exception when no_data_found then        
    null;
  end;
  
  if v_employee_id is null then
    insert into emp (
      employee_id,
      first_name,
      last_name,
      hire_date,
      salary,
      department_id
    ) values (
      employees_seq.nextval,
      p_first_name,
      p_last_name,
      p_hire_date,
      p_salary,
      v_department_id
    ) returning employee_id into p_employee_id;
  else 
    update emp set
      last_name = p_last_name,
      salary    = p_salary,
      department_id = v_department_id
     where employee_id = v_employee_id;
     p_employee_id := v_employee_id;
  end if;  
END UPSERT;

procedure print_last_id 
as
begin
dbms_output.put_line(v_employee_id);
end;

begin -- package 'init'
  pck_declarations.v_bonus_percentage := param_number('bonus_perc');
END PCK_EMP;
 
