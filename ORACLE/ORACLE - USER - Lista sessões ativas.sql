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
 where username = 'MANUT_RECEIVABLES'
-- where (osuser not in ('oracle', 'root', 'kps_lmarwell') and username = 'RECEIVABLESUBR')
-- where osuser = 'idd_mfelix'
-- where osuser not in ('oracle', 'root', 'kps_lmarwell')
--   and username not in ('AD', 'MANUT_RECEIVABLES', 'SYSTEM')
order by 4, 3, 5, 6, 8;
--------------------------------------------------------------------------------
select vs.username,
       vs.osuser,
       vs.program,
       count(1) sessoes,
       pspu.sessions_per_user,
       pil.idle_time,
       count(decode(vs.status, 'ACTIVE',   1, null)) active,
       count(decode(vs.status, 'INACTIVE', 1, null)) inactive,
       count(decode(vs.status, 'KILLED',   1, null)) killed
  from v$session vs
       left join (
                  select substr(profile, 4, length(profile)) name,
                         profile,
                         resource_name,
                         limit sessions_per_user
                    from sys.dba_profiles
                   where profile like 'PR%'
                     and resource_name = 'SESSIONS_PER_USER'
                 ) pspu on (pspu.name = vs.username)
       left join (
                  select substr(profile, 4, length(profile)) name,
                         profile,
                         resource_name,
                         limit idle_time
                    from sys.dba_profiles
                   where profile like 'PR%'
                     and resource_name = 'IDLE_TIME'
                 ) pil on (pil.name = vs.username)
 where vs.osuser not in ('oracle')
-- where vs.osuser not in ('oracle', 'root', 'kps_lmarwell')
--   and vs.username = 'KAFKA_RECEIVABLESUBR' --'MANUT_RECEIVABLES'
 group by vs.osuser,
          vs.username,
          program,
          pspu.sessions_per_user,
          pil.idle_time
 order by vs.osuser,
          vs.username,
          program,
          pspu.sessions_per_user,
          pil.idle_time;
--------------------------------------------------------------------------------

select profile,
       resource_name,
       limit
  from dba_profiles
 where profile like 'PR%'
   and resource_name = 'SESSIONS_PER_USER'
 order by 1;