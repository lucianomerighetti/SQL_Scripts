alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';
-- Exadata
SELECT /*+ RULE */ 
substr(DECODE(l.request,0,'Blkdor**: ','Blkdos: ')||l.sid,1,20) sessao, 
'alter system kill session '''|| s.sid||','||s.serial#||',@1'''||' imediate;' KILL,
l.inst_id instance, s.machine, s.sql_id, s.sid, s.serial#, s.username, s.status, s.logon_time, ctime
FROM GV$LOCK l,gv$session s, gv$process p
WHERE l.sid=s.sid
and l.inst_id=s.inst_id 
and s.paddr = p.addr
and s.inst_id=p.inst_id
and (l.id1, l.id2, l.type) IN
   (SELECT id1, id2, type FROM GV$LOCK WHERE request>0)
	 ORDER BY l.request,l.inst_id,l.id1, l.request;
	 
-- Outros	 
SELECT /*+ RULE */ substr(DECODE(l.request,0,'Blkdor**: ','Blkdos: ')||l.sid,1,20) sessao, '!kill -9 '|| p.spid KILL,
	   l.inst_id instance, s.machine, s.sql_id, s.sid, s.serial#, s.username, s.status, s.logon_time, ctime
FROM GV$LOCK l,gv$session s, gv$process p
WHERE l.sid=s.sid
and l.inst_id=s.inst_id 
and s.paddr = p.addr
and s.inst_id=p.inst_id
and (l.id1, l.id2, l.type) IN
   (SELECT id1, id2, type FROM GV$LOCK WHERE request>0)
	 ORDER BY l.request,l.inst_id,l.id1, l.request;
