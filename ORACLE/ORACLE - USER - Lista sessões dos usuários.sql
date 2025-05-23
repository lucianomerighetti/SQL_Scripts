--------------------------------------------------------------------------------
select b.osuser,
       a.sid,
       b.username,
       --a.type,d.name||'.'||c.name name,
       c.name,
       a.id1,
       a.id2,
       decode(lmode,1,'null',2,'RS',3,'RX',4,'S',5,'SRX',6,'X',0,'NONE',lmode) lmode,
       decode(request,1,'null',2,'RS',3,'RX',4,'S',5,'SRX',6,'X',0,'NONE',request) request
  from v$lock a,
       v$session b,
       sys.obj$ c
       --sys.user$ d
 where b.username = 'RECEIVABLESUBR'
--   and b.osuser not in ('oracle', 'root', 'kps_lmarwell')
   and a.id1    = c.obj# (+)
   and a.sid    = b.sid
   --and c.owner# = d.user# (+)
   and b.username is not null
 order by 1;
--------------------------------------------------------------------------------
select h.session_id sessao_travadora,
       ub.osuser    usuario_travador ,
       w.session_id sessao_esperando,
       uw.osuser    usuario_esperando,
       w.lock_type,
       h.mode_held,
       w.mode_requested,
       w.lock_id1,
       w.lock_id2
  from dba_locks w,
       dba_locks h,
       v$session ub,
       v$session uw
 where ub.osuser = 'root'
-- where ub.osuser not in ('oracle', 'root', 'kps_lmarwell')
--   and h.blocking_others = 'Blocking'
--   and h.mode_held       <> 'None'
--   and h.mode_held       <> 'Null'
   and h.session_id      = ub.sid
--   and w.mode_requested  <> 'None'
   and w.lock_type       = h.lock_type
   and w.lock_id1        = h.lock_id1
   and w.lock_id2        = h.lock_id2
   and w.session_id      = uw.sid
 order by 2, 1;
--------------------------------------------------------------------------------
select username,
       account_status
  from sys.dba_users
 where username = 'AD_LUCIANO';
--------------------------------------------------------------------------------