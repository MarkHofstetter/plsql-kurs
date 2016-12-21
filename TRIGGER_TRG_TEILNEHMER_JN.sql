
  CREATE OR REPLACE TRIGGER "HR"."TRG_TEILNEHMER_JN" 
for INSERT OR DELETE OR UPDATE ON TEILNEHMER 
compound trigger
-- declare 
v_typ teilnehmer_jn.tlnjn_typ%type;

before each row is
begin
  :new.tln_id := seq.nextval;
end before each row;

after each row is 
  begin
  if inserting then 
    v_typ := 'I';
  elsif updating then   
    v_typ := 'U';
  else 
    v_typ := 'D';
  end if;

  WRITE_TEILNEHMER_JN
   (p_tln_id         => coalesce(:new.tln_id,         :old.tln_id), 
    p_tln_name       => coalesce(:new.tln_name,       :old.tln_name), 
    p_tln_groesse    => coalesce(:new.tln_groesse,    :old.tln_groesse), 
    p_tln_geburtstag => coalesce(:new.tln_geburtstag, :old.tln_geburtstag), 
    p_jntyp          => v_typ
   );
  
END after each row;
end;
ALTER TRIGGER "HR"."TRG_TEILNEHMER_JN" ENABLE
 
