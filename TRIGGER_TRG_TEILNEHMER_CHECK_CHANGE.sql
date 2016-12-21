
  CREATE OR REPLACE TRIGGER "HR"."TRG_TEILNEHMER_CHECK_CHANGE" 
BEFORE INSERT OR DELETE OR UPDATE ON TEILNEHMER 
declare
  v number;
BEGIN
/* mit get_param(?) den wert fuer chg_teilnehmer lesen
   und falls der wert 0 ist einen zu deklarierenden Fehler 
   e_teilnehmer_locked (-20002) werfen
   */
  if param_number('chg_teilnehmer') = 0 then 
    raise pck_declarations.e_teilnehmer_locked;
  end if;
  
END;
ALTER TRIGGER "HR"."TRG_TEILNEHMER_CHECK_CHANGE" ENABLE
 
