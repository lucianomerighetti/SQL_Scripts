select replace(event,' ','_') event, seconds_in_wait
from gv$session_wait
where event like '%gc cr multi block request%'
and seconds_in_wait > 5;


prompt ===============================================================================
prompt 	EVENTOS WAIT
prompt ===============================================================================
SELECT   i.instance_name, w.SID, w.event, COUNT (*), SUM (seconds_in_wait)
   FROM gv$instance i,gv$session_wait w
  WHERE
  i.inst_id = w.inst_id and
  event not like 'Streams AQ%' and
  event not like 'queue messages%' and
  event not like 'SQL*Net%' and
  (w.inst_id, SID) IN (SELECT inst_id, SID
                             FROM gv$session
                            WHERE status = 'ACTIVE' AND username IS NOT NULL)
GROUP BY i.instance_name,w.SID,event
ORDER BY 5,3 DESC;

col MACHINE for a30
set lines 1000 trims on
alter session set nls_date_format='dd-mm-hh24:mi';
alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';
select   machine, username, sql_id, status, LOGON_TIME  from gv$session where event='enq: US - contention' group by  status, machine, username, sql_id, LOGON_TIME order by LOGON_TIME, status  ;


SELECT  vs.username ,
        vsw.wait_class,
        vsw.EVENT AS wait_type ,
        vsw.WAIT_TIME_MICRO / 1000 AS wait_time_ms ,
        vsw.TIME_REMAINING_MICRO / 1000 AS time_remaining_ms ,
        vsw.STATE ,
        de.SEGMENT_NAME ,
        de.SEGMENT_TYPE, 
        de.OWNER ,
        de.TABLESPACE_NAME
FROM    V$SESSION_WAIT vsw
        JOIN V$SESSION vs ON vsw.SID = vs.SID
        LEFT JOIN DBA_EXTENTS de ON vsw.p1 = de.file_id
                                    AND vsw.p2 BETWEEN de.BLOCK_ID AND (de.BLOCK_ID + de.BLOCKS)
WHERE   vsw.wait_class <> 'Idle'
        AND vs.username IS NOT NULL 
ORDER BY wait_time_ms DESC;