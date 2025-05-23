--------------------------- ESTRATÉGIA SEQUENCES ---------------------------

-- Na PHO, pegar os valores

SELECT sequence_name, last_number
FROM all_sequences
WHERE sequence_owner = 'SAFEPAY_ADM'
AND sequence_name in ('SQ_PERCRECOVERY_IDT', 'SQ_PERCRECOVERY_USER_IDT');

-- no PDBDEBITSCHEDULE

DROP SEQUENCE DEBITSCHEDULE_ADM.SQ_PERCRECOVERY_IDT;
DROP SEQUENCE DEBITSCHEDULE_ADM.SQ_PERCRECOVERY_USER_IDT;

CREATE SEQUENCE DEBITSCHEDULE_ADM.SQ_PERCRECOVERY_IDT START WITH <NUMERO PHO + 1> INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 10;
CREATE SEQUENCE DEBITSCHEDULE_ADM.SQ_PERCRECOVERY_USER_IDT START WITH <NUMERO PHO + 1> INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 10;

GRANT SELECT ON DEBITSCHEDULE_ADM.SQ_PERCRECOVERY_IDT TO DEBITSCHEDULEUBR,RL_COMPLIANCE_NSA;
GRANT SELECT ON DEBITSCHEDULE_ADM.SQ_PERCRECOVERY_USER_IDT TO DEBITSCHEDULEUBR,RL_COMPLIANCE_NSA;


-- Rollback da PHO

--> Pegar o valor da sequence no PDBDEBITSCHEDULE

SELECT sequence_name, last_number
FROM all_sequences
WHERE sequence_owner = 'DEBITSCHEDULE_ADM'
AND sequence_name in ('SQ_PERCRECOVERY_IDT', 'SQ_PERCRECOVERY_USER_IDT');

--> Pegar o valor da sequence na PHO

SELECT sequence_name, last_number
FROM all_sequences
WHERE sequence_owner = 'SAFEPAY_ADM'
AND sequence_name in ('SQ_PERCRECOVERY_IDT', 'SQ_PERCRECOVERY_USER_IDT');

-- Fazer o cálculo da diferença 

-- Executar script abaixo, se for uma quantia pequena
SELECT sequence_name, last_number
FROM all_sequences
WHERE sequence_owner = 'SAFEPAY_ADM'
AND sequence_name in ('SQ_PERCRECOVERY_IDT', 'SQ_PERCRECOVERY_USER_IDT');

SET SERVEROUTPUT ON
DECLARE

V_INICIAL_PERCRECOVERY      NUMBER(20) := 1;
V_FINAL_PERCRECOVERY        NUMBER(20) := 3;--<VALOR_DIFERENCA_PDBDEBITSCHEDULE_PHO_SQ_PERCRECOVERY_IDT>;
V_PERCRECOVERY_IDT          NUMBER(20) := NULL;

V_INICIAL_PERCRECOVERY_USER NUMBER(20) := 1;
V_FINAL_PERCRECOVERY_USER   NUMBER(20) := 3;--<VALOR_DIFERENCA_PDBDEBITSCHEDULE_PHO_SQ_PERCRECOVERY_USER_IDT>;
V_PERCRECOVERY_USER_IDT     NUMBER(20) := NULL;

BEGIN

-- SQ_PERCRECOVERY_IDT

 WHILE V_INICIAL_PERCRECOVERY <= V_FINAL_PERCRECOVERY LOOP
 
   SELECT SAFEPAY_ADM.SQ_PERCRECOVERY_IDT.NEXTVAL 
   INTO V_PERCRECOVERY_IDT 
   FROM DUAL;
   
   DBMS_OUTPUT.PUT_LINE('SQ_PERCRECOVERY_IDT: '|| TO_CHAR(V_PERCRECOVERY_IDT));
   
   V_INICIAL_PERCRECOVERY := V_INICIAL_PERCRECOVERY + 1;   
 
 END LOOP;
  
-- SQ_PERCRECOVERY_USER_IDT  
  
 WHILE V_INICIAL_PERCRECOVERY_USER <= V_FINAL_PERCRECOVERY_USER LOOP
 
   SELECT SAFEPAY_ADM.SQ_PERCRECOVERY_IDT.NEXTVAL 
   INTO V_PERCRECOVERY_USER_IDT 
   FROM DUAL;
   
   DBMS_OUTPUT.PUT_LINE('V_PERCRECOVERY_USER_IDT: '|| TO_CHAR(V_PERCRECOVERY_USER_IDT));
   
   V_INICIAL_PERCRECOVERY_USER := V_INICIAL_PERCRECOVERY_USER + 1;   
 
 END LOOP;

END;
/

SELECT sequence_name, last_number
FROM all_sequences
WHERE sequence_owner = 'SAFEPAY_ADM'
AND sequence_name in ('SQ_PERCRECOVERY_IDT', 'SQ_PERCRECOVERY_USER_IDT');



-- se for uma quantia grande

-- Na PDBDEBITSCHEDULE, pegar os valores

SELECT sequence_name, last_number
FROM all_sequences
WHERE sequence_owner = 'DEBITSCHEDULE_ADM'
AND sequence_name in ('SQ_PERCRECOVERY_IDT', 'SQ_PERCRECOVERY_USER_IDT');

-- na PHO

DROP SEQUENCE SAFEPAY_ADM.SQ_PERCRECOVERY_IDT;
DROP SEQUENCE SAFEPAY_ADM.SQ_PERCRECOVERY_USER_IDT;

CREATE SEQUENCE SAFEPAY_ADM.SQ_PERCRECOVERY_IDT START WITH <NUMERO PDBDEBITSCHEDULE + 1> INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 10;
CREATE SEQUENCE SAFEPAY_ADM.SQ_PERCRECOVERY_USER_IDT START WITH <NUMERO PDBDEBITSCHEDULE + 1> INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 10;

GRANT SELECT ON SAFEPAY_ADM.SQ_PERCRECOVERY_IDT TO DEBITSCHEDULEUBR,CAYMANUBR;
GRANT SELECT ON SAFEPAY_ADM.SQ_PERCRECOVERY_USER_IDT TO DEBITSCHEDULEUBR,CAYMANUBR;
