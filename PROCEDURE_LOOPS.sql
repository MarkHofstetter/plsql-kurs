
  CREATE OR REPLACE PROCEDURE "HR"."LOOPS" AS 
  k number := 0;
BEGIN
  while k < 3 loop
    dbms_output.put_line(k);
    k := k + 1;
  end loop;
  
  loop
    k := k - 1;
    dbms_output.put_line(k);
    exit when k <= 0;
  end loop;
  
  for bumsti in 1..5 loop
    dbms_output.put_line(bumsti);
  end loop;
  

END LOOPS;
 
