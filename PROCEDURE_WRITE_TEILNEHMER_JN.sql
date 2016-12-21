
  CREATE OR REPLACE PROCEDURE "HR"."WRITE_TEILNEHMER_JN" 
(p_tln_id         teilnehmer.tln_id%type,
 p_tln_name       teilnehmer.tln_name%type,
 p_tln_groesse    teilnehmer.tln_groesse%type,
 p_tln_geburtstag teilnehmer.tln_geburtstag%type,
 p_jntyp          teilnehmer_jn.tlnjn_typ%type)
 as
 vt_ausbildung t_ausbildung := t_ausbildung();
 v_current timestamp := current_timestamp;
 v_tlnjn_id number;
BEGIN

for r_aus in (select aus_name 
                from ausbildungen 
                join teilnehmer_x_ausbildung 
                  on aus_id = txa_aus_id
               where  txa_tln_id = p_tln_id) 
              loop
   vt_ausbildung.extend;
   vt_ausbildung(vt_ausbildung.last) := r_aus.aus_name;
end loop;
               
insert into TEILNEHMER_JN (
   tlnjn_id,
   tlnjn_tln_id,
   tlnjn_tln_name,
   tlnjn_tln_groesse,
   tlnjn_tln_geburtstag,
   tlnjn_typ,
   tlnjn_ausbildung,
   tlnjn_valid_from
) values (
   seq.nextval,
   p_tln_id,
   p_tln_name,
   p_tln_groesse,
   p_tln_geburtstag,
   p_jntyp,
   vt_ausbildung,
   v_current
) returning tlnjn_id into v_tlnjn_id;
  
update TEILNEHMER_JN set tlnjn_valid_to = v_current
  where tlnjn_id = 
     (select max(tlnjn_id) from TEILNEHMER_JN
       where tlnjn_tln_id = p_tln_id and 
             tlnjn_valid_to is null and
             tlnjn_id != v_tlnjn_id
             );

END WRITE_TEILNEHMER_JN;
 
