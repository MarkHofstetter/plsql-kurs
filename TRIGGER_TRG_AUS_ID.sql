
  CREATE OR REPLACE TRIGGER "HR"."TRG_AUS_ID" 
   before insert or update on "HR"."AUSBILDUNGEN" 
   for each row 
begin  
   if inserting then 
      :NEW."AUS_ID" := SEQ.nextval;         
      :new.aus_created := current_timestamp;
   elsif updating then
      :new.aus_updated := current_timestamp; 
      :new.aus_created := :old.aus_created;
   end if;
   
end;
ALTER TRIGGER "HR"."TRG_AUS_ID" ENABLE
 
