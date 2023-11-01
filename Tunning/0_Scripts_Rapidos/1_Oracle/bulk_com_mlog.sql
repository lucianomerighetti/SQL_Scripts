SET SERVEROUTPUT ON
SET ECHO ON
SET TIMING ON

DECLARE

  LIMIT_IN PLS_INTEGER := 10000;
  V_COUNT_MLOG  NUMBER := 0;
  QTD_INS NUMBER(10) := 0;
  V_SYSDATE DATE := SYSDATE;

  --Primeiro Cursor - financial_statement
  CURSOR C_PAY_REL IS
      (
        SELECT PR.IDT_PAYMENT_RELEASE 
		FROM SAFEPAY_ADM.PAYMENT_RELEASE PR
        JOIN SAFEPAY_ADM.PAYMENT_RELEASE_LIQUIDATION PRL 
		ON PR.IDT_PAYMENT_RELEASE = PRL.IDT_PAYMENT_RELEASE
        WHERE DAT_RELEASE >= DATE '2019-05-04'
        AND DAT_RELEASE    < DATE '2020-05-12'
        AND TRUNC(DAT_RELEASE) = TRUNC(DAT_BLOCK)
        AND IND_PAYMENT_METHOD = 'CREDITCARD'
      );  
  
   --declarando a variavel que receberá os registros da tabela 
   TYPE TY_PAY_REL  
   IS 
   TABLE OF C_PAY_REL%rowtype INDEX BY PLS_INTEGER;
   MC_PAY_REL TY_PAY_REL;

   --abre o primeiro cursor
   BEGIN
        
     OPEN C_PAY_REL;
       LOOP
         FETCH C_PAY_REL BULK COLLECT INTO MC_PAY_REL LIMIT LIMIT_IN;
           EXIT WHEN MC_PAY_REL.COUNT = 0;
                
            FORALL INDX IN 1 .. MC_PAY_REL.COUNT
				    
              UPDATE SAFEPAY_ADM.PAYMENT_RELEASE_LIQUIDATION
              SET DAT_BLOCK = DAT_BLOCK - 1,
                  DAT_UPDATE = V_SYSDATE
              WHERE IDT_PAYMENT_RELEASE = MC_PAY_REL(INDX).IDT_PAYMENT_RELEASE;
        
              COMMIT;
			 
		  -- CONTROLE DA MLOG

          LOOP

            SELECT COUNT(1)
            INTO V_COUNT_MLOG
            FROM SAFEPAY_ADM.MLOG$_PAYMENT_RELEASE_LIQU;

            IF V_COUNT_MLOG > 10000 THEN
              DBMS_LOCK.SLEEP(2);
            ELSE
              EXIT;
            END IF;
          END LOOP;
  
          -- FIM CONTROLE DA MLOG
  
       END LOOP;

       CLOSE C_PAY_REL;
	   COMMIT;
    END; 
/