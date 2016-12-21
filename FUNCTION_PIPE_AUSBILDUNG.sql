
  CREATE OR REPLACE FUNCTION "HR"."PIPE_AUSBILDUNG" RETURN 
t_ausbildung pipelined
AS 
BEGIN
for r_tln in (select * from teilnehmer) loop
  pipe row(r_tln.tln_name);
end loop;

END PIPE_AUSBILDUNG;
 
