-- Oracle
select lower(username) as User_bd
from dba_users
--where profile in ('PR_DEV','PR_AD')
order by created desc
