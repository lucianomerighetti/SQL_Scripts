select session_id "sid",c.SERIAL#  "Serial",
p.spid,
substr(object_name,1,20) "Object",
  substr(os_user_name,1,10) "Terminal",
  substr(oracle_username,1,10) "Locker",
  nvl(lockwait,'active') "Wait",
 -- to_char(logon_time, 'dd/mm/rr hh24:mi:ss') "Logon",
  last_call_et "Last call(seg)",
  substr(c.status, 1, 1) "STATUS",
  --c.inst_id,
  decode(locked_mode,
    2, 'row share',
    3, 'row exclusive',
    4, 'share',
    5, 'share row exclusive',
    6, 'exclusive',  'unknown') "Lockmode",
---   program as programa,
  OBJECT_TYPE "Type"
FROM
  SYS.V_$LOCKED_OBJECT A,
  SYS.ALL_OBJECTS B,
  SYS.V_$SESSION c, 
 sys.v_$process p
WHERE
  A.OBJECT_ID = B.OBJECT_ID AND
  P.ADDR = c.PADDR and
  C.SID = A.SESSION_ID and 
  C.USERNAME = 'CAYMANUBR'
ORDER BY 1 ASC, 5 Desc
/