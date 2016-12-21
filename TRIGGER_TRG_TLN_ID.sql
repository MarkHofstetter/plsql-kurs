
  CREATE OR REPLACE TRIGGER "HR"."TRG_TLN_ID" 
BEFORE INSERT ON TEILNEHMER 
FOR EACH ROW 
BEGIN
  if :new.tln_id is null then   
    :new.tln_id := seq.nextval;  
  end if;
END;
ALTER TRIGGER "HR"."TRG_TLN_ID" ENABLE
 
