--+---------------------------------------------------------+--
-- Versão antiga da renomeação da tabela CM_EVENT_LOG_NEW para CM_EVENT_LOG
--+---------------------------------------------------------+--


SET SERVEROUTPUT ON
SET TIMING ON

/*
-- ********************************************************************************************************************************************************
-- DROPAR O SINONIMO
-- ******************************************************************************************************************************************************** 
*/

DECLARE
   V_EXISTS_SYNONYM NUMBER := 0;
   V_EXISTS_TABLES NUMBER := 0;
   V_HOST VARCHAR2(255) := UPPER(SYS_CONTEXT('USERENV','SERVER_HOST'));

BEGIN
	IF 	   
			(UPPER(V_HOST) = 'GT-OEXADBADM02.HOST.INTRANET') 
		OR	(UPPER(V_HOST) = 'GT-OEXADBADM01.HOST.INTRANET') 
		OR	(UPPER(V_HOST) = 'GT-OEXADBADM01')
		OR	(UPPER(V_HOST) = 'GT-OEXADBADM02')
		OR	(UPPER(V_HOST) = 'A1-OTISF-Q-PLA7')
		OR  (UPPER(V_HOST) = 'A1-OTISF-S-PRT3')

	THEN	
	
	   SELECT COUNT(*) INTO V_EXISTS_SYNONYM
       FROM ALL_SYNONYMS
       WHERE OWNER  = 'SAFEPAY_ADM'
       AND TABLE_NAME  = 'CM_EVENT_LOG_OLD';
	   
	IF V_EXISTS_SYNONYM = 0 THEN
		DBMS_OUTPUT.PUT_LINE('*** Sinonimos já foram eliminadas nesse ambiente: ' || SYS_CONTEXT('USERENV','INSTANCE_NAME') || ' / ' || SYS_CONTEXT('USERENV','SERVER_HOST'));
	ELSE
		EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM CM_EVENT_LOG_OLD';
		
	    DBMS_OUTPUT.PUT_LINE('SINONIMOS PUBLICOS RELACIONADOS A TABELA SAFEPAY_ADM.CM_EVENT_LOG_OLD ELIMINADOS COM SUCESSO!');
		
	END IF;
	   

/*
-- ********************************************************************************************************************************************************
-- DROPAR A TABELA
-- ******************************************************************************************************************************************************** 
*/

   SELECT COUNT(*) INTO V_EXISTS_TABLES
   FROM ALL_TABLES
   WHERE OWNER  = 'SAFEPAY_ADM'
   AND TABLE_NAME  = 'CM_EVENT_LOG_OLD';

	IF V_EXISTS_TABLES = 0 THEN
		DBMS_OUTPUT.PUT_LINE('*** Tabela SAFEPAY_ADM.CM_EVENT_LOG_OLD já foram eliminadas neste ambiente: ' || SYS_CONTEXT('USERENV','INSTANCE_NAME') || ' - ' || SYS_CONTEXT('USERENV','SERVER_HOST'));
	ELSE
	
		EXECUTE IMMEDIATE 'DROP TABLE SAFEPAY_ADM.CM_EVENT_LOG_OLD PURGE';
	
	    DBMS_OUTPUT.PUT_LINE('TABELA SAFEPAY_ADM.CM_EVENT_LOG_OLD ELIMINADA COM SUCESSO!');

	END IF;
  END IF;
END;  
    
/*
----------------------------------------
-- Verificações:
----------------------------------------

   SELECT 'DROP SYNONYMS' AS DESCRIPTION,
   CASE WHEN COUNT(*) = 0 THEN 'OK' ELSE 'NOK' END RESULT
   FROM ALL_SYNONYMS
   WHERE OWNER  = 'SAFEPAY_ADM'
   AND TABLE_NAME  = 'CM_EVENT_LOG_OLD'
   
   UNION ALL

   SELECT 'DROP TABLES' AS DESCRIPTION,
   CASE WHEN COUNT(*) = 0 THEN 'OK' ELSE 'NOK' END RESULT
   FROM ALL_TABLES
   WHERE OWNER  = 'SAFEPAY_ADM'
   AND TABLE_NAME  = 'CM_EVENT_LOG_OLD';

*/