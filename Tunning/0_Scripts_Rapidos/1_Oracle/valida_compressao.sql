-- tabelas não particionadas

select t.owner
,t.table_name
,t.tablespace_name
,t.compression
,t.compress_for
from dba_tables t
where t.owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM';

select l.owner
,l.table_name
,l.column_name
,l.segment_name
,l.tablespace_name
,l.compression
,l.securefile
from dba_lobs l
where l.owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM';


-- tabelas particionadas

select pt.owner
,pt.table_name
,pt.def_tablespace_name
,pt.def_compression
,pt.def_compress_for
from dba_part_tables pt
where pt.owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM';

select tp.table_owner
,tp.table_name
,tp.tablespace_name
,tp.num_rows
,tp.compression
,tp.compress_for
,round(s.bytes/1024/1024,2) tam_mb
from dba_tab_partitions tp
inner join dba_segments s
on tp.table_owner = s.owner
and tp.table_name = s.segment_name
and tp.partition_name = s.partition_name
where tp.table_owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM';

select l.owner
,l.table_name
,l.column_name
,l.tablespace_name
,l.compression
,l.securefile
from dba_lobs l
where l.owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM';

select lp.table_owner
,lp.table_name
,lp.column_name
,lp.lob_name
,lp.tablespace_name
,lp.compression
,lp.securefile
,count(*)
from dba_lob_partitions lp
where lp.table_owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
group by lp.table_owner
,lp.table_name
,lp.column_name
,lp.lob_name
,lp.tablespace_name
,lp.compression
,lp.securefile;