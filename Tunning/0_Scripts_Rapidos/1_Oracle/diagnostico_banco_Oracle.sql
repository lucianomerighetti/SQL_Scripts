-- DIAGNOSTICO_BANCO

SET SERVEROUTPUT ON SIZE UNLIMITED
SET TIMING ON
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/MM/yyyy HH24:MI:SS';

DECLARE

  V_OWNER VARCHAR2(100) := SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'; -- OWNER DO BANCO
  V_TSD_CORRECT VARCHAR2(500)  := NULL;
  V_TSI_CORRECT VARCHAR2(500)  := NULL;
  V_TSL_CORRECT VARCHAR2(500)  := NULL;
  V_TEMP_DEFAULT VARCHAR2(500) := NULL;
  V_ALTER_TABLE            VARCHAR2(500) := NULL;  
  V_ALTER_TABLE_TABLESPACE VARCHAR2(500) := NULL;  
  V_ALTER_TABLE_SEQUENCE   VARCHAR2(500) := NULL;  
  V_ALTER_INDEX            VARCHAR2(500) := NULL;
  V_ALTER_INDEX_TABLESPACE VARCHAR2(500) := NULL;
  V_ALTER_INDEX_SEQUENCE   VARCHAR2(500) := NULL;
  V_ALTER_INDEX_INITRANS   VARCHAR2(500) := NULL;
  V_ALTER_INDEX_PCTFREE    VARCHAR2(500) := NULL;  
  V_ALTER_USER             VARCHAR2(500) := NULL;   
  V_ALTER_USER_ROLE        VARCHAR2(500) := NULL;     
  V_VAL_INITRANS NUMBER(20);
  V_VAL_CACHE    NUMBER(20);
  V_DAT_INITIAL  TIMESTAMP := TRUNC(SYSDATE) - 7;
  V_DAT_FINAL    TIMESTAMP := TRUNC(SYSDATE);
  V_EVENT		 VARCHAR2(500) := NULL;
  V_STATUS_SEQ_CONTENTION CHAR(1) := NULL;
  V_STATUS_ALLOCATE_ITL_ENTRY CHAR(1) := NULL;  
  V_STATUS_ROLE NUMBER(20) := NULL;
  V_PARALLEL NUMBER(20) := 48;
  V_COMMENT_TABLE VARCHAR2(500) := NULL;  
  V_SYNONYM_PUBLIC VARCHAR2(500) := NULL;  
  V_EXPLAIN_PLAN VARCHAR2(500) := NULL;  
  V_EVENTS_QUERIE VARCHAR(2000) := NULL;  
  V_FLG_COMPLIANCE_NSA CHAR(1) := NULL; 
  
  CURSOR C_TABSPACES IS
    SELECT T.TABLESPACE_NAME
          ,DF.AUTOEXTENSIBLE
          ,DF.SIZE_GB
          ,DF.MAXSIZE_GB
          ,ROUND((NVL(DF.SIZE_GB,0)/NVL(DF.MAXSIZE_GB,1)*100),2) PCT_LIMIT
    FROM DBA_TABLESPACES T
    INNER JOIN (SELECT TABLESPACE_NAME
                     ,AUTOEXTENSIBLE 
                     ,ROUND(NVL(SUM(BYTES/1024/1024/1024),0)) SIZE_GB
                     ,ROUND(NVL(SUM(DECODE(AUTOEXTENSIBLE,'YES',MAXBYTES,BYTES)/1024/1024/1024),0)) MAXSIZE_GB 
                 FROM DBA_DATA_FILES 
                 GROUP  BY TABLESPACE_NAME
                         , AUTOEXTENSIBLE) DF
     ON T.TABLESPACE_NAME = DF.TABLESPACE_NAME
    WHERE T.TABLESPACE_NAME LIKE 'TS%'
    AND T.TABLESPACE_NAME != 'TSTOOLS01'
    ORDER BY T.TABLESPACE_NAME;
	
	
  CURSOR C_STATS_1 IS
    SELECT JOB_STATUS, COUNT(*) QTY_STATUS
    FROM DBA_AUTOTASK_JOB_HISTORY
    WHERE WINDOW_START_TIME >= TRUNC(SYSDATE)-7
    GROUP BY JOB_STATUS
    ORDER BY JOB_STATUS;	
	
  CURSOR C_STATS_2 IS
    SELECT PT.TABLE_NAME
          ,NVL(SP.PREFERENCE_NAME, 'NOT_EXISTS') PREFERENCE_NAME
          ,NVL(SP.PREFERENCE_VALUE, 'NOT_EXISTS') PREFERENCE_VALUE
    FROM DBA_PART_TABLES PT
    LEFT JOIN DBA_TAB_STAT_PREFS SP
    ON PT.OWNER = SP.OWNER
    AND PT.TABLE_NAME = SP.TABLE_NAME
    WHERE PT.OWNER = V_OWNER;	
	
	
  CURSOR C_PROFILES IS
    SELECT PROFILE,RESOURCE_NAME,RESOURCE_TYPE,LIMIT AS LIMIT_TIME
    FROM DBA_PROFILES
    WHERE RESOURCE_NAME = 'IDLE_TIME'
    AND PROFILE LIKE 'PR_%'
    AND PROFILE NOT LIKE '%##%'
    AND PROFILE NOT IN ('PR_AD','PR_BI','PR_BIGDATA','PR_DBA','PR_DS','PR_GOV','PR_SEC','PR_NEWRELICUBR')
    AND PROFILE NOT IN ('PR_'||(SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'UBR'),'PR_'||(SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'))
    AND LIMIT IN ('DEFAULT','UNLIMITED')
	ORDER BY 1;

	 
  CURSOR C_USERS IS
	SELECT U.USERNAME,U.PROFILE,U.DEFAULT_TABLESPACE,U.TEMPORARY_TABLESPACE,U.LOCAL_TEMP_TABLESPACE,
    ROUND(NVL((MAX_BYTES/1024/1024/1024),0),2) AS MAX_GB_BYTES, RU.ROLES_USERS
	FROM DBA_USERS U
    LEFT JOIN DBA_TS_QUOTAS Q
    ON U.USERNAME = Q.USERNAME
    AND U.DEFAULT_TABLESPACE = Q.TABLESPACE_NAME
    LEFT JOIN ( SELECT RP.GRANTEE USERNAME, LISTAGG(R.ROLE,',') ROLES_USERS
                FROM DBA_ROLE_PRIVS RP
                INNER JOIN DBA_ROLES R
                ON R.ROLE = RP.GRANTED_ROLE
                WHERE R.ROLE IN ('CONNECT','RL_PERFORMANCE_ANALYZER_EM','RL_COMPLIANCE_NSA','RL_COMPLIANCE_SO','RL_COMPLIANCE_PII','RL_COMPLIANCE_PCI','RL_COMPLIANCE_BS','RL_COMPLIANCE_SF')
                GROUP BY RP.GRANTEE) RU
    ON U.USERNAME = RU.USERNAME           
	WHERE U.CREATED >= (SELECT CREATED FROM DBA_USERS WHERE USERNAME = (SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'))
	AND U.USERNAME NOT LIKE '%##%' 
    AND U.USERNAME NOT IN ((SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'UBR'),(SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'))	
	AND (U.ACCOUNT_STATUS = 'OPEN' OR U.ACCOUNT_STATUS LIKE 'EXPIRED%')
    ORDER BY CREATED;

	
  CURSOR C_TAB IS
    SELECT OWNER, TABLE_NAME, COMP COMPRESSION, PART, DECODE(PARTITIONED,'/','NO',PARTITIONED) PARTITIONED, NUM_ROWS, 
      DATA_TB, QTD_IDX QDADE_INDEX, INDX_TB, LOB_TB, TOTAL_TB, TABLE_SPACE, CACHE_SEQUENCE, COLUMN_CACHE,INI_TRANS,PCT_FREE,
      AVG_UPDATE_DAY,AVG_INSERT_DAY,AVG_DELETE_DAY,GRANT_ROLES
    FROM (  SELECT  DATA.TABLE_NAME, (SELECT COMPR.COMPRESSION FROM DBA_TABLES COMPR WHERE COMPR.OWNER=DATA.OWNER 
	        AND COMPR.TABLE_NAME=DATA.TABLE_NAME)COMP, 
                  (SELECT PART.PARTITIONED FROM DBA_TABLES PART WHERE PART.OWNER=DATA.OWNER AND PART.TABLE_NAME=DATA.TABLE_NAME)PART,
                  (SELECT COUNT(1) FROM DBA_INDEXES IDX WHERE IDX.OWNER=DATA.OWNER AND IDX.TABLE_NAME=DATA.TABLE_NAME)QTD_IDX,
                  DATA.OWNER, PARTITIONING_TYPE || DECODE (SUBPARTITIONING_TYPE, 'none', NULL, '/' || SUBPARTITIONING_TYPE)
                  PARTITIONED, NUM_ROWS, NVL(DATA_TB,0) DATA_TB, NVL(INDX_TB,0) INDX_TB, NVL(LOB_TB,0) LOB_TB,
                  NVL(DATA_TB,0) + NVL(INDX_TB,0) + NVL(LOB_TB,0) TOTAL_TB, DATA.TABLESPACE_NAME TABLE_SPACE, 
                  SEQ_CACHE.CACHE_SEQUENCE, SEQ_CACHE.COLUMN_CACHE, INITRANS_PCTFREE.INI_TRANS ,INITRANS_PCTFREE.PCT_FREE,
                  MODIF.AVG_UPDATE_DAY,MODIF.AVG_INSERT_DAY,MODIF.AVG_DELETE_DAY,ROLES_TAB.GRANT_ROLES
          FROM  ( SELECT OWNER, TABLE_NAME, NVL(MIN(NUM_ROWS),0) NUM_ROWS, ROUND(SUM(DATA_TB),2) DATA_TB, TABLESPACE_NAME
                  FROM (  SELECT OWNER, TABLE_NAME, NUM_ROWS, DATA_TB, TABLESPACE_NAME
                          FROM (  SELECT A.OWNER, A.TABLE_NAME, A.NUM_ROWS, B.TABLESPACE_NAME, B.BYTES/1024/1024/1024/1024 AS DATA_TB
                                  FROM DBA_TABLES A
                                  INNER JOIN DBA_SEGMENTS B
                                  ON A.OWNER=B.OWNER
                                  WHERE A.TABLE_NAME = B.SEGMENT_NAME
                                  AND A.OWNER=V_OWNER
                                  AND B.SEGMENT_TYPE IN ('TABLE','TABLE PARTITION')
                                  UNION ALL
                                  SELECT T.OWNER, T.TABLE_NAME, T.NUM_ROWS, nvl(T.TABLESPACE_NAME, pt.DEF_TABLESPACE_NAME) as TABLESPACE_NAME, 0 AS DATA_TB
                                  FROM DBA_TABLES T
                                  LEFT JOIN DBA_PART_TABLES PT
                                  ON T.OWNER = PT.OWNER
                                  AND T.TABLE_NAME = PT.TABLE_NAME
                                  WHERE T.OWNER = V_OWNER
                                  ))                                
                  GROUP BY OWNER, TABLE_NAME, TABLESPACE_NAME) DATA,
                ( SELECT A.TABLE_NAME, ROUND(SUM(B.BYTES/1024/1024/1024/1024),2) AS INDX_TB
                  FROM DBA_INDEXES A, DBA_SEGMENTS B
                  WHERE A.INDEX_NAME = B.SEGMENT_NAME(+) AND A.OWNER=B.OWNER(+) AND A.OWNER=V_OWNER
                  GROUP BY A.TABLE_NAME) INDX,
                ( SELECT A.TABLE_NAME, ROUND(SUM(B.BYTES/1024/1024/1024/1024),2) AS LOB_TB
                  FROM DBA_LOBS A, DBA_SEGMENTS B
                  WHERE A.SEGMENT_NAME = B.SEGMENT_NAME(+) AND A.OWNER=B.OWNER(+) AND A.OWNER=V_OWNER 
                  GROUP BY A.TABLE_NAME) LOB,
				( SELECT ID.OWNER,ID.TABLE_NAME, ID.COLUMN_NAME AS COLUMN_CACHE,
                  SUBSTR(ID.IDENTITY_OPTIONS,(INSTR(ID.IDENTITY_OPTIONS, 'CACHE_SIZE: ') + 12),(INSTR(ID.IDENTITY_OPTIONS, ', ORDER_FLAG') - (INSTR(IDENTITY_OPTIONS, 'CACHE_SIZE: ') + 12))) CACHE_SEQUENCE
                  FROM ALL_TAB_IDENTITY_COLS ID
                  WHERE ID.OWNER = V_OWNER) SEQ_CACHE, 
                ( SELECT DISTINCT T.OWNER,T.TABLE_NAME,NVL(T.INI_TRANS,PT.DEF_INI_TRANS) AS INI_TRANS,NVL(T.PCT_FREE,PT.DEF_PCT_FREE) AS PCT_FREE
                  FROM DBA_TABLES T
                  LEFT JOIN DBA_PART_TABLES PT
                  ON T.OWNER = PT.OWNER
                  AND T.TABLE_NAME = PT.TABLE_NAME
                  WHERE T.OWNER = V_OWNER) INITRANS_PCTFREE,
                ( SELECT DT.OWNER,DT.TABLE_NAME,
                         ROUND(SUM(DTM.UPDATES) / TRUNC(SYSDATE -(DT.LAST_ANALYZED - 1)), 2) AVG_UPDATE_DAY,
                         ROUND(SUM(DTM.INSERTS) / TRUNC(SYSDATE -(DT.LAST_ANALYZED - 1)), 2) AVG_INSERT_DAY,
                         ROUND(SUM(DTM.DELETES) / TRUNC(SYSDATE -(DT.LAST_ANALYZED - 1)), 2) AVG_DELETE_DAY
                  FROM DBA_TABLES  DT
                  INNER JOIN DBA_TAB_MODIFICATIONS DTM 
				  ON DT.OWNER = DTM.TABLE_OWNER
                  AND DT.TABLE_NAME = DTM.TABLE_NAME
                  WHERE DT.OWNER = V_OWNER
                  GROUP BY DT.OWNER, DT.TABLE_NAME, DT.LAST_ANALYZED) MODIF,
				( SELECT OWNER, TABLE_NAME, NVL(LISTAGG(GRANTEE,','),'EMPTY') GRANT_ROLES
				  FROM DBA_TAB_PRIVS
				  WHERE OWNER = V_OWNER
				  AND GRANTEE IN ('RL_COMPLIANCE_NSA','RL_COMPLIANCE_SO','RL_COMPLIANCE_PII','RL_COMPLIANCE_PCI','RL_COMPLIANCE_BS','RL_COMPLIANCE_SF')
				  GROUP BY OWNER, TABLE_NAME)  ROLES_TAB				  
                  
                  , DBA_PART_TABLES PART				  
          WHERE DATA.TABLE_NAME = INDX.TABLE_NAME(+) AND
                DATA.TABLE_NAME = LOB.TABLE_NAME(+)  AND
                DATA.TABLE_NAME = SEQ_CACHE.TABLE_NAME(+)  AND
                DATA.TABLE_NAME = INITRANS_PCTFREE.TABLE_NAME(+)  AND
                DATA.TABLE_NAME = MODIF.TABLE_NAME(+)  AND                
                DATA.TABLE_NAME = PART.TABLE_NAME(+) AND
                DATA.TABLE_NAME = ROLES_TAB.TABLE_NAME(+) AND                
                DATA.OWNER = PART.OWNER(+)
    ORDER BY TOTAL_TB DESC);
  
  CURSOR C_SEQUENCE IS
    SELECT S.SEQUENCE_OWNER AS OWNER
	      ,NVL(I.TABLE_NAME,S.SEQUENCE_NAME) AS SEQUENCE
          ,S.LAST_NUMBER
          ,S.MAX_VALUE
          ,ROUND(((S.LAST_NUMBER * 100) / MAX_VALUE),4) AS PERC_USADO
          ,CASE WHEN ROUND(((S.LAST_NUMBER * 100) / MAX_VALUE),4) >=80 THEN 'AUMENTAR SEQUENCE' ELSE 'OK' END AS STATUS_SEQUENCE
    FROM DBA_SEQUENCES S
    LEFT JOIN ALL_TAB_IDENTITY_COLS I
    ON S.SEQUENCE_NAME = I.SEQUENCE_NAME
    WHERE SEQUENCE_OWNER =  V_OWNER;  
  
  CURSOR C_TAB_FK (P_OWNER VARCHAR, P_TABLE_NAME VARCHAR) IS
    SELECT DISTINCT CASE
           WHEN B.TABLE_NAME IS NULL THEN 'UNINDEXED'
           ELSE 'INDEXED'
         END               AS STATUS, 
         A.OWNER, 
         A.TABLE_NAME      AS TABLE_NAME,
         A.CONSTRAINT_NAME
    FROM   (SELECT A.OWNER, 
                 A.TABLE_NAME, 
                 A.CONSTRAINT_NAME, 
                 LISTAGG(A.COLUMN_NAME, ',') 
                   WITHIN GROUP (ORDER BY A.POSITION) FK_COLUMNS 
          FROM   DBA_CONS_COLUMNS A, 
                 DBA_CONSTRAINTS B 
          WHERE  A.CONSTRAINT_NAME = B.CONSTRAINT_NAME 
                 AND B.CONSTRAINT_TYPE = 'R'
                 AND A.OWNER = B.OWNER 
                 AND A.OWNER = P_OWNER
	  		   AND A.TABLE_NAME = P_TABLE_NAME			   
          GROUP  BY A.OWNER, 
                    A.TABLE_NAME, 
                    A.CONSTRAINT_NAME) A, 
         (SELECT C.TABLE_NAME,C.INDEX_NAME,LISTAGG(C.COLUMN_NAME, ',')
          WITHIN GROUP (ORDER BY C.COLUMN_POSITION) INDEX_COLUMNS
          FROM   DBA_IND_COLUMNS C 
          WHERE  C.INDEX_OWNER = P_OWNER
	  	AND    C.TABLE_NAME = P_TABLE_NAME 
          GROUP  BY TABLE_NAME, 
                    INDEX_NAME) B 
    WHERE  A.TABLE_NAME = B.TABLE_NAME(+) 
         AND B.INDEX_COLUMNS(+) LIKE A.FK_COLUMNS|| '%' ; 


  CURSOR C_IND(P_OWNER VARCHAR, P_TABLE_NAME VARCHAR, P_COLUMN_CACHE VARCHAR) IS
    SELECT  
      SI.OWNER
     ,SI.TABLE_NAME
     ,SI.INDEX_NAME
     ,SI.PART
     ,SI.TABLESPACE_INDEX
     ,SI.TABLESPACE_TABLE
     ,SI.INITRANS_INDEX
     ,SI.INITRANS_TABLE
     ,SI.PCT_FREE_INDEX
     ,SI.PCT_FREE_TABLE
     ,SI.STATUS_TABLESPACE
     ,SI.STATUS_INITRANS
     ,SI.STATUS_PCT_FREE
     FROM
     (
     SELECT  
      PI.OWNER
     ,PI.TABLE_NAME
     ,PI.INDEX_NAME
     ,PI.PART
     ,PI.TABLESPACE_INDEX
     ,PI.TABLESPACE_TABLE
     ,PI.INITRANS_INDEX
     ,PI.INITRANS_TABLE
     ,PI.PCT_FREE_INDEX
     ,PI.PCT_FREE_TABLE
     ,CASE WHEN (PI.TABLESPACE_INDEX <> PI.TABLESPACE_TABLE) THEN 'OK' ELSE 'CORRIGIR' END AS STATUS_TABLESPACE
     ,CASE WHEN ((PI.INITRANS_INDEX = (PI.INITRANS_TABLE * 2)) AND PI.INITRANS_TABLE < 100 AND PI.INITRANS_INDEX < 100) THEN 'OK' 
      ELSE 
        CASE WHEN PI.INITRANS_INDEX >= 100 THEN
          'CORRIGIR' 
        ELSE
          'OK'
        END
      END AS STATUS_INITRANS     
     ,CASE WHEN (PI.PCT_FREE_INDEX = PI.PCT_FREE_TABLE) THEN 'OK' ELSE 'CORRIGIR' END AS STATUS_PCT_FREE
     FROM
     (SELECT 
      I.OWNER
     ,I.TABLE_NAME
     ,I.INDEX_NAME
     ,'YES' PART
     ,I.DEF_TABLESPACE_NAME AS TABLESPACE_INDEX
     ,T.DEF_TABLESPACE_NAME AS TABLESPACE_TABLE
     ,I.DEF_INI_TRANS AS INITRANS_INDEX
     ,T.DEF_INI_TRANS AS INITRANS_TABLE
     ,I.DEF_PCT_FREE AS PCT_FREE_INDEX
     ,T.DEF_PCT_FREE AS PCT_FREE_TABLE
     FROM
     (SELECT OWNER, TABLE_NAME, DEF_TABLESPACE_NAME, DEF_INI_TRANS, DEF_PCT_FREE
     FROM DBA_PART_TABLES
     WHERE OWNER = P_OWNER
	 AND TABLE_NAME = P_TABLE_NAME) T
     INNER JOIN
     (SELECT OWNER, TABLE_NAME, INDEX_NAME, DEF_TABLESPACE_NAME, DEF_INI_TRANS, DEF_PCT_FREE
     FROM DBA_PART_INDEXES
     WHERE OWNER = P_OWNER
	 AND TABLE_NAME = P_TABLE_NAME) I
     ON T.OWNER = I.OWNER
     AND T.TABLE_NAME = I.TABLE_NAME
     UNION ALL
     SELECT 
      INP.OWNER
     ,INP.TABLE_NAME
     ,INP.INDEX_NAME
     ,'NO' PART
     ,INP.TABLESPACE_NAME AS TABLESPACE_INDEX
     ,TNP.TABLESPACE_NAME AS TABLESPACE_TABLE
     ,INP.INI_TRANS AS INITRANS_INDEX
     ,TNP.INI_TRANS AS INITRANS_TABLE
     ,INP.PCT_FREE AS PCT_FREE_INDEX
     ,TNP.PCT_FREE AS PCT_FREE_TABLE
     FROM
     (SELECT DISTINCT T.OWNER,T.TABLE_NAME,NVL(T.TABLESPACE_NAME, PT.DEF_TABLESPACE_NAME) AS TABLESPACE_NAME,NVL(T.INI_TRANS,PT.DEF_INI_TRANS) AS INI_TRANS,NVL(T.PCT_FREE,PT.DEF_PCT_FREE) AS PCT_FREE
     FROM ALL_TABLES T
     LEFT JOIN DBA_PART_TABLES PT
     ON T.OWNER = PT.OWNER
     AND T.TABLE_NAME = PT.TABLE_NAME
     WHERE T.OWNER = P_OWNER
	 AND T.TABLE_NAME = P_TABLE_NAME) TNP 
     INNER JOIN
     (SELECT I.OWNER,I.TABLE_NAME,I.INDEX_NAME,I.TABLESPACE_NAME,I.INI_TRANS,I.PCT_FREE
     FROM ALL_INDEXES I
     WHERE I.OWNER = P_OWNER
     AND I.INDEX_NAME NOT IN (SELECT PI.INDEX_NAME FROM  DBA_PART_INDEXES PI
     WHERE PI.OWNER = I.OWNER
	 AND PI.TABLE_NAME = P_TABLE_NAME)) INP 
     ON TNP.OWNER = INP.OWNER
     AND TNP.TABLE_NAME = INP.TABLE_NAME) PI) SI
	 WHERE SI.INDEX_NAME NOT LIKE '%SYS%$$%'
     ORDER BY 1,2,3;
	 
     
  CURSOR C_COLS(P_OWNER VARCHAR, P_TABLE_NAME VARCHAR) IS
    SELECT TC.OWNER
          ,TC.TABLE_NAME
          ,TC.COLUMN_NAME
          ,TC.DATA_TYPE
          ,TC.DATA_LENGTH
          ,TC.AVG_COL_LEN
          ,TCC.COMMENTS AS COL_COMMENT
          ,NVL(SUBSTR(TCC.COMMENTS,(INSTR(TCC.COMMENTS, '[') + 1),(INSTR(TCC.COMMENTS, ']') - (INSTR(TCC.COMMENTS, '[') + 1))),
               SUBSTR(TCC.COMMENTS,1,INSTR(TCC.COMMENTS, ' '))) TAG
          ,RC.FUNCTION_TYPE
          ,RC.FUNCTION_PARAMETERS
          FROM DBA_TAB_COLUMNS TC
          INNER JOIN DBA_COL_COMMENTS TCC
          ON TC.OWNER = TCC.OWNER
          AND TC.TABLE_NAME = TCC.TABLE_NAME
          AND TC.COLUMN_NAME = TCC.COLUMN_NAME
          LEFT JOIN REDACTION_COLUMNS RC
          ON TC.OWNER = RC.OBJECT_OWNER
          AND TC.TABLE_NAME = RC.OBJECT_NAME
          AND TC.COLUMN_NAME = RC.COLUMN_NAME
          WHERE TC.OWNER = P_OWNER
            AND TC.TABLE_NAME = P_TABLE_NAME;
    	
  CURSOR C_QUERIES IS
    SELECT T2.USERNAME
         , T1.MODULE
         , T1.DISK_READS
         , ROUND(T1.ELAPSED_TIME/1000000,2) AS ELAPSED_SEC
         , T1.EXECUTIONS
         , ROUND(T1.ELAPSED_TIME/1000000 / DECODE(T1.EXECUTIONS, 0, 1, T1.EXECUTIONS),2)  AS AVG_TIME_PER_EXEC
         , ROUND(T1.DISK_READS / DECODE(T1.EXECUTIONS, 0, 1, T1.EXECUTIONS),2) AS EXEC_RATIO
         , T1.SQL_ID
         , T1.SQL_FULLTEXT
    FROM GV$SQLAREA T1
    INNER JOIN DBA_USERS T2
    ON T1.PARSING_USER_ID = T2.USER_ID
    WHERE T2.USERNAME like '%UBR%'
    AND T2.USERNAME not like '%REDASH_%UBR%'
    AND ROWNUM <= 15
    ORDER BY ROUND(T1.ELAPSED_TIME/1000000,2) DESC
                 , T1.DISK_READS ;  
				 
	
  CURSOR C_EVENTS_QUERIES(P_SQL_ID VARCHAR) IS
    SELECT ASH.SQL_ID,
           ASH.EVENT AS EVENT_QUERIE,
           COUNT(*) SCORE,
           LPAD(ROUND(RATIO_TO_REPORT(COUNT(*)) OVER () * 100)||'%',10,' ') PERCENT
      FROM DBA_HIST_ACTIVE_SESS_HISTORY ASH
     WHERE ASH.SAMPLE_TIME BETWEEN V_DAT_INITIAL AND V_DAT_FINAL
       AND ASH.SQL_ID = P_SQL_ID
       AND ASH.EVENT IS NOT NULL
     GROUP BY ASH.SQL_ID,
              ASH.EVENT
     ORDER BY PERCENT DESC;  
  
	 
  FUNCTION F_VERIFY_EVENT(P_OWNER VARCHAR, P_OBJECT VARCHAR, P_EVENT VARCHAR) RETURN VARCHAR IS 
     V_STATUS VARCHAR(30);
	 
	 BEGIN
       SELECT CASE WHEN MAX(E.WAIT_COUNT) <> 0 THEN 'S' ELSE 'N' END AS STATUS
       INTO V_STATUS
       FROM 
       (SELECT ASH.SQL_ID,
              ASH.CURRENT_OBJ#,
              OBJ.OBJECT_NAME,
              OBJ.OBJECT_TYPE,
              NVL(COUNT(1),0) AS WAIT_COUNT
       FROM DBA_HIST_ACTIVE_SESS_HISTORY ASH
       LEFT JOIN DBA_OBJECTS        OBJ 
       ON OBJ.OBJECT_ID = ASH.CURRENT_OBJ#
       WHERE ASH.SAMPLE_TIME BETWEEN V_DAT_INITIAL AND V_DAT_FINAL
       AND OBJ.OWNER = P_OWNER
       AND OBJ.OBJECT_NAME = P_OBJECT
       AND ASH.EVENT IN (P_EVENT)
       GROUP BY ASH.SQL_ID,
                ASH.TOP_LEVEL_SQL_ID,
                ASH.CURRENT_OBJ#,
                OBJ.OBJECT_NAME,
                OBJ.OBJECT_TYPE
       HAVING COUNT(1) > 100
       ORDER BY 4 DESC) E;
      
    RETURN V_STATUS;
	
    EXCEPTION 
      WHEN NO_DATA_FOUND THEN
        V_STATUS := 'N';
      WHEN OTHERS THEN
        V_STATUS := 'N';       

  END;      
     
BEGIN

    DBMS_OUTPUT.PUT_LINE('*******************************************************************');      
    DBMS_OUTPUT.PUT_LINE('* DIAGNOSTICO BANCO: '|| sys_context ( 'USERENV', 'DB_NAME' ) );      	
    DBMS_OUTPUT.PUT_LINE('* DATA: '|| TO_CHAR(TO_DATE(SYSDATE, 'dd/MM/yyyy hh24:mi:ss')));
    DBMS_OUTPUT.PUT_LINE('*******************************************************************');      


    DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE(' ');      

    DBMS_OUTPUT.PUT_LINE('***********************');      
    DBMS_OUTPUT.PUT_LINE('*     TABLESPACES     *');      	
    DBMS_OUTPUT.PUT_LINE('***********************');    

  FOR R_TABSPACES IN C_TABSPACES LOOP
  /* 
    Os alarmes das EC hoje estao para 95% do uso das tablespaces, o que e muito alto e dessa forma nao temos tempo habil de criar uma
	estrategia para diminuir o uso das tablespaces
  */	
  
    IF R_TABSPACES.AUTOEXTENSIBLE = 'NO' THEN
      DBMS_OUTPUT.PUT_LINE('-- '||R_TABSPACES.TABLESPACE_NAME||' com a funcao AUTOEXTENSIBLE desligada. Favor corrigir.');	
      DBMS_OUTPUT.PUT_LINE(' ');   	
	END IF;
  
  
    IF R_TABSPACES.PCT_LIMIT >= 60 THEN
      DBMS_OUTPUT.PUT_LINE('-- '||R_TABSPACES.TABLESPACE_NAME||' com mais de 60% de espaco alocado. Planeje: Expurgo, criacao de novas tablespaces, movimentacao/reorganização de tablespaces ou compactacao de dados.');	
      DBMS_OUTPUT.PUT_LINE(' ');   	
	END IF;

  END LOOP;	
  
    -- TABLESPACE PRINCIPAL DE DADOS
  BEGIN
  
    SELECT NVL(TABLESPACE_NAME,'TSD_NOT_EXISTS') 
    INTO V_TSD_CORRECT
    FROM DBA_TABLESPACES 
    WHERE TABLESPACE_NAME LIKE 'TSD'||SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'01'; 
    
    EXCEPTION 
	  WHEN NO_DATA_FOUND THEN
        V_TSD_CORRECT := 'TSD_NOT_EXISTS';
  
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('[ERRO]: ' || TO_CHAR(SQLERRM) || CHR(10) || TO_CHAR(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE));
        DBMS_OUTPUT.PUT_LINE('--------------------------------');
  
  END;
  
  -- TABLESPACE PRINCIPAL DE INDICES
  BEGIN
  
    SELECT NVL(TABLESPACE_NAME,'TSI_NOT_EXISTS') 
    INTO V_TSI_CORRECT
    FROM DBA_TABLESPACES 
    WHERE TABLESPACE_NAME LIKE 'TSI'||SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'01'; 
    
    EXCEPTION 
	  WHEN NO_DATA_FOUND THEN
        V_TSI_CORRECT := 'TSI_NOT_EXISTS';
  
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('[ERRO]: ' || TO_CHAR(SQLERRM) || CHR(10) || TO_CHAR(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE));
        DBMS_OUTPUT.PUT_LINE('--------------------------------');
  
  END;
  
  -- TABLESPACE PRINCIPAL DE LOBS
  BEGIN
  
    SELECT NVL(TABLESPACE_NAME,'TSL_NOT_EXISTS') 
    INTO V_TSL_CORRECT
    FROM DBA_TABLESPACES 
    WHERE TABLESPACE_NAME LIKE 'TSL'||SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'01'; 
    
    EXCEPTION 
	  WHEN NO_DATA_FOUND THEN
        V_TSL_CORRECT := 'TSL_NOT_EXISTS';
  
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('[ERRO]: ' || TO_CHAR(SQLERRM) || CHR(10) || TO_CHAR(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE));
        DBMS_OUTPUT.PUT_LINE('--------------------------------');
  
  END;
  
  -- TABLESPACE TEMPORARIA
  BEGIN
  
    SELECT NVL(TABLESPACE_NAME,'TEMP_NOT_EXISTS') 
    INTO V_TEMP_DEFAULT
    FROM DBA_TABLESPACES 
    WHERE TABLESPACE_NAME = 'TEMP'; 
    
    EXCEPTION 
	  WHEN NO_DATA_FOUND THEN
        V_TEMP_DEFAULT := 'TEMP_NOT_EXISTS';
  
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('[ERRO]: ' || TO_CHAR(SQLERRM) || CHR(10) || TO_CHAR(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE));
        DBMS_OUTPUT.PUT_LINE('--------------------------------');
  
  END;
  
  
  
  DBMS_OUTPUT.PUT_LINE(' ');      
  DBMS_OUTPUT.PUT_LINE(' ');      
  DBMS_OUTPUT.PUT_LINE(' ');      
  DBMS_OUTPUT.PUT_LINE(' ');      
  
  DBMS_OUTPUT.PUT_LINE('***********************');      
  DBMS_OUTPUT.PUT_LINE('*     ESTATISTICAS    *'); 
  DBMS_OUTPUT.PUT_LINE('***********************');
	
  FOR R_STATS_1 IN C_STATS_1 LOOP
  /* 
    No cursor, buscamos os dados dos ultimos 7 dias, e por dia sao executados tres jobs: 
		- auto optimizer stats collection: coleta das estatisticas das tabelas
		- sql tuning advisor: coleta dados para AWR, profiles e baselines
		- auto space advisor: identifica segmentos que podem ser reorganizados para economizar espaco
		
	Logo, o total da semana sao 21 execucoes. Se a contagem de status FAILED for maior ou igual a 7, e válido checar a coleta de estatísticas	
  */
  
    IF R_STATS_1.JOB_STATUS = 'STOPPED' AND R_STATS_1.QTY_STATUS >= 7 THEN
      DBMS_OUTPUT.PUT_LINE('-- As coletas de estatisticas do banco nao estao sendo finalizadas com sucesso. Valide: paralelismo e concorrencia (DBMS_STATS.SET_TABLE_PREFS - DEGREE e CONCURRENT), e tambem o horario agendado das coletas (DBMS_SCHEDULER).');	
      DBMS_OUTPUT.PUT_LINE(' ');   	
	END IF;
  END LOOP;	
	
  FOR R_STATS_2 IN C_STATS_2 LOOP  
    IF (R_STATS_2.PREFERENCE_NAME = 'NOT_EXISTS' OR R_STATS_2.PREFERENCE_VALUE = 'NOT_EXISTS' OR R_STATS_2.PREFERENCE_VALUE = 'FALSE') THEN
      DBMS_OUTPUT.PUT_LINE('Validar a coleta de estatistica da tabela '||R_STATS_2.TABLE_NAME||'. Alterar para INCREMENTAL.');	
      DBMS_OUTPUT.PUT_LINE(' '); 
	END IF;
  END LOOP;		
	
	DBMS_OUTPUT.PUT_LINE(' ');   	

    DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE(' ');      

    DBMS_OUTPUT.PUT_LINE('***********************');      
    DBMS_OUTPUT.PUT_LINE('*      PROFILES       *');      	
    DBMS_OUTPUT.PUT_LINE('***********************');    
	
	FOR R_PROFILES IN C_PROFILES LOOP
  /* 
    IDLE_TIME = Especifica os períodos permitidos de tempo inativo contínuo durante uma sessao, expressos em minutos.
    Se o valor estiver como DEFAULT (SELECT * FROM DBA_PROFILES WHERE PROFILE = 'DEFAULT'), por padrao, e UNLIMITED, 
	o que pode causar sessoes penduradas e consequentmente o erro 'ORA-02391: exceeded simultaneous SESSIONS_PER_USER limit'.
    O ideal e deixar DEFAULT para os usuários UBR de aplicacao e para os profiles do Redash (PR_REDASH) e de usuários nominais de DEV (PR_DEV) 30	
  */	
	
	  IF R_PROFILES.PROFILE LIKE 'PR_DEV_%' THEN
	    DBMS_OUTPUT.PUT_LINE('-- Profile '||R_PROFILES.PROFILE||' fora do padrao de Compliance. Efetue e exclusao, validando antes quais usuarios estao atrelados a ele.');  	
	  END IF;
	
	  IF (R_PROFILES.PROFILE LIKE 'PR_MANUT_%' OR R_PROFILES.PROFILE = 'PR_REDASH' OR R_PROFILES.PROFILE = 'PR_DEV') THEN
	    DBMS_OUTPUT.PUT_LINE('-- Profile '||R_PROFILES.PROFILE||' com o parametro IDLE_TIME incorreto. Efetuar a correcao conforme script abaixo: ');  	
        DBMS_OUTPUT.PUT_LINE('ALTER PROFILE '||R_PROFILES.PROFILE||' LIMIT IDLE_TIME 30;');  	   		
	  ELSE
	    DBMS_OUTPUT.PUT_LINE('-- Profile '||R_PROFILES.PROFILE||' com o parametro IDLE_TIME DEFAULT. Validar a necessidade desse valor.');  	
	  END IF;
	
	END LOOP;
		
	
	DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE(' ');  
	
    DBMS_OUTPUT.PUT_LINE('***********************');      
    DBMS_OUTPUT.PUT_LINE('*       USUARIOS      *');      	
    DBMS_OUTPUT.PUT_LINE('***********************');    
	
	
	FOR R_USERS IN C_USERS LOOP
  /* 
    Profile DEFAULT (SELECT * FROM DBA_PROFILES WHERE PROFILE = 'DEFAULT'), por padrao, tem todos os parametros como UNLIMITED, 
	o que pode causar problemas de compliance. Caso encontremos um usuario nesse profile, por padrao, colocaremos no profile PR_DEV, 
	mas vale analisar usuario por usuario.

    Os usuarios de aplicacao devem ter como tablespace padrao a tablespace de dados padrao do banco, a TEMP como TEMPORARY_TABLESPACE e
	LOCAL_TEMP_TABLESPACE

    As tablespaces para usuarios nominais e do Redash ficam divididas dessa forma para nao haver sobrecarga nas tablespaces de aplicacao 
	e do proprio banco

	 - DEFAULT_TABLESPACE = USERS
	 - TEMPORARY_TABLESPACE = TEMP para PagCloud e TSTEMP01 para Exadata 
	 - LOCAL_TEMP_TABLESPACE = TEMP para PagCloud e TSTEMP01 para Exadata 
	 
	Para os ADs aumentar a quota na tablespace para 1 GB 
	
	Todos os usuarios devem ter permissao de select na role 'RL_COMPLIANCE_NSA'.
	Os ADs tambem devem ter permissao de execute na role 'RL_PERFORMANCE_ANALYZER_EM', devido ao uso do novo OEM (extracao de AWR)

  */	

      V_ALTER_USER      := NULL;
      V_ALTER_USER_ROLE := NULL;
	  V_STATUS_ROLE     := NULL;

      -- CONFIGURACOES
	  IF R_USERS.PROFILE LIKE '%UBR' AND (R_USERS.DEFAULT_TABLESPACE NOT LIKE 'TSD%' OR R_USERS.TEMPORARY_TABLESPACE <> 'TEMP' 
	   OR R_USERS.LOCAL_TEMP_TABLESPACE <> 'TEMP') THEN
	    DBMS_OUTPUT.PUT_LINE('-- O usuario '||R_USERS.USERNAME||' tem tablespaces erradas. Efetuar a correcao conforme script abaixo: ');    	  
	    V_ALTER_USER := 'ALTER USER '||R_USERS.USERNAME||' DEFAULT TABLESPACE '||V_TSD_CORRECT||' TEMPORARY TABLESPACE TEMP LOCAL TEMPORARY TABLESPACE TEMP;';
	    DBMS_OUTPUT.PUT_LINE(V_ALTER_USER);   
	  END IF;

	  IF R_USERS.PROFILE = 'DEFAULT' THEN
	    DBMS_OUTPUT.PUT_LINE('-- O usuario '||R_USERS.USERNAME||' esta no profile errado. Efetuar a correcao conforme script abaixo: ');    	  
	    V_ALTER_USER := 'ALTER USER '||R_USERS.USERNAME||' PROFILE PR_DEV DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE '|| V_TEMP_DEFAULT ||' LOCAL TEMPORARY TABLESPACE '|| V_TEMP_DEFAULT ||';';
	    DBMS_OUTPUT.PUT_LINE(V_ALTER_USER);   
	  END IF;
	
	  IF R_USERS.PROFILE LIKE 'PR_MANUT%' OR R_USERS.PROFILE IN ('PR_AD','PR_BI','PR_BIGDATA','PR_DBA','PR_DEV','PR_DS','PR_GOV','PR_SEC','PR_REDASH') THEN
	    IF (R_USERS.DEFAULT_TABLESPACE <> 'USERS' OR R_USERS.TEMPORARY_TABLESPACE <> V_TEMP_DEFAULT 
		 OR R_USERS.LOCAL_TEMP_TABLESPACE <> V_TEMP_DEFAULT) THEN
	      DBMS_OUTPUT.PUT_LINE('-- O usuario '||R_USERS.USERNAME||' tem tablespaces erradas. Efetuar a correcao conforme script abaixo: ');    	  
	      V_ALTER_USER := 'ALTER USER '||R_USERS.USERNAME||' DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE '|| V_TEMP_DEFAULT ||' LOCAL TEMPORARY TABLESPACE '|| V_TEMP_DEFAULT ||';';
	     DBMS_OUTPUT.PUT_LINE(V_ALTER_USER);   		 
		END IF; 	
	  END IF;
	
	  IF R_USERS.PROFILE = 'PR_AD' AND R_USERS.MAX_GB_BYTES < 1 THEN
	    DBMS_OUTPUT.PUT_LINE('-- O usuario '||R_USERS.USERNAME||' com quota pequena na tablespace. Efetuar a correcao conforme script abaixo: ');    	  
	    V_ALTER_USER := 'ALTER USER '||R_USERS.USERNAME||' QUOTA 1G ON USERS;';
	    DBMS_OUTPUT.PUT_LINE(V_ALTER_USER);   
	  END IF;

      -- CONFIGURACOES	

	  IF INSTR(R_USERS.ROLES_USERS,'CONNECT') = 0 THEN
	    DBMS_OUTPUT.PUT_LINE('-- O usuario '||R_USERS.USERNAME||' com permissoes faltantes. Efetuar a correcao conforme script abaixo: ');    	  
	    V_ALTER_USER_ROLE := 'GRANT CONNECT TO '||R_USERS.USERNAME||';';
	    DBMS_OUTPUT.PUT_LINE(V_ALTER_USER_ROLE);   
	  END IF;  
		
	  IF INSTR(R_USERS.ROLES_USERS,'RL_COMPLIANCE_NSA') = 0 THEN
	    DBMS_OUTPUT.PUT_LINE('-- O usuario '||R_USERS.USERNAME||' com permissoes faltantes. Efetuar a correcao conforme script abaixo: ');    	  
	    V_ALTER_USER_ROLE := 'GRANT RL_COMPLIANCE_NSA TO '||R_USERS.USERNAME||';';
	    DBMS_OUTPUT.PUT_LINE(V_ALTER_USER_ROLE);   
      END IF; 

	  IF R_USERS.PROFILE = 'PR_AD' THEN 
		
		IF INSTR(R_USERS.ROLES_USERS,'RL_PERFORMANCE_ANALYZER_EM') = 0 THEN
	      DBMS_OUTPUT.PUT_LINE('-- O usuario '||R_USERS.USERNAME||' com permissoes faltantes. Efetuar a correcao conforme script abaixo: ');    	  
	      V_ALTER_USER_ROLE := 'GRANT EXECUTE ON RL_PERFORMANCE_ANALYZER_EM TO '||R_USERS.USERNAME||';';
	      DBMS_OUTPUT.PUT_LINE(V_ALTER_USER_ROLE);   
		END IF;  
	  
	  END IF;

	END LOOP;	
    DBMS_OUTPUT.PUT_LINE(' ');  
    DBMS_OUTPUT.PUT_LINE(' ');      
	DBMS_OUTPUT.PUT_LINE('OBSERVACAO 1: Fazer uma listagem dos usuarios nominais e validar com o seu gestor quais deles nao estao mais na empresa, para efetuar o bloqueio do usuario!!! Script de exemplo abaixo:');      
	DBMS_OUTPUT.PUT_LINE('ALTER USER <usuarioNominal> ACCOUNT LOCK;');      
	DBMS_OUTPUT.PUT_LINE(' ');      
	DBMS_OUTPUT.PUT_LINE('OBSERVACAO 2: Se houver dados mascarados, os usuarios UBR devem ter permissao de leitura aos dados mascarados. Script de exemplo abaixo:');      
	DBMS_OUTPUT.PUT_LINE('GRANT EXEMPT REDACTION POLICY TO <usuarioUBR>;');      
	
	
	DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE(' ');      

    DBMS_OUTPUT.PUT_LINE('***********************');      
    DBMS_OUTPUT.PUT_LINE('*      SEQUENCES      *'); 
    DBMS_OUTPUT.PUT_LINE('***********************');
	
    FOR R_SEQUENCE IN C_SEQUENCE LOOP	
	  
	  IF R_SEQUENCE.STATUS_SEQUENCE = 'AUMENTAR SEQUENCE' THEN
 	    DBMS_OUTPUT.PUT_LINE('-- A sequence\identity '||R_SEQUENCE.OWNER||'.'||R_SEQUENCE.SEQUENCE||' ultrapassou 80% do limite do range. Aumente o valor máximo da sequence\identity.');	  
	  END IF;	  
	
	END LOOP;
 	
	DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE(' ');  
	
    DBMS_OUTPUT.PUT_LINE('***********************');      
    DBMS_OUTPUT.PUT_LINE('*       TABELAS       *');      	
    DBMS_OUTPUT.PUT_LINE('***********************');    
	
    DBMS_OUTPUT.PUT_LINE(' ');  
    DBMS_OUTPUT.PUT_LINE(' ');      
	DBMS_OUTPUT.PUT_LINE('OBSERVACAO 3: Habilite a monitoria dos indices, para saber se todos estão sendo usados e assim poder apagar os inutilizados.');      
	DBMS_OUTPUT.PUT_LINE(' ');      
	DBMS_OUTPUT.PUT_LINE(' ');      


  FOR R_TAB IN C_TAB LOOP
  
    DBMS_OUTPUT.PUT_LINE(' ');      
    DBMS_OUTPUT.PUT_LINE('***** '||R_TAB.TABLE_NAME||' *****');
	
	V_ALTER_TABLE := 'ALTER TABLE '|| R_TAB.OWNER||'.'||R_TAB.TABLE_NAME;  
	V_EVENT := NULL;	
	V_STATUS_SEQ_CONTENTION := NULL;
	V_STATUS_ALLOCATE_ITL_ENTRY := NULL;
	V_COMMENT_TABLE := NULL;
	V_VAL_CACHE := ROUND(R_TAB.AVG_INSERT_DAY/86400,-3); -- AJUSTE DE ESCALA (MILHAR)
	

-------------------
--  COMENTARIOS  --
-------------------  

    BEGIN 
	  SELECT NVL(CT.COMMENTS,'EMPTY') AS TAB_COMMENT
      INTO V_COMMENT_TABLE
      FROM DBA_TAB_COMMENTS CT
      WHERE CT.OWNER =  R_TAB.OWNER
      AND CT.TABLE_NAME = R_TAB.TABLE_NAME;
	
	  EXCEPTION 
	    WHEN NO_DATA_FOUND THEN
          V_COMMENT_TABLE := 'EMPTY';

        WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('[ERRO]: ' || TO_CHAR(SQLERRM) || CHR(10) || TO_CHAR(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE));
          DBMS_OUTPUT.PUT_LINE('--------------------------------');
	END;

	IF V_COMMENT_TABLE = 'EMPTY' THEN
 	  DBMS_OUTPUT.PUT_LINE('-- A tabela '||R_TAB.OWNER||'.'||R_TAB.TABLE_NAME||' nao tem comentario sobre do que ela se trata.');
	END IF;
	
--------------------------
--  SINONIMOS PUBLICOS  --
--------------------------  

    BEGIN 
      SELECT NVL(LISTAGG(S.OWNER,','),'EMPTY') SYNONYMS
	  INTO V_SYNONYM_PUBLIC
      FROM DBA_SYNONYMS S
      WHERE S.TABLE_OWNER = R_TAB.OWNER
      AND S.TABLE_NAME = R_TAB.TABLE_NAME;
	
	  EXCEPTION 
	    WHEN NO_DATA_FOUND THEN
          V_SYNONYM_PUBLIC := 'EMPTY';

        WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('[ERRO]: ' || TO_CHAR(SQLERRM) || CHR(10) || TO_CHAR(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE));
          DBMS_OUTPUT.PUT_LINE('--------------------------------');
	END;

	IF INSTR(V_SYNONYM_PUBLIC,'PUBLIC') >= 1 THEN
 	  DBMS_OUTPUT.PUT_LINE('-- A tabela '||R_TAB.OWNER||'.'||R_TAB.TABLE_NAME||' tem sinonimo publico. Favor excluir.');
	END IF;

--------------------
--   TABLESPACE   --
--------------------  
	
	IF (R_TAB.TABLE_SPACE NOT LIKE 'TSD%') AND (R_TAB.TABLE_SPACE NOT LIKE 'TSL%') THEN
	
 	  DBMS_OUTPUT.PUT_LINE('-- Alterar a tablespace da tabela '||R_TAB.OWNER||'.'||R_TAB.TABLE_NAME||' para uma tablespace de dados. Script abaixo.');
	  IF R_TAB.PART = 'NO' THEN
    	V_ALTER_TABLE_TABLESPACE := V_ALTER_TABLE ||' MOVE TABLESPACE '|| V_TSD_CORRECT ||' PARALLEL '||V_PARALLEL||';'||CHR(10)||V_ALTER_TABLE||
		' NOPARALLEL;';
        DBMS_OUTPUT.PUT_LINE(V_ALTER_TABLE_TABLESPACE);			
      ELSE
        V_ALTER_TABLE_TABLESPACE := V_ALTER_TABLE ||' MODIFY DEFAULT ATTRIBUTES TABLESPACE '|| V_TSD_CORRECT ||';';        
        DBMS_OUTPUT.PUT_LINE(V_ALTER_TABLE_TABLESPACE);			
      END IF;  	  
	END IF;
	
	IF R_TAB.LOB_TB > 0 THEN
 	  DBMS_OUTPUT.PUT_LINE('-- Tabela '||R_TAB.OWNER||'.'||R_TAB.TABLE_NAME||' com dados LOB. Validar se os campos LOB estao em uma tablespace especifica para campos LOB e compactados.');	  
	END IF;


--------------------
--    INITRANS    --
--------------------  
   /*
     INITRANS prealoca espaco para um número especificado de entradas de transacoes em cada bloco de dados de um objeto. 
	 Assim o Oracle nao precisa alocar espaco dinamicamente para as entradas de transacoes quando as mesmas entrarem nos blocos de dados. 
	 O valor default e 1 em tabelas e 2 em indices. Valor máximo recomendado e 100.
   */
   
    -- Verifica se teve evento de muitas transacoes DML simultaneas competindo pelo mesmo bloco de dados
	V_EVENT := 'enq: TX - allocate ITL entry';
    V_STATUS_ALLOCATE_ITL_ENTRY := F_VERIFY_EVENT(R_TAB.OWNER, R_TAB.TABLE_NAME, V_EVENT);

    IF V_STATUS_ALLOCATE_ITL_ENTRY = 'S' THEN
	
 	  DBMS_OUTPUT.PUT_LINE('-- Evento '||V_EVENT||' acontecendo na tabela '||R_TAB.OWNER||'.'||R_TAB.TABLE_NAME||'. Considere aumentar o parametro INITRANS da tabela e indices.');	
	
	END IF;


-------------------
--    PCTFREE    --
-------------------  
    /*
     O parametro PCTFREE especifica a percentagem de um bloco que será reservada para possíveis atualizacoes de linhas que já existem no bloco. 
	 P.ex., o parametro PCTFREE se especificado como 20% no comando CREATE TABLE, faz com que cada bloco de dado usado para armazenar as linhas 
	 da tabela criada possua 20% de seu espaco reservado para atualizacoes das linhas já existentes. 
	 Portanto, somente 80% dos blocos usados para armazenar as linhas dessa tabela estao disponíveis para novas insercoes de informacoes.	
	 O valor default e 10% em tabelas e indices.
	*/

    IF (R_TAB.AVG_UPDATE_DAY >= R_TAB.AVG_INSERT_DAY) AND V_STATUS_ALLOCATE_ITL_ENTRY = 'S' THEN
	
 	  DBMS_OUTPUT.PUT_LINE('-- Evento '||V_EVENT||' acontecendo na tabela '||R_TAB.OWNER||'.'||R_TAB.TABLE_NAME||' E volume de updates muito alto. Considere aumentar o parametro PCTFREE da tabela e indices.');	
	
	END IF;

--------------------------
--    FK SEM INDICES    --
--------------------------
    /*
    Alem de seguir o padrao de bancos relacionais, de que quando se cria uma FK, se cria um indice, FK sem indice no Oracle gera evento de contencao,
	chamado 'TM - contention'
	*/
 

	FOR R_TAB_FK IN C_TAB_FK(R_TAB.OWNER, R_TAB.TABLE_NAME) LOOP
	
	  IF R_TAB_FK.STATUS = 'UNINDEXED' THEN
 	    DBMS_OUTPUT.PUT_LINE('-- A FK '||R_TAB_FK.CONSTRAINT_NAME||' da tabela '||R_TAB.OWNER||'.'||R_TAB.TABLE_NAME||' nao tem indice. Corrija o problema, criando o indice com os campos da FK.');		  
	  END IF;
	  
	END LOOP;

------------------
  -- INDICES --
------------------  
    FOR R_IND IN C_IND(R_TAB.OWNER, R_TAB.TABLE_NAME, R_TAB.COLUMN_CACHE) LOOP
  
      V_ALTER_INDEX := 'ALTER INDEX '|| R_IND.OWNER||'.'||R_IND.INDEX_NAME; 
    
      IF R_IND.STATUS_TABLESPACE = 'CORRIGIR' OR R_IND.STATUS_INITRANS = 'CORRIGIR' OR R_IND.STATUS_PCT_FREE = 'CORRIGIR' THEN
      
        V_ALTER_INDEX_TABLESPACE := 'ALTER INDEX '|| R_IND.OWNER||'.'||R_IND.INDEX_NAME; 
        V_ALTER_INDEX_INITRANS   := 'ALTER INDEX '|| R_IND.OWNER||'.'||R_IND.INDEX_NAME; 
        V_ALTER_INDEX_PCTFREE    := 'ALTER INDEX '|| R_IND.OWNER||'.'||R_IND.INDEX_NAME; 
        V_VAL_INITRANS           := R_IND.INITRANS_TABLE * 2;
        
        IF V_VAL_INITRANS > 96 THEN
          V_VAL_INITRANS := 96; -- VALOR MÁXIMO RECOMENDADO
        END IF;
  
        -- TABLESPACE      
        IF R_IND.STATUS_TABLESPACE = 'CORRIGIR' THEN
   	      DBMS_OUTPUT.PUT_LINE('-- Alterar a tablespace do indice '||R_IND.OWNER||'.'||R_IND.INDEX_NAME||' para uma tablespace de indices.');		
          IF R_IND.PART = 'NO' THEN
    		V_ALTER_INDEX_TABLESPACE := V_ALTER_INDEX ||' REBUILD TABLESPACE '|| V_TSI_CORRECT ||' PARALLEL '||V_PARALLEL||' ONLINE;'||CHR(10)||V_ALTER_INDEX||
		' NOPARALLEL;';
			DBMS_OUTPUT.PUT_LINE(V_ALTER_INDEX_TABLESPACE);
          ELSE
            V_ALTER_INDEX_TABLESPACE := V_ALTER_INDEX ||' MODIFY DEFAULT ATTRIBUTES TABLESPACE '|| V_TSI_CORRECT ||';';        
			DBMS_OUTPUT.PUT_LINE(V_ALTER_INDEX_TABLESPACE);
          END IF;
        END IF;  

  		  
        -- CACHE SEQUENCE
        -- Verifica se teve evento de espera na sequence pela tabela
	    V_EVENT := 'enq: SQ - contention';
        V_STATUS_SEQ_CONTENTION := F_VERIFY_EVENT(R_IND.OWNER, R_IND.INDEX_NAME, V_EVENT);
      
        IF V_STATUS_SEQ_CONTENTION = 'S' THEN 
    	  DBMS_OUTPUT.PUT_LINE('-- Evento '||V_EVENT||' acontecendo na tabela '||R_IND.OWNER||'.'||R_IND.INDEX_NAME||'. Considere aumentar o cache da sequence da tabela. Script exemplo abaixo: ');	
	      V_ALTER_INDEX_SEQUENCE := V_ALTER_TABLE ||' MODIFY '||R_TAB.COLUMN_CACHE||' GENERATED ALWAYS AS IDENTITY (INCREMENT BY 1 CACHE '|| TO_CHAR(V_VAL_CACHE)||');';
 	      DBMS_OUTPUT.PUT_LINE(V_ALTER_INDEX_SEQUENCE);		
	    END IF;		  
		  
		  
        -- INITRANS
        -- Verifica se teve evento de muitas transacoes DML simultaneas competindo pelo mesmo bloco de dados
    	V_EVENT := 'enq: TX - allocate ITL entry';
        V_STATUS_ALLOCATE_ITL_ENTRY := F_VERIFY_EVENT(R_IND.OWNER, R_IND.INDEX_NAME, V_EVENT);
        IF R_IND.STATUS_INITRANS = 'CORRIGIR' THEN
	  	  IF R_IND.INITRANS_INDEX <> V_VAL_INITRANS THEN
 	        DBMS_OUTPUT.PUT_LINE('-- Valor do parametro INITRANS diferente do dobro do valor da tabela. Corrija o parametro INITRANS do indice. Script abaixo: ');	
            IF R_IND.PART = 'NO' THEN
  		      V_ALTER_INDEX_INITRANS := V_ALTER_INDEX ||' INITRANS '|| TO_CHAR(V_VAL_INITRANS) ||';';
              DBMS_OUTPUT.PUT_LINE(V_ALTER_INDEX_INITRANS);			
            ELSE
              V_ALTER_INDEX_INITRANS := V_ALTER_INDEX ||' MODIFY DEFAULT ATTRIBUTES INITRANS '|| TO_CHAR(V_VAL_INITRANS) ||';';        
              DBMS_OUTPUT.PUT_LINE(V_ALTER_INDEX_INITRANS);			
            END IF;        
		  END IF;
        ELSE
		  IF V_STATUS_ALLOCATE_ITL_ENTRY = 'S' THEN
 	        DBMS_OUTPUT.PUT_LINE('-- Evento '||V_EVENT||' acontecendo no indice '||R_IND.OWNER||'.'||R_IND.INDEX_NAME||'. Considere aumentar o parametro INITRANS do indice. Script exemplo abaixo: ');	
            IF R_IND.PART = 'NO' THEN
  		      V_ALTER_INDEX_INITRANS := V_ALTER_INDEX ||' INITRANS '|| TO_CHAR(V_VAL_INITRANS) ||';';
              DBMS_OUTPUT.PUT_LINE(V_ALTER_INDEX_INITRANS);			
            ELSE
              V_ALTER_INDEX_INITRANS := V_ALTER_INDEX ||' MODIFY DEFAULT ATTRIBUTES INITRANS '|| TO_CHAR(V_VAL_INITRANS) ||';';        
              DBMS_OUTPUT.PUT_LINE(V_ALTER_INDEX_INITRANS);			
            END IF;
          END IF;
		END IF;  
        
        
        -- PCT_FREE
        IF R_IND.STATUS_PCT_FREE = 'CORRIGIR' THEN
		  IF R_IND.PCT_FREE_INDEX <> R_IND.PCT_FREE_TABLE THEN 
            DBMS_OUTPUT.PUT_LINE('-- Valor do parametro PCTFREE diferente do valor da tabela. Corrija o parametro PCTFREE do indice. Script abaixo: ');			  
            IF R_IND.PART = 'NO' THEN
              V_ALTER_INDEX_PCTFREE := V_ALTER_INDEX ||' REBUILD PCTFREE '|| TO_CHAR(R_IND.PCT_FREE_TABLE)||' PARALLEL '||V_PARALLEL||' ONLINE; '||CHR(10)||V_ALTER_INDEX||' NOPARALLEL;';
              DBMS_OUTPUT.PUT_LINE(V_ALTER_INDEX_PCTFREE);
            ELSE
              V_ALTER_INDEX_PCTFREE := V_ALTER_INDEX ||' MODIFY DEFAULT ATTRIBUTES PCTFREE '||  TO_CHAR(R_IND.PCT_FREE_TABLE) ||';';        
              DBMS_OUTPUT.PUT_LINE(V_ALTER_INDEX_PCTFREE);
            END IF;        
		  END IF;
        ELSE  
		  IF V_STATUS_ALLOCATE_ITL_ENTRY = 'S' THEN
 	        DBMS_OUTPUT.PUT_LINE('-- Evento '||V_EVENT||' acontecendo no indice '||R_IND.OWNER||'.'||R_IND.INDEX_NAME||'. Considere aumentar o parametro PCTFREE do indice. Script exemplo abaixo: ');	
            IF R_IND.PART = 'NO' THEN
              V_ALTER_INDEX_PCTFREE := V_ALTER_INDEX ||' REBUILD PCTFREE '|| TO_CHAR(R_IND.PCT_FREE_TABLE)||' PARALLEL '||V_PARALLEL||' ONLINE; '||CHR(10)||V_ALTER_INDEX||' NOPARALLEL;';
              DBMS_OUTPUT.PUT_LINE(V_ALTER_INDEX_PCTFREE);
            ELSE
              V_ALTER_INDEX_PCTFREE := V_ALTER_INDEX ||' MODIFY DEFAULT ATTRIBUTES PCTFREE '||  TO_CHAR(R_IND.PCT_FREE_TABLE) ||';';        
              DBMS_OUTPUT.PUT_LINE(V_ALTER_INDEX_PCTFREE);
            END IF;          
          END IF;
        END IF;  
      END IF;
    END LOOP;
	
------------------
--   COLUNAS    --
------------------



    V_FLG_COMPLIANCE_NSA := 'Y';
	
	FOR R_COLS IN C_COLS(R_TAB.OWNER, R_TAB.TABLE_NAME) LOOP
	
-- TAMANHO DE COLUNA
	  IF R_COLS.DATA_TYPE IN ('NUMBER','VARCHAR2') THEN
  	    IF ROUND(((R_COLS.AVG_COL_LEN * 100) / R_COLS.DATA_LENGTH),4) >=80 THEN
	      DBMS_OUTPUT.PUT_LINE('-- Coluna '||R_COLS.COLUMN_NAME||' com tamanho superior a 80% do seu limite maximo. Aumente o valor do datatype.');	   	  
	    END IF;
	  END IF;

-- REGRAS DE COMPLIANCE

	  IF R_COLS.COL_COMMENT IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('-- Coluna '||R_COLS.COLUMN_NAME||' sem comentario e TAG de compliance. Favor corrigir.');	   	  
	  END IF;
	
	  IF TRIM(R_COLS.TAG) IN ('PII','PCI-DSS','BANKING_SECRECY','STRATEGIC_OPERATIONAL','STRATEGIC_FINANCIAL','ENTERPRISE_SECRECY','PORTABILITY') 
	    AND R_COLS.FUNCTION_TYPE IS NULL AND (INSTR(R_TAB.GRANT_ROLES,'RL_COMPLIANCE_NSA') >= 1) THEN
        V_FLG_COMPLIANCE_NSA := 'N';
        DBMS_OUTPUT.PUT_LINE('-- Coluna '||R_COLS.COLUMN_NAME||' classificada com nivel de sigilo sem regra de mascaramento. Favor corrigir classificacao e permissoes com urgencia!');	   	  
	  END IF;

	END LOOP;	

	IF  V_FLG_COMPLIANCE_NSA = 'Y' AND (INSTR(R_TAB.GRANT_ROLES,'RL_COMPLIANCE_NSA') = 0) THEN
 	  DBMS_OUTPUT.PUT_LINE('-- A tabela '||R_TAB.OWNER||'.'||R_TAB.TABLE_NAME||' nao tem permissao na role RL_COMPLIANCE_NSA. Favor corrigir.');
    END IF;	  
	
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE(' ');      
  DBMS_OUTPUT.PUT_LINE(' ');      
  DBMS_OUTPUT.PUT_LINE(' ');      
  DBMS_OUTPUT.PUT_LINE(' ');  
	
  DBMS_OUTPUT.PUT_LINE('***********************');      
  DBMS_OUTPUT.PUT_LINE('*       EVENTOS       *');      	
  DBMS_OUTPUT.PUT_LINE('***********************');    
  DBMS_OUTPUT.PUT_LINE(' '); 
  DBMS_OUTPUT.PUT_LINE('-- Analisar queries abaixo: '); 
  DBMS_OUTPUT.PUT_LINE(' ');   
  
-----------------
--   EVENTOS   --
-----------------  
  
  FOR R_QUERIES IN C_QUERIES LOOP
  
    V_EVENTS_QUERIE := NULL;
	V_EXPLAIN_PLAN := '''SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_AWR('''||R_QUERIES.SQL_ID||'''));'''||' OU '||CHR(10)||
	                  '''SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR('''||R_QUERIES.SQL_ID||''',0));''';
	
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE(' ');	  
    DBMS_OUTPUT.PUT_LINE('SQL_ID: '||R_QUERIES.SQL_ID);
  
	FOR R_EVENTS_QUERIES IN C_EVENTS_QUERIES(R_QUERIES.SQL_ID) LOOP
	  V_EVENTS_QUERIE := V_EVENTS_QUERIE||R_EVENTS_QUERIES.EVENT_QUERIE||CHR(10);
	END LOOP; 
   
    V_EVENTS_QUERIE := 'Eventos: '||V_EVENTS_QUERIE;	
    DBMS_OUTPUT.PUT_LINE(V_EVENTS_QUERIE);
    DBMS_OUTPUT.PUT_LINE(' '); 	  
    DBMS_OUTPUT.PUT_LINE('Ver plano de execucao: '||V_EXPLAIN_PLAN);  
  END LOOP;

END;
/