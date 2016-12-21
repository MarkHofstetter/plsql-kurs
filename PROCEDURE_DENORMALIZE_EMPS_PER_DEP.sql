
  CREATE OR REPLACE PROCEDURE "HR"."DENORMALIZE_EMPS_PER_DEP" 
/* iteration über alle departements
mittels cursor, und auf jedem department
den parametrisierten cursor aufrufen.
Ausgabe: department_name: emp1;emp2;...

zusatz: wenn p_department_id gesetzt ist,
nur für dieses department (testfall)

+ umstellen der Tabelle emps_per_dep auf "normale" Tabelle
+ neues Feld in Tabelle vom Typ t_vc30 (emps_last_name_array)
+ und einfügen der Departments in dieses Spalte 
+ 

*/
  
  (p_department_id 
     in departments.department_id%type 
       default null)
  as
  cursor c_emps_per_dep
(cp_department_id departments.department_id%type)
  is select * from employees where   
    department_id = cp_department_id;
  
  emp_list_array t_vc30 := t_vc30();
  emp_list varchar2(1000);    
BEGIN
  
delete from emps_per_dep;  
for r_dep in (select * from departments) loop
  continue when (p_department_id is not null and
             r_dep.department_id <> p_department_id);          
  for r_emp in 
  c_emps_per_dep(r_dep.department_id) loop    
    emp_list := emp_list || r_emp.last_name || ';' ;
    emp_list_array.extend;
    emp_list_array(emp_list_array.last) := r_emp.last_name;
  end loop;
  dbms_output.put_line(r_dep.department_name||':'||emp_list);
  insert into emps_per_dep (
     department_name, 
     emps_last_name,
     emps_last_name_array
    ) values (
     r_dep.department_name,
     emp_list,
     emp_list_array
     );
    
  emp_list_array := t_vc30();   
  emp_list := null;
end loop;  
END DENORMALIZE_EMPS_PER_DEP;
 
