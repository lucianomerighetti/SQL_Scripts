SELECT bl.pid     AS blocked_pid,
     a.usename  AS blocked_user,
     kl.pid     AS blocking_pid,
     ka.usename AS blocking_user,
     a.query    AS blocked_statement
FROM  pg_catalog.pg_locks         bl
 JOIN pg_catalog.pg_stat_activity a  ON a.pid = bl.pid
 JOIN pg_catalog.pg_locks         kl ON kl.transactionid = bl.transactionid AND kl.pid != bl.pid
 JOIN pg_catalog.pg_stat_activity ka ON ka.pid = kl.pid
WHERE NOT bl.granted;