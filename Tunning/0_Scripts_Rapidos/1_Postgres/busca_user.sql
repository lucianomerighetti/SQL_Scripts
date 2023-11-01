SELECT usename AS role_name, useconfig AS config
FROM pg_catalog.pg_user
where (usename not like '_gov%' and usename not like 'rds_%' and usename not like 'r_%' and usename not like '%dba%' and usename not like 'manut_%' and usename not like 'pg_%' and usename not like '%ubr%' and usename not like '%adm%' and usename not like 'rl_%')
union
select rolname, rolconfig
from pg_catalog.pg_roles
where (rolname not like '_gov%' and rolname not like 'rds_%' and rolname not like 'r_%' and rolname not like '%dba%' and rolname not like 'manut_%' and rolname not like 'pg_%' and rolname not like '%ubr%'  and rolname not like '%adm%' and rolname not like 'rl_%')
ORDER BY role_name asc;