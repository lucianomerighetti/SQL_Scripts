DROP TABLE RECEIVABLES_ADM.LOG_KILL_SESSION;

CREATE TABLE RECEIVABLES_ADM.LOG_KILL_SESSION (
VAL_SID             NUMBER,
VAL_SERIAL          NUMBER,
VAL_OSUSER          VARCHAR2(128), 
VAL_USERNAME        VARCHAR2(128),
DAT_LOGON_TIME      DATE,
DAT_ACTION_TIME     DATE,
IND_STATUS          VARCHAR(2000)
);


CREATE OR REPLACE PROCEDURE RECEIVABLES_ADM.P_KILL_SESSION_INATIVE 
IS

      V1_SID NUMBER;
      V1_SERIAL NUMBER;
      V1_OSUSER VARCHAR2(128);
      V1_USERNAME VARCHAR2(128);
      V1_LOGON_TIME DATE;
      V1_SQLERRM VARCHAR2(2000);
      CURSOR C1 IS
         SELECT S.SID, S.SERIAL#, S.OSUSER, S.USERNAME, S.LOGON_TIME
         FROM V$SESSION S -- GV por ser RAC, se for PDB pode ser V
         WHERE S.STATUS = 'INACTIVE'
         AND S.LAST_CALL_ET > 1800
         AND S.USERNAME not in ('%UBR','%ADM');
   BEGIN
      OPEN C1;
      LOOP
         FETCH C1 INTO V1_SID, V1_SERIAL, V1_OSUSER, V1_USERNAME, V1_LOGON_TIME;
      EXIT WHEN C1%NOTFOUND;
         BEGIN

            INSERT INTO RECEIVABLES_ADM.LOG_KILL_SESSION (
            VAL_SID,
            VAL_SERIAL,
            VAL_OSUSER, 
            VAL_USERNAME,
            DAT_LOGON_TIME,
            DAT_ACTION_TIME)
            VALUES (V1_SID,
            V1_SERIAL,
            V1_OSUSER,
            V1_USERNAME,
            V1_LOGON_TIME,
            SYSDATE
            );
            COMMIT;
         
            EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ' || '''' || V1_SID || ',' || V1_SERIAL || '''' || ',@1 IMMEDIATE' ;


         EXCEPTION
            WHEN OTHERS THEN
                V1_SQLERRM := SQLERRM;
                
                INSERT INTO RECEIVABLES_ADM.LOG_KILL_SESSION (
                    VAL_SID,
                    VAL_SERIAL,
                    VAL_OSUSER, 
                    VAL_USERNAME,
                    DAT_LOGON_TIME,
                    DAT_ACTION_TIME,
                    IND_STATUS)
                VALUES (V1_SID,
                V1_SERIAL,
                V1_OSUSER,
                V1_USERNAME,
                V1_LOGON_TIME,
                SYSDATE,
                V1_SQLERRM
                );
                COMMIT;
               
         END;
      END LOOP;
      CLOSE C1;
   END;
   /
   

--EXCLUIR O JOB em QA
BEGIN
  dbms_scheduler.drop_job(job_name => 'RECEIVABLES_ADM.JOB_KILL_SESSION_INATIVE');
END;
/
  
  
--CRIAR JOB PARA AGENDAR EXECUCAO
begin
dbms_scheduler.create_job(
        job_name => 'JOB_KILL_SESSION_INATIVE',
        job_type => 'PLSQL_BLOCK',
        job_action => 'begin RECEIVABLES_ADM.P_KILL_SESSION_INATIVE; end;',
        start_date => SYSTIMESTAMP,
        repeat_interval => 'FREQ=HOURLY; INTERVAL=1',
        enabled => TRUE,
        auto_drop => FALSE,
        comments => 'Matar as sessões inativas há mais de meia hora. Executada a cada hora'
);
end;
/  
   
-------------------------------------------------------------------------------------
-- VALIDAÇÃO
-------------------------------------------------------------------------------------
/*
-- validar status do job
select * from dba_objects 
	where object_name = 'P_KILL_SESSION_INATIVE';



-- validar se o job foi criado:
select owner as schema_name,
       job_name,
       job_style,
       case when job_type is null 
                 then 'PROGRAM'
            else job_type end as job_type,  
       case when job_type is null
                 then program_name
                 else job_action end as job_action,
       start_date,
       case when repeat_interval is null
            then schedule_name
            else repeat_interval end as schedule,
       last_start_date,
       next_run_date,
       state
from dba_scheduler_jobs
where job_name = 'JOB_KILL_SESSION_INATIVE'
order by owner,
         job_name;


-- validar se job rodou corretamente:
select * 
   from dba_scheduler_job_run_details
   where job_name = 'JOB_KILL_SESSION_INATIVE'
   order by log_date desc;

*/



select *
from RECEIVABLES_ADM.LOG_KILL_SESSION;