select nspname,relname,pg_size_pretty(pg_relation_size(c.oid)) as "size"
from pg_class c
left join pg_namespace n 
on n.oid = c.relnamespace
where relname like '%transaction_installment%'
and relname not like '%history%';

SELECT
    pg_size_pretty (
        pg_tablespace_size ('tsdfidc01')
    );