
  CREATE OR REPLACE PROCEDURE "HR"."ADD_AUSBILDUNG" 
(p_tln_name teilnehmer.tln_name%type,
 p_ausbildung varchar2)
AS
  vt_ausbildung t_ausbildung := t_ausbildung();
BEGIN
  select tln_ausbildung into vt_ausbildung 
    from teilnehmer
   where tln_name = p_tln_name;
  
 /*
  for i in vt_ausbildung.first .. vt_ausbildung.last loop
    dbms_output.put_line(i || ' ' ||vt_ausbildung(i));
  end loop;
 */ 
  vt_ausbildung.extend;
  vt_ausbildung(vt_ausbildung.last) := p_ausbildung;
  dbms_output.put_line(vt_ausbildung(vt_ausbildung.last));
  
  update teilnehmer
     set tln_ausbildung = vt_ausbildung     
   where tln_name = p_tln_name;
 
END ADD_AUSBILDUNG;
 
