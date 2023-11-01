-- Verificar profile do usuário => RPP e PHO = profile MANUT_SAFEPAY
select *
from dba_users
where username = ;

-- Verificar privilegios de tabelas  => RPP e PHO = role RL_MANUT_SAFEPAY 

select *
from dba_tab_privs
where table_name = ;

-- Verificar as roles de um usuario => RPP = roles MANUT e SAFEPAY / PHO = RL_MANUT_SAFEPAY  ==> TODAS COM DEFAULT_ROLE = YES

select *
from dba_role_privs
where grantee = ;

-- Verificar privilegios de um usuario

select * 
from DBA_TAB_PRIVS
where GRANTEE in (	select granted_role 
					from dba_role_privs
					where GRANTEE = );


-- grant de tabela a role

grant select on nome_table to nome_role;

-- grant de usuario em role

grant nome_role to nome_usuario;

-- alteracao de default role a usuario

alter user nome_usuario default role all ;

-- verificar acessos ADs
select * from session_privs;


set head off
select ' :: GRANTS SISTEMA ::' from dual;
set head on
SELECT GRANTEE, PRIVILEGE
FROM DBA_SYS_PRIVS
WHERE GRANTEE = upper('SMOREIRA');


set head off
select ' :: GRANTS TABLE ::' from dual;
set head on
SELECT GRANTEE, OWNER, GRANTOR, TABLE_NAME, PRIVILEGE
FROM DBA_TAB_PRIVS
WHERE GRANTEE = upper('SMOREIRA');

set head off
select ' :: GRANT ROLE ::' from dual;
set head on
SELECT GRANTEE, GRANTED_ROLE
FROM DBA_ROLE_PRIVS
WHERE GRANTEE = upper('SMOREIRA');

set head off
select ' :: QUOTAS ::' from dual;
set head on
SELECT TABLESPACE_NAME, USERNAME, bytes/1024/1024/1024 as "GB_bytes", max_bytes/1024/1024/1024 as "max_GB_bytes"
FROM dba_ts_quotas
WHERE USERNAME = upper('SMOREIRA');