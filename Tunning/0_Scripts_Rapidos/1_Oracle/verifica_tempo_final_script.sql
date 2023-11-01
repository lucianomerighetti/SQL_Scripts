alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';

SELECT ''''||SID||','||SERIAL#||',@'||INST_ID||'''' AS "SESSION"
  , replace(opname,'Fast Full Scan','FFScan') OPNAME
  , TARGET
  , SOFAR
  , TOTALWORK
  , ELAPSED_SECONDS ELAP
  , TIME_REMAINING REM
  , ELAPSED_SECONDS+ TIME_REMAINING TOTAL
  --, decode(totalwork,0,totalwork,sofar*100/(sofar+(totalwork-sofar))) "%"
  , decode(totalwork,0,totalwork,ROUND(sofar/totalwork*100, 2)) "%"
  , to_char(start_time,'hh24:mm:ss dd/mm') "START"
  , to_char(last_update_time,'hh24:mm:ss dd/mm') last_update 
  , sysdate + TIME_REMAINING / 3600 / 24 Entimated_End_Time
FROM GV$SESSION_LONGOPS
WHERE SOFAR != TOTALWORK
order by INST_ID, sid;


SELECT sid, serial#, opname, target, sofar, totalwork, start_time, trunc(time_remaining/60, 2) as FALTA_MINUTOS, message
  from v$session_longops
 where username like upper('%&USERNAME%')
   and time_remaining > 0
 order by time_remaining