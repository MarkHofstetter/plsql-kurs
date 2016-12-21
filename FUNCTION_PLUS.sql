
  CREATE OR REPLACE FUNCTION "HR"."PLUS" 
  (p_add1 in number,
   p_add2 in number)
RETURN NUMBER AS 
  v_sum number;
BEGIN
/* 
   hier
   ein 
   mehrzeiliger
   Kommentar   
*/

  -- summme
  v_sum := p_add1 + p_add2;
  
  RETURN v_sum;
END PLUS;
 
