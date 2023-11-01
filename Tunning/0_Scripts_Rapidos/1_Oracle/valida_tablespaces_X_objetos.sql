alter session set NLS_NUMERIC_CHARACTERS = '.,';
column tablespace_name format a30
column Size_TB format a10
column Used_TB format a10
column Free_TB format a10
column Pct_Free format a10
column HWM_GB format a10
column objects_by_tablespace format a80
column def_objects_by_tablespace format a80
set pagesize 5000

select t.tablespace_name
,round(t.size_gb/1024,2) Size_TB
,round(t.used_gb/1024,2) Used_TB
,round(t.free_gb/1024,2) Free_TB
,round(pct_free,2) Pct_Free
,round(hwm_gb/1024,2) HWM_GB
,listagg(ot.object_name,chr(10)) objects_by_tablespace
--,listagg(od.object_name,chr(10)) def_objects_by_tablespace

----- tablespaces
from
(select a.tablespace_name, a.bigfile, a.block_size, a.contents, b.size_gb, round((b.bytes-nvl(c.free_bytes,0))/1073741824) used_gb, c.free_gb,
round((nvl(c.free_bytes,0)/nvl(b.bytes,1)*100),2) pct_free, b.maxsize_gb, round((nvl(e.block_id,0)*a.block_size)/1073741824) hwm_gb
from
(select tablespace_name, bigfile, contents, block_size from dba_tablespaces) a,(select tablespace_name, sum(bytes) bytes, round(nvl(sum(bytes/1073741824),0)) size_gb,
round(nvl(sum(decode(autoextensible,'YES',maxbytes,bytes)/1073741824),0)) maxsize_gb from dba_data_files group  by tablespace_name) b,
(select tablespace_name, sum(bytes) free_bytes, round(nvl(sum(bytes/1073741824),0)) free_gb from dba_free_space group by tablespace_name) c,
(select tablespace_name, max(block_id) block_id from dba_extents group by tablespace_name) e
where a.tablespace_name = b.tablespace_name and a.tablespace_name = c.tablespace_name(+) and a.tablespace_name = e.tablespace_name(+)
union all
select a.tablespace_name, a.bigfile, a.block_size, a.contents, b.size_gb, nvl(c.used_gb,0) used_gb, round((b.bytes-nvl(c.bytes_used,0))/1073741824)free_gb,
round(100-(nvl(c.bytes_used,0)/nvl(b.bytes,1)*100),2) pct_free, b.maxsize_gb, round((nvl(e.block_id,0)*a.block_size)/1073741824) hwm_gb
from
(select tablespace_name, bigfile, contents, block_size from dba_tablespaces) a,
(select tablespace_name, sum(bytes) bytes, round(nvl(sum(bytes/1073741824),0)) size_gb,round(nvl(sum(decode(autoextensible,'YES',maxbytes,bytes)/1073741824),0)) maxsize_gb from dba_temp_files group by tablespace_name) b,
(select tablespace_name, sum(bytes_used) bytes_used, round(nvl(sum(bytes_used/1073741824),0)) used_gb from v$temp_extent_pool group by tablespace_name) c,
(select tablespace tablespace_name, max(segblk#) block_id from v$tempseg_usage group by tablespace) e
where a.tablespace_name = b.tablespace_name and a.tablespace_name = c.tablespace_name and a.tablespace_name = e.tablespace_name(+)
) t
----- objetos
left join
(select tg.tablespace_name
,nvl(tg.lob_name,tg.tables_tablespace)||tg.indexes_tablespace object_name
from (select s.tablespace_name
,s.segment_name||' ('||count(*)||' - '||
case when round(sum(s.bytes)/1024/1024/1024/1024,2) <= 0 then 
          to_char(round(sum(s.bytes)/1024/1024/1024,2))||' GB)' 
     else to_char(round(sum(s.bytes)/1024/1024/1024/1024,2))||' TB)' 
end tables_tablespace
,count(*) qty_part
,round(sum(s.bytes)/1024/1024/1024,2) tam_gb
,round(sum(s.bytes)/1024/1024/1024/1024,2) tam_tb
,ig.indexes_tablespace
,lg.lob_name
from dba_segments s
left join (
select i.table_name
,' / ('||case when round(sum(s.bytes)/1024/1024/1024/1024,2) <= 0 then 
                   to_char(round(sum(s.bytes)/1024/1024/1024,2))||' GB de IG)' 
              else to_char(round(sum(s.bytes)/1024/1024/1024/1024,2))||' TB de IG)' 
         end indexes_tablespace      
,count(*) qty_part
,round(sum(s.bytes)/1024/1024/1024,2) tam_gb
,round(sum(s.bytes)/1024/1024/1024/1024,2) tam_tb
from dba_segments s
inner join dba_indexes i
on s.owner = i.owner
and s.segment_name = i.index_name
where s.owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
and s.segment_type = 'INDEX'
and i.partitioned = 'NO'
group by i.table_name) ig
on s.segment_name = ig.table_name
left join (
select 'LOB '||l.table_name||' - '||l.column_name||' - CAMPO' as lob_name
,l.segment_name
from dba_lobs l
where l.owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
union
select 'LOB '||l.table_name||' - '||l.column_name||' - INDEX' 
,l.index_name
from dba_lobs l
where l.owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
) lg
on s.segment_name = lg.segment_name
where s.owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
group by s.tablespace_name, s.segment_name, ig.indexes_tablespace,lg.lob_name
order by s.tablespace_name,5 desc,4) tg) ot
on t.tablespace_name = ot.tablespace_name
----- objetos padrao
/*
left join
(select t.table_name object_name
,nvl(t.tablespace_name,pt.def_tablespace_name) def_tablespace_name
from dba_tables t
left join dba_part_tables pt
on t.owner = pt.owner
and t.table_name = pt.table_name
where t.owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
union all
select distinct i.index_name 
,nvl(i.tablespace_name,pi.def_tablespace_name) def_tablespace_name
from dba_indexes i
left join dba_part_indexes pi
on i.owner = pi.owner
and i.table_name = pi.table_name
where i.owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM') od
on t.tablespace_name = od.def_tablespace_name */
--where t.tablespace_name not in ('TSDRECEIVABLES01','TSIRECEIVABLES01')
group by  t.tablespace_name
,round(t.size_gb/1024,2)
,round(t.used_gb/1024,2)
,round(t.free_gb/1024,2)
,round(pct_free,2) 
,round(hwm_gb/1024,2)
order by t.tablespace_name;

-- OBJETOS POR TABLESPACE

select s.tablespace_name
,s.segment_name||' ('||count(*)||' - '||
case when round(sum(s.bytes)/1024/1024/1024/1024,2) <= 0 then 
          to_char(round(sum(s.bytes)/1024/1024/1024,2))||' GB)' 
     else to_char(round(sum(s.bytes)/1024/1024/1024/1024,2))||' TB)' 
end || ig.indexes_tablespace tables_tablespace
,count(*) qty_part
,round(sum(s.bytes)/1024/1024/1024,2) tam_gb
,round(sum(s.bytes)/1024/1024/1024/1024,2) tam_tb
from dba_segments s
left join (
select i.table_name
,' / ('||case when round(sum(s.bytes)/1024/1024/1024/1024,2) <= 0 then 
                   to_char(round(sum(s.bytes)/1024/1024/1024,2))||' GB de IG)' 
              else to_char(round(sum(s.bytes)/1024/1024/1024/1024,2))||' TB de IG)' 
         end indexes_tablespace      
,count(*) qty_part
,round(sum(s.bytes)/1024/1024/1024,2) tam_gb
,round(sum(s.bytes)/1024/1024/1024/1024,2) tam_tb
from dba_segments s
inner join dba_indexes i
on i.owner = i.owner
and s.segment_name = i.index_name
where s.owner = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
and s.segment_type = 'INDEX'
and i.partitioned = 'NO'
group by i.table_name
) ig
on s.segment_name = ig.table_name
where s.tablespace_name = 'TSDRECEIVABLES01'
group by  s.tablespace_name
,s.segment_name
,ig.indexes_tablespace
order by s.tablespace_name,4 desc,3;