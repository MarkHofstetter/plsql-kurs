
  CREATE OR REPLACE FUNCTION "HR"."BONUS" 
  (p_salary in employees.salary%type,
   p_percent in number default 0.1,
   p_hire_date in employees.hire_date%type
   ) 
RETURN NUMBER  AS 
  v_bonus number;
BEGIN
  v_bonus := p_salary * p_percent;
  if p_salary < param_number('bonus_threshold') then
    v_bonus := v_bonus + 100;  
  end if;
  
  if p_hire_date < 
     sysdate - to_yminterval('10-0') then
    v_bonus := v_bonus + 1000;
  end if;
  
  RETURN v_bonus;
END BONUS;
 
