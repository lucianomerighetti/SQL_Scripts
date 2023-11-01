select execution_name
,to_char(execution_start,'dd-mm-yyyy') as execution_start
,status
,error_message
from dba_advisor_executions
where task_name='SYS_AUTO_SQL_TUNING_TASK'
and to_char(execution_start,'dd-mm-yyyy') = to_char(sysdate-1,'dd-mm-yyyy')
order by execution_id desc;


select *
from DBA_ADVISOR_ACTIONS
where task_name='SYS_AUTO_SQL_TUNING_TASK';