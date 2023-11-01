DECLARE
resource_busy EXCEPTION;
PRAGMA EXCEPTION_INIT(resource_busy, -00054);
naoexecutou BOOLEAN := TRUE;
v_count NUMBER := 0;
v_sql1 VARCHAR2(2000) := 'DROP INDEX RECEIVABLES_ADM.RECEIVABLE_UNIT_EXTERNAL_IDX02';
v_sql2 VARCHAR2(2000) := 'CREATE UNIQUE INDEX RECEIVABLE_UNIT_EXTERNAL_IDX02 ON RECEIVABLES_ADM.RECEIVABLE_UNIT_EXTERNAL
                                    (DAT_SETTLE ,
                                     COD_CUSTOMER_RECEIVER,
                                     IND_PAYMENT_GROUP    ,
                                     IND_SETTLEMENT_ACQUIRER
                                    )
                                    LOCAL INITRANS 48 tablespace TSIRECEIVABLES01  online';
BEGIN

  SELECT COUNT(*) INTO v_count FROM all_indexes WHERE owner = 'RECEIVABLES_ADM' AND index_name = 'RECEIVABLE_UNIT_EXTERNAL_IDX02';

  IF v_count > 0 THEN
      WHILE naoexecutou
          LOOP
              begin
                  EXECUTE IMMEDIATE v_sql1;
                  naoexecutou := FALSE;
              EXCEPTION
                  WHEN resource_busy THEN
                      DBMS_SESSION.SLEEP(0.25);
                WHEN OTHERS THEN
                      RAISE;
              END;
          END LOOP;
  END IF;
  naoexecutou := TRUE;
      WHILE naoexecutou
          LOOP
              begin
                  EXECUTE IMMEDIATE v_sql2;
                  naoexecutou := FALSE;
              EXCEPTION
                  WHEN resource_busy THEN
                      DBMS_SESSION.SLEEP(0.25);
                  WHEN OTHERS THEN
                      RAISE;
              END;
          END LOOP;
END;
