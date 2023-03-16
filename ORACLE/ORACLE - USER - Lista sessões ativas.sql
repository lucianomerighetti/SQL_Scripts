select *
  from v$session
 where username = 'RECEIVABLESUBR'
order by 4, 3, 5, 6, 8;
--------------------------------------------------------------------------------
select sid,
       serial#,
       osuser,
       username,
       schemaname,
       program,
       lockwait,
       logon_time,
       machine,
       status,
       'alter system kill session ''' || sid || ', ' || serial# || ''' immediate;' comando
  from v$session
-- where username = 'KAFKA_RECEIVABLESUBR'
-- where (osuser not in ('oracle', 'root', 'kps_lmarwell') and username = 'RECEIVABLESUBR')
-- where osuser = 'idd_mfelix'
-- where osuser not in ('oracle', 'root', 'kps_lmarwell')
--   and username not in ('AD', 'MANUT_RECEIVABLES', 'SYSTEM')
order by 4, 3, 5, 6, 8;
--------------------------------------------------------------------------------
select username,
       osuser,
       --program,
       count(1) sessoes,
       limit    limite      
  from v$session vs
       left join (
                  select substr(profile, 4, length(profile)) name,
                         profile,
                         resource_name,
                         limit
                     from
                         dba_profiles
                     where
                         profile like 'PR%'
                         and resource_name = 'SESSIONS_PER_USER'
                 ) pf on (pf.name = vs.username)
 group by osuser, username, limit--, program
 order by osuser, username;
--------------------------------------------------------------------------------

select profile,
       resource_name,
       limit
  from dba_profiles
 where profile like 'PR%'
   and resource_name = 'SESSIONS_PER_USER'
 order by 1;