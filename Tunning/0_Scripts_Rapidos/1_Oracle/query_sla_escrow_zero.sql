DROP TABLE SMOREIRA.TMP_RELATORIO_ALE;
CREATE GLOBAL TEMPORARY TABLE SMOREIRA.TMP_RELATORIO_ALE(
COD_CUSTOMER_RECEIVER VARCHAR2(36),
DAT_UPDATE TIMESTAMP,
DAT_CREATION TIMESTAMP,
COD_CASHOUT VARCHAR2(36),
VALOR_A_LIQUIDAR NUMBER(11),
VALOR_CASHOUT  NUMBER(11),
VALOR_LIQUIDADO  NUMBER(11),
VALOR_RECUPERADO  NUMBER(11),
IND_STATUS VARCHAR2(50),
SLA NUMBER)
ON COMMIT PRESERVE ROWS
TABLESPACE "TEMP";

ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

DECLARE

CURSOR C_PAYMENT IS
  SELECT P.IDT_PAYMENT
        ,TO_TIMESTAMP(TO_CHAR(P.DAT_CREATION,'yyyy-MM-dd hh24:mi:ss'),'yyyy-MM-dd hh24:mi:ss') AS DAT_CREATION
  FROM RECEIVABLES_ADM.PAYMENT P
  WHERE P.NUM_ESCROW_VALUE = 0 
  AND P.IND_ESCROW_TYPE = 'UNIQUE' 
  AND P.DAT_CREATION BETWEEN TO_TIMESTAMP('2022-06-22 00:00:00','yyyy-MM-dd hh24:mi:ss') 
                         AND TO_TIMESTAMP('2022-06-22 12:59:59','yyyy-MM-dd hh24:mi:ss')
  AND ROWNUM <=10000                         
;

CURSOR C_REST(P_IDT_PAYMENT NUMBER,P_DAT_CREATION TIMESTAMP) IS
  SELECT RI.COD_CUSTOMER_RECEIVER ,
         C.DAT_UPDATE,        
         C.COD_CASHOUT,
         RI.NUM_SETTLED_AMOUNT AS VALOR_A_LIQUIDAR,
         C.NUM_AMOUNT AS VALOR_CASHOUT,
         DECODE(R.NUM_REMAINING_AMOUNT, NULL, C.NUM_AMOUNT, R.NUM_REMAINING_AMOUNT) AS VALOR_LIQUIDADO,
         R.NUM_RECOVERED_AMOUNT AS VALOR_RECUPERADO,
         C.IND_STATUS,
         EXTRACT(DAY FROM 24 * 60 * (C.DAT_UPDATE - P_DAT_CREATION)) AS SLA
         
  FROM RECEIVABLES_ADM.RECEIVABLE_INTERNAL RI 

  JOIN RECEIVABLES_ADM.CCE_RECEIVABLE_INTERNAL CCE 
  ON CCE.DAT_SETTLE = RI.DAT_SETTLE
  AND CCE.IDT_RECEIVABLE = RI.IDT_RECEIVABLE

  JOIN RECEIVABLES_ADM.SETTLEMENT S 
  ON S.IDT_SETTLEMENT = CCE.IDT_SETTLEMENT

  JOIN RECEIVABLES_ADM.CASHOUT C 
  ON C.IDT_SETTLEMENT = S.IDT_SETTLEMENT

  LEFT JOIN RECEIVABLES_ADM.RECOVERY R 
  ON R.IDT_SETTLEMENT = S.IDT_SETTLEMENT
  
  WHERE RI.DAT_SETTLE = TO_DATE('2022-06-22','YYYY-MM-DD') 
  AND RI.IND_STATUS = 'COMPLETED'
  AND C.DAT_SETTLE = TO_DATE('2022-06-22','YYYY-MM-DD') 
  AND C.IND_STATUS = 'COMPLETED' 
  AND RI.IDT_PAYMENT = P_IDT_PAYMENT
  ;
  
  
BEGIN
  
  FOR REG_PAYMENT IN C_PAYMENT LOOP
  
    FOR REG_REST IN C_REST (REG_PAYMENT.IDT_PAYMENT, REG_PAYMENT.DAT_CREATION) LOOP
    
      INSERT INTO SMOREIRA.TMP_RELATORIO_ALE (
      COD_CUSTOMER_RECEIVER,
      DAT_UPDATE,
      DAT_CREATION,
      COD_CASHOUT,
      VALOR_A_LIQUIDAR,
      VALOR_CASHOUT,
      VALOR_LIQUIDADO,
      VALOR_RECUPERADO,
      IND_STATUS,
      SLA
      
      )
      VALUES
      (REG_REST.COD_CUSTOMER_RECEIVER,
       REG_REST.DAT_UPDATE,
       REG_PAYMENT.DAT_CREATION,
       REG_REST.COD_CASHOUT,
       REG_REST.VALOR_A_LIQUIDAR,
       REG_REST.VALOR_CASHOUT,
       REG_REST.VALOR_LIQUIDADO,
       REG_REST.VALOR_RECUPERADO,
       REG_REST.IND_STATUS,
       REG_REST.SLA);
    
       COMMIT;
    
    END LOOP;
  
  END LOOP;

END;
/  
  
SELECT *
FROM SMOREIRA.TMP_RELATORIO_ALE;