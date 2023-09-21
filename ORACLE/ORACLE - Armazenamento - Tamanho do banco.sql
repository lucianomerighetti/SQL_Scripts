col tablespace_name for a30
col "Size GB" for a12
col "Used GB" for a12
col "Free GB" for a12
col "Free %" for a7
col "Max Size GB" for a12
select tablespace_name, bigfile, block_size, contents,
       to_char(size_gb,'999G999G990','nls_numeric_characters=,.') "Size GB",
       to_char(used_gb,'999G999G990','nls_numeric_characters=,.') "Used GB",
       to_char(free_gb,'999G999G990','nls_numeric_characters=,.') "Free GB",
       to_char(pct_free,'990D00','nls_numeric_characters=,.') "Free %",
       to_char(maxsize_gb,'999G999G990','nls_numeric_characters=,.') "Max Size GB"
from
(      select a.tablespace_name, a.bigfile, a.block_size, a.contents, b.size_gb, round((b.bytes-nvl(c.free_bytes,0))/1073741824) used_gb, 
              c.free_gb, round((nvl(c.free_bytes,0)/nvl(b.bytes,1)*100),2) pct_free, b.maxsize_gb
       from
       (select tablespace_name, bigfile, contents, block_size from dba_tablespaces) a,
       (select tablespace_name, sum(bytes) bytes, round(nvl(sum(bytes/1073741824),0)) size_gb, 
	           round(nvl(sum(decode(autoextensible,'YES',maxbytes,bytes)/1073741824),0)) maxsize_gb from dba_data_files group  by tablespace_name) b,
       (select tablespace_name, sum(bytes) free_bytes, round(nvl(sum(bytes/1073741824),0)) free_gb from dba_free_space group by tablespace_name) c
       where a.tablespace_name = b.tablespace_name and a.tablespace_name = c.tablespace_name(+)
       union all
       select a.tablespace_name, a.bigfile, a.block_size, a.contents, b.size_gb, nvl(c.used_gb,0) used_gb, 
	          round((b.bytes-nvl(c.bytes_used,0))/1073741824) free_gb, round(100-(nvl(c.bytes_used,0)/nvl(b.bytes,1)*100),2) pct_free, b.maxsize_gb
       from
       (select tablespace_name, bigfile, contents, block_size from dba_tablespaces) a,
       (select tablespace_name, sum(bytes) bytes, round(nvl(sum(bytes/1073741824),0)) size_gb, 
	           round(nvl(sum(decode(autoextensible,'YES',maxbytes,bytes)/1073741824),0)) maxsize_gb from dba_temp_files group by tablespace_name) b,
       (select tablespace_name, sum(bytes_used) bytes_used, round(nvl(sum(bytes_used/1073741824),0)) used_gb 
	      from (select distinct tablespace_name, file_id, bytes_used from v$temp_extent_pool) group by tablespace_name) c
       where a.tablespace_name = b.tablespace_name and a.tablespace_name = c.tablespace_name(+)
)
order by pct_free desc;
-------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------- 
select dts.tablespace_name,
       ds.owner,
       ds.segment_name,
       ds.segment_type,
       count(1) qt_objetos,
       round(sum(bytes) /(1024 * 1024 * 1024), 2) vl_tamanho_gb,
       sum(dtc.avg_col_len) vl_tamanho_registro_byte
  from sys.dba_tablespaces dts
       inner join sys.dba_segments ds  on (dts.tablespace_name = ds.tablespace_name)
       left  join sys.dba_tab_cols dtc on (ds.owner        = dtc.owner and
                                           ds.segment_name = dtc.table_name)
 where ds.owner = 'RECEIVABLES_ADM'
--   and ds.segment_name like 'RECEIVABLE___TERNAL'
   and ds.segment_type like 'LOB%'
 group by dts.tablespace_name,
          ds.owner,
          ds.segment_name,
          ds.segment_type
 order by 1, 2, 3, 4;
-------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------- 
select s.owner,
       s.segment_name,
       s.segment_type,
       p.partition_name,
       sum(s.bytes) size_bytes
  from dba_tab_partitions      p
       inner join dba_segments s on (s.owner        = p.table_owner and
                                     s.segment_name = p.table_name)
 where s.owner = 'RECEIVABLES_ADM'
   and s.segment_type like 'LOB%'
--   and p.table_name = '????'
 group by s.owner,
          s.segment_name,
          s.segment_type,
          p.partition_name;
-------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------- 
 select trunc(snap.end_interval_time)                                       data,
        trunc(sum(tablespace_size * t.block_size) / 1024 / 1024 / 1024)     size_gb,
        trunc(sum(tablespace_usedsize * t.block_size) / 1024 / 1024 / 1024) usedsize_gb
   from dba_hist_tbspc_space_usage     s
        inner join dba_hist_snapshot   snap on (s.snap_id = snap.snap_id)
        inner join dba_hist_tablespace th   on (s.tablespace_id = th.ts#)
        inner join dba_tablespaces     t    on (th.tsname = t.tablespace_name)
  where snap.snap_id in (select min(snap_id)
                           from dba_hist_snapshot
                          group by trunc(end_interval_time))
    and snap.instance_number = 1
  group by trunc(snap.end_interval_time)
  order by 1;
-------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------- 
set pagesize 100

select substr(sys_context('USERENV', 'DB_NAME'), 4, 50) || '_ADM' "Banco",
       to_char(trunc(sysdate))                                    "Data"
  from dual;

col "Size GB" for a12
col "Used GB" for a12

select round(sum(size_gb) / 1024, 2) "Size TB",
       round(sum(used_gb) / 1024, 2) "Used TB"
  from (
        select a.tablespace_name,
               a.bigfile,
               a.block_size,
               a.contents,
               b.size_gb,
               round((b.bytes - nvl(c.free_bytes, 0)) / 1073741824)    used_gb,
               c.free_gb,
               round((nvl(c.free_bytes, 0) / nvl(b.bytes, 1) * 100),2) pct_free,
               b.maxsize_gb,
               round((nvl(e.block_id, 0) * a.block_size) / 1073741824) hwm_gb
          from (
                select tablespace_name,
                       bigfile,
                       contents,
                       block_size
                  from dba_tablespaces
               ) a,
               (
                select tablespace_name,
                       sum(bytes) bytes,
                       round(nvl(sum(bytes / 1073741824), 0)) size_gb,
                       round(nvl(sum(decode(autoextensible, 'YES', maxbytes, bytes) / 1073741824), 0)) maxsize_gb
                  from dba_data_files
                 group by tablespace_name
               ) b,
               (
                select tablespace_name,
                       sum(bytes) free_bytes,
                       round(nvl(sum(bytes / 1073741824), 0)) free_gb
                  from dba_free_space
                 group by tablespace_name
               ) c,
               (
                select tablespace_name,
                       max(block_id) block_id
                  from dba_extents
                 group by tablespace_name
               ) e
         where a.tablespace_name = b.tablespace_name
           and a.tablespace_name = c.tablespace_name (+)
           and a.tablespace_name = e.tablespace_name (+)
        union all
        select a.tablespace_name,
               a.bigfile,
               a.block_size,
               a.contents,
               b.size_gb,
               nvl(c.used_gb, 0)                                             used_gb,
               round((b.bytes - nvl(c.bytes_used, 0)) / 1073741824)          free_gb,
               round(100 -(nvl(c.bytes_used, 0) / nvl(b.bytes, 1) * 100), 2) pct_free,
               b.maxsize_gb,
               round((nvl(e.block_id, 0) * a.block_size) / 1073741824)       hwm_gb
          from (
                select tablespace_name,
                       bigfile,
                       contents,
                       block_size
                  from dba_tablespaces
               ) a,
               (
                select tablespace_name,
                       sum(bytes) bytes,
                       round(nvl(sum(bytes / 1073741824), 0)) size_gb,
                       round(nvl(sum(decode(autoextensible, 'YES', maxbytes, bytes) / 1073741824), 0)) maxsize_gb
                from
                    dba_temp_files
                group by
                    tablespace_name
               ) b,
               (
                select tablespace_name,
                       sum(bytes_used) bytes_used,
                       round(nvl(sum(bytes_used / 1073741824), 0)) used_gb
                  from v$temp_extent_pool
                 group by tablespace_name
               ) c,
               (
                select tablespace   tablespace_name,
                       max(segblk#) block_id
                  from v$tempseg_usage
                 group by tablespace
               ) e
         where a.tablespace_name = b.tablespace_name
           and a.tablespace_name = c.tablespace_name
           and a.tablespace_name = e.tablespace_name (+)
       );

select group_number,
       name                                                       group_name,
       state,
       type,
       trunc(total_mb / 1024 / 1024)                              total_tb,
       trunc(free_mb / 1024 / 1024)                               free_tb,
       trunc(usable_file_mb / 1024 / 1024)                        usable_file_tb,
       decode(total_mb, 0, 0, trunc(free_mb / total_mb * 100, 2)) free_pct
  from v$asm_diskgroup
 order by group_number;