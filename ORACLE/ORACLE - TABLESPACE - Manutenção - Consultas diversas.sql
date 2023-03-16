-- ORACLE - TABLESPACE - Estimatina de tamanho
select f.tablespace_name,
       to_char((t.total_space - f.free_space), '999,999') USED_MB,
       to_char(f.free_space, '999,999') FREE_MB,
       to_char(t.total_space, '999,999') TOTAL_MB,
       to_char((round((f.free_space / t.total_space) * 100)), '999') || ' %' "FREE_%"
  from (select tablespace_name,
               round(sum(blocks * (select value / 1024
                                     from v$parameter
                                    where name = 'db_block_size') / 1024)) free_space
          from dba_free_space
         group by tablespace_name) f,
       (select tablespace_name, round(sum(bytes / 1048576)) total_space
          from dba_data_files
         group by tablespace_name) t
 where f.tablespace_name = t.tablespace_name
   and f.tablespace_name like 'TS_REC%'
 order by f.tablespace_name;

select * from SYS.dba_tab_partitions;
select distinct table_owner, table_name, tablespace_name from SYS.dba_tab_partitions where table_owner = 'AD' and table_name like'%OUTBOX%';
select distinct table_owner, table_name, tablespace_name from SYS.dba_tab_partitions where table_owner = 'RECEIVABLES_ADM' and table_name like'%OUTBOX%';

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- ORACLE - TABLESPACE - Recupera tamanho

select t.tablespace_name,
       t.status,
       t.contents
  from sys.dba_tablespaces t
order by 1, 2, 3;
  
select t.tablespace_name,
       t.status,
       t.contents,
       f.file_name,
       f.file_id,
       f.bytes,
       f.user_bytes,
       s.owner,
       s.segment_type,
       s.segment_name,
       sum(s.bytes) bytes_do_segmento
  from sys.dba_tablespaces            t
       inner join sys.dba_data_files  f on (t.tablespace_name = f.tablespace_name)
       inner join sys.dba_extents     s on (f.tablespace_name = s.tablespace_name and
                                            f.file_id         = s.file_id)
 where 1 = 1
   and t.tablespace_name = 'TSIRECEIVABLES06'
group by t.tablespace_name,
         t.status,
         t.contents,
         f.file_name,
         f.file_id,
         f.bytes,
         f.user_bytes,
         s.owner,
         s.segment_type,
         s.segment_name
order by 1, 5, 8, 9, 10;

select f.file_id,
       t.tablespace_name,
       t.status,
       t.contents,
       f.file_name,
       --f.bytes,
       --f.user_bytes,
       count(distinct s.owner ||'.' || s.segment_type ||'.' || s.segment_name) total_objetos,
       sum(s.bytes) tamanho_segmento_bytes
  from sys.dba_tablespaces            t
       inner join sys.dba_data_files  f on (t.tablespace_name = f.tablespace_name)
       inner join sys.dba_extents     s on (f.tablespace_name = s.tablespace_name and
                                            f.file_id         = s.file_id)
 where 1 = 1
   and t.tablespace_name like 'TS_REC%'
group by f.file_id,
         t.tablespace_name,
         t.status,
         t.contents,
         f.file_name
         --f.bytes,
         --f.user_bytes
order by 1, 2;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- ORACLE - TABLESPACES - PARTITION - Mover Tablespaces

-- TABLE DROP/TRUNCATE PARTITION
select tp.table_owner,
       tp.table_name,
       tp.partition_position,
       tp.partition_name,
       decode(tp.partition_name, 'P_1', 1, to_number(substr(tp.partition_name, 6, length(tp.partition_name)))) partition_number,
       tp.num_rows,
       to_date(substr(extractvalue(dbms_xmlgen.getxmltype('select high_value '           ||
                                                          'from sys.dba_tab_partitions ' ||
                                                          'where partition_name = '''    || tp.partition_name || '''' ||
                                                          ' and table_name = '''         || tp.table_name     || '''' ||
                                                          ' and table_owner = '''        || tp.table_owner    || ''''), '//text()'), 12, 10), 'yyyy-mm-dd') high_value_date,
       'ALTER TABLE ' || tp.table_owner || '.' || tp.table_name || ' DROP PARTITION ' || tp.partition_name || ' UPDATE INDEXES PARALLEL 48;' script_drop,
       'ALTER TABLE ' || tp.table_owner || '.' || tp.table_name || ' TRUNCATE PARTITION ' || tp.partition_name || ' UPDATE INDEXES PARALLEL 48;' script_truncate
  from sys.dba_tab_partitions tp
 where 1 = 1
--   and tp.tablespace_name = 'TSDRECEIVABLES06'
   and tp.table_owner     = 'RECEIVABLES_ADM'
   and tp.table_name      = 'PAYMENT_INTENT'
 order by 1, 2, 3, 4 ,5;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- TABLE MOVE PARTITION
select tp.table_owner,
       tp.table_name,
       tp.partition_position,
       tp.partition_name,
       decode(tp.partition_name, 'P_1', 1, to_number(substr(tp.partition_name, 6, length(tp.partition_name)))) partition_number,
       tp.num_rows,
       to_date(substr(extractvalue(dbms_xmlgen.getxmltype('select high_value '           ||
                                                          'from sys.dba_tab_partitions ' ||
                                                          'where partition_name = '''    || tp.partition_name || '''' ||
                                                          ' and table_name = '''         || tp.table_name     || '''' ||
                                                          ' and table_owner = '''        || tp.table_owner    || ''''), '//text()'), 12, 10), 'yyyy-mm-dd') high_value_date,
       'ALTER TABLE ' || tp.table_owner || '.' || tp.table_name || ' MOVE PARTITION '    || tp.partition_name || ' TABLESPACE TSDRECEIVABLES20 PARALLEL 48 ONLINE;'  script_move_tablespace,
       'ALTER TABLE ' || tp.table_owner || '.' || tp.table_name || ' MOVE PARTITION '    || tp.partition_name || ' PARALLEL 48 ONLINE;'  script
  from sys.dba_tab_partitions tp
 where 1 = 1
--   and tp.tablespace_name = 'TSDRECEIVABLES06'
   and tp.table_owner     = 'RECEIVABLES_ADM'
   and tp.table_name      = 'PAYMENT_INTENT'
 order by 1, 2, 3, 4 ,5;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- INDEX LOCAL REBUILD PARTITION
select ip.index_owner,
       ip.index_name,
       ip.partition_position,
       ip.partition_name,
       ip.tablespace_name,
       decode(ip.partition_name, 'P_1', 1, to_number(substr(ip.partition_name, 6, length(ip.partition_name)))) partition_number,
       to_date(substr(extractvalue(dbms_xmlgen.getxmltype('select high_value '           ||
                                                          'from sys.dba_ind_partitions ' ||
                                                          'where partition_name = '''    || ip.partition_name || '''' ||
                                                          ' and index_owner = '''        || ip.index_owner    || '''' ||
                                                          ' and index_name = '''         || ip.index_name     || ''''), '//text()'), 12, 10), 'yyyy-mm-dd') high_value_date,
       'ALTER INDEX ' || ip.index_owner || '.' || ip.index_name || ' REBUILD PARTITION ' || ip.partition_name || ' TABLESPACE TSIRECEIVABLES20 PARALLEL 48 ONLINE;'  script_move_tablespace,
       'ALTER INDEX ' || ip.index_owner || '.' || ip.index_name || ' REBUILD PARTITION ' || ip.partition_name || ' PARALLEL 48 ONLINE;'  script
  from sys.dba_ind_partitions ip
 where 1 = 1
--   and ip.tablespace_name = 'TSIRECEIVABLES06'
   and ip.index_owner     = 'RECEIVABLES_ADM'
   and ip.index_name in (select i.index_name
                            from sys.dba_indexes i
                           where i.partitioned = 'YES'
                             and i.owner       = 'RECEIVABLES_ADM'
                             and i.table_name  = 'PAYMENT_INTENT')
 order by 1, 2, 3, 4 ,5;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- INDEX GLOBAL REBUILD
select i.owner,
       i.table_name,
       i.index_name,
       i.tablespace_name,
       'ALTER INDEX ' || i.owner || '.' || i.index_name || ' COALESCE CLEANUP PARALLEL 48;' script_coalesce_cleanup,
       'ALTER INDEX ' || i.owner || '.' || i.index_name || ' REBUILD TABLESPACE TSIRECEIVABLES20 PARALLEL 48 ONLINE;' script_move_tablespace,
       'ALTER INDEX ' || i.owner || '.' || i.index_name || ' REBUILD PARALLEL 48 ONLINE;'  script_rebuild
  from sys.dba_indexes i
 where 1 = 1
   and i.partitioned     = 'NO'
--   and i.tablespace_name = 'TSIRECEIVABLES06'
   and i.owner       = 'RECEIVABLES_ADM'
   and i.table_name  = 'PAYMENT_INTENT'
 order by i.owner,
          i.table_name,
          i.index_name;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- LOB PARTITION
select lp.table_owner,
       lp.table_name,
	   lp.lob_name,
	   lp.partition_position,
       lp.partition_name,
	   lp.lob_partition_name,
	   l.column_name,
       decode(lp.lob_partition_name, 'P_1', 1, to_number(substr(lp.lob_partition_name, 10, length(lp.lob_partition_name)))) partition_number,
       to_date(substr(extractvalue(dbms_xmlgen.getxmltype('select high_value '           ||
                                                          'from sys.dba_tab_partitions ' ||
                                                          'where partition_name = '''    || lp.partition_name || '''' ||
                                                          ' and table_owner = '''        || lp.table_owner    || '''' ||
                                                          ' and table_name = '''         || lp.table_name     || ''''), '//text()'), 12, 10), 'yyyy-mm-dd') high_value_date,
	   'ALTER TABLE ' || lp.table_owner || '.' || lp.table_name || ' MOVE PARTITION '    || lp.partition_name || ' LOB(' || l.column_name || ') STORE AS (TABLESPACE TSLRECEIVABLES20) PARALLEL 48 ONLINE;' script
  from sys.dba_lob_partitions  lp
       inner join sys.dba_lobs l  on (lp.table_owner = l.owner      and 
                                      lp.table_name  = l.table_name and
									  lp.lob_name    = l.segment_name)
 where 1 = 1
   and lp.tablespace_name = 'TSLRECEIVABLES06'
   and lp.table_owner     = 'RECEIVABLES_ADM'
   and lp.table_name      = 'PAYMENT_INTENT'
 order by 1, 2, 3, 4 ,5;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- ORACLE - TABLESPACE - Recupera tamanho
select tablespace_name, bigfile, block_size, contents,
to_char(size_gb,'999G999G990','nls_numeric_characters=,.') "Size GB",
to_char(used_gb,'999G999G990','nls_numeric_characters=,.') "Used GB",
to_char(free_gb,'999G999G990','nls_numeric_characters=,.') "Free GB",
to_char(pct_free,'990D00','nls_numeric_characters=,.') "Free %",
to_char(maxsize_gb,'999G999G990','nls_numeric_characters=,.') "Max Size GB"
from
(      select a.tablespace_name, a.bigfile, a.block_size, a.contents, b.size_gb, round((b.bytes-nvl(c.free_bytes,0))/1073741824) used_gb, c.free_gb, round((nvl(c.free_bytes,0)/nvl(b.bytes,1)*100),2) pct_free, b.maxsize_gb
from
(select tablespace_name, bigfile, contents, block_size from dba_tablespaces) a,
(select tablespace_name, sum(bytes) bytes, round(nvl(sum(bytes/1073741824),0)) size_gb, round(nvl(sum(decode(autoextensible,'YES',maxbytes,bytes)/1073741824),0)) maxsize_gb from dba_data_files group  by tablespace_name) b,(select tablespace_name, sum(bytes) free_bytes, round(nvl(sum(bytes/1073741824),0)) free_gb from dba_free_space group by tablespace_name) c
where a.tablespace_name = b.tablespace_name and a.tablespace_name = c.tablespace_name(+)
union all
select a.tablespace_name, a.bigfile, a.block_size, a.contents, b.size_gb, nvl(c.used_gb,0) used_gb, round((b.bytes-nvl(c.bytes_used,0))/1073741824) free_gb, round(100-(nvl(c.bytes_used,0)/nvl(b.bytes,1)*100),2) pct_free, b.maxsize_gb
from
(select tablespace_name, bigfile, contents, block_size from dba_tablespaces) a,
(select tablespace_name, sum(bytes) bytes, round(nvl(sum(bytes/1073741824),0)) size_gb, round(nvl(sum(decode(autoextensible,'YES',maxbytes,bytes)/1073741824),0)) maxsize_gb from dba_temp_files group by tablespace_name) b,
(select tablespace_name, sum(bytes_used) bytes_used, round(nvl(sum(bytes_used/1073741824),0)) used_gb from v$temp_extent_pool group by tablespace_name) c
where a.tablespace_name = b.tablespace_name and a.tablespace_name = c.tablespace_name(+))
order by pct_free desc;