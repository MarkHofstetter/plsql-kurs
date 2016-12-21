
  CREATE OR REPLACE TRIGGER "HR"."TRG_CHK_MAX_AUS_PER_TLN" 
BEFORE INSERT OR UPDATE ON TEILNEHMER_X_AUSBILDUNG 
FOR EACH ROW 
declare 
  pragma autonomous_transaction;
  v_count number;
BEGIN
-- wenn die zahl der ausbildung x überschreitet 
-- dann e_too_much_education
  select count(txa_id) into v_count 
    from TEILNEHMER_X_AUSBILDUNG
   where txa_tln_id = :new.txa_tln_id;
   
   dbms_output.put_line(v_count);
  rollback;  
END;
ALTER TRIGGER "HR"."TRG_CHK_MAX_AUS_PER_TLN" ENABLE
 
