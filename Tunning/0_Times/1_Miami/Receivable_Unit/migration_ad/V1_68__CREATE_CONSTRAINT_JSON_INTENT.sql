DECLARE
resource_busy EXCEPTION;
PRAGMA EXCEPTION_INIT(resource_busy, -00054);
naoexecutou BOOLEAN := TRUE;
VCOUNT NUMBER := 0;
C_ROLLBACK VARCHAR2(2000) := 'ALTER TABLE AD.RECEIVABLE_INTENT DROP CONSTRAINT JSN_PAYLOAD_REC_INTENT_CK';
C_SQL VARCHAR2(2000) 	  := 'ALTER TABLE AD.RECEIVABLE_INTENT ADD CONSTRAINT JSN_PAYLOAD_REC_INTENT_CK CHECK ( JSN_PAYLOAD IS JSON ) ENABLE NOVALIDATE';
BEGIN
    SELECT COUNT(1)
    INTO VCOUNT
    FROM ALL_CONSTRAINTS
    WHERE CONSTRAINT_TYPE = 'C'
    AND OWNER = 'AD'
    AND CONSTRAINT_NAME = 'JSN_PAYLOAD_REC_INTENT_CK';
	
    IF VCOUNT = 0 THEN
        WHILE naoexecutou
            LOOP
                begin
                    EXECUTE IMMEDIATE C_SQL;
                    naoexecutou := FALSE;
                    DBMS_OUTPUT.PUT_LINE('CONSTRAINT CRIADA COM SUCESSO !');
                    DBMS_OUTPUT.PUT_LINE('SCRIPT ROLLBACK : ' || C_ROLLBACK);
                    COMMIT;
                EXCEPTION
                    WHEN resource_busy THEN
                        DBMS_SESSION.SLEEP(0.25);
                    WHEN OTHERS THEN
                        RAISE;
                END;
            END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('*** CONSTRAINT existente: ' || sys_context('USERENV', 'INSTANCE_NAME') || ' / ' ||
                             sys_context('USERENV', 'SERVER_HOST'));
    END IF;
END;
/