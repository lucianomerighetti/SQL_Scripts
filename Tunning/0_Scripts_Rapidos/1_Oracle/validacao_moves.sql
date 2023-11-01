select owner
,table_name
,partitioned
,status
,degree
,compression
,compress_for
from dba_tables
where owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
order by 4,5;

select owner
,table_name
,index_name
,partitioned
,status
,degree
,visibility
,compression
from dba_indexes
where owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
order by 4,5;

select distinct index_owner
,index_name
,status
,compression
from dba_ind_partitions
where index_owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
order by 3;

select owner,constraint_name,table_name,status
from dba_constraints
where owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
and constraint_type = 'R'
order by 4;