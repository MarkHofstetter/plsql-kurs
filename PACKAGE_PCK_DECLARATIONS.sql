
  CREATE OR REPLACE PACKAGE "HR"."PCK_DECLARATIONS" AS 

-- v_bonus_percentage constant number := 0.05;

v_bonus_percentage number;

e_no_department_found exception;
pragma exception_init (e_no_department_found, -20001);

e_teilnehmer_locked exception;
pragma exception_init (e_teilnehmer_locked, -20002);

END PCK_declarations;

 
