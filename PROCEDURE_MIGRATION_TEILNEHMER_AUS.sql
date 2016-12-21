
  CREATE OR REPLACE PROCEDURE "HR"."MIGRATION_TEILNEHMER_AUS" AS 
v_aus_id ausbildungen.aus_id%type;
BEGIN
  for r_emp in (select * from teilnehmer) loop   
    for i in 
       r_emp.tln_ausbildung.first .. r_emp.tln_ausbildung.last 
       loop
       
       begin
         select aus_id into v_aus_id from ausbildungen 
           where aus_name = r_emp.tln_ausbildung(i);
         exception when no_data_found then 
           insert into ausbildungen (
             aus_id,
             aus_name
           ) values (
            seq.nextval,
            r_emp.tln_ausbildung(i)  
          ) returning aus_id into v_aus_id;
       end; 
       insert into teilnehmer_x_ausbildung (
          txa_id,
          txa_tln_id,
          txa_aus_id
          ) values (
          seq.nextval,
          r_emp.tln_id,
          v_aus_id
          );
         
       dbms_output.put_line(r_emp.tln_ausbildung(i));
    end loop;  
    
       
  end loop;
END MIGRATION_TEILNEHMER_AUS;

   /* for edu in (select column_value e
                from table(r_emp.tln_ausbildung)) loop
       dbms_output.put_line(edu.e);
    end loop;
   */
 
