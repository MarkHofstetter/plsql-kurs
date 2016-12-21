
  CREATE TABLE "HR"."EMPS_PER_DEP" 
   (	"DEPARTMENT_NAME" VARCHAR2(30), 
	"EMPS_LAST_NAME" VARCHAR2(1000), 
	"EMPS_LAST_NAME_ARRAY" "HR"."T_VC30" 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" 
 NESTED TABLE "EMPS_LAST_NAME_ARRAY" STORE AS "T_EMPS_LAST_NAME"
 (PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ) RETURN AS VALUE
 
