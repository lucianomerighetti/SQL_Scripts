select tablespace_name, bigfile, block_size, contents,
round(size_gb/1024,2) "Size TB",
round(used_gb/1024,2) "Used TB",
round(free_gb/1024,2) "Free TB",
round(pct_free,2) "Free %",
round(maxsize_gb/1024,2) "Max Size TB",
round(hwm_gb/1024,2) "HWM TB"
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
)
order by pct_free desc;


-- tamanho das tablespace
select * from dba_tablespace_usage_metrics;

-- verifica data_files, autextend
select TABLESPACE_NAME, FILE_NAME,AUTOEXTENSIBLE,MAXBYTES from dba_Data_files where TABLESPACE_NAME like 'TS%';


----> Tamanho Usado Tablespace 
SELECT DDF.TABLESPACE_NAME
,ROUND(DDF.BYTES/1024/1024/1024/1024,2)"TAMANHO ATUAL (TB)"
,ROUND(DDF.MAXBYTES/1024/1024/1024/1024,2) "TAMANHO MAXIMO (TB)"
,ROUND(USED_PERCENT,2) USED_PERCENT
FROM DBA_DATA_FILES DDF
INNER JOIN DBA_TABLESPACE_USAGE_METRICS DTUM
ON DDF.TABLESPACE_NAME = DTUM.TABLESPACE_NAME
WHERE DDF.TABLESPACE_NAME = 'TSDCMEVENTLOG02_2';




-- ordenado espaço a ser reduzido
col tablespace_name for a30
col "Size GB" for a12
col "Used GB" for a12
col "Free GB" for a12
col "Free %" for a7
col "Max Size GB" for a12
col "HWM GB" for a12
select tablespace_name, bigfile, block_size, contents,
       to_char(size_gb,'999G999G990','nls_numeric_characters=,.') "Size GB",
       to_char(used_gb,'999G999G990','nls_numeric_characters=,.') "Used GB",
       to_char(free_gb,'999G999G990','nls_numeric_characters=,.') "Free GB",
       to_char(pct_free,'990D00','nls_numeric_characters=,.') "Free %",
       to_char(maxsize_gb,'999G999G990','nls_numeric_characters=,.') "Max Size GB",
       to_char(hwm_gb,'999G999G990','nls_numeric_characters=,.') "HWM GB",
       to_char(size_gb-hwm_gb,'999G999G990','nls_numeric_characters=,.') "Reduce GB"
from
(      select a.tablespace_name, a.bigfile, a.block_size, a.contents, b.size_gb, round((b.bytes-nvl(c.free_bytes,0))/1073741824) used_gb, c.free_gb, 
              round((nvl(c.free_bytes,0)/nvl(b.bytes,1)*100),2) pct_free, b.maxsize_gb, round((nvl(e.block_id,0)*a.block_size)/1073741824) hwm_gb
       from
       (select tablespace_name, bigfile, contents, block_size from dba_tablespaces where contents <> 'UNDO') a,
       (select tablespace_name, sum(bytes) bytes, round(nvl(sum(bytes/1073741824),0)) size_gb, 
               round(nvl(sum(decode(autoextensible,'YES',maxbytes,bytes)/1073741824),0)) maxsize_gb from dba_data_files group  by tablespace_name) b,
       (select tablespace_name, sum(bytes) free_bytes, round(nvl(sum(bytes/1073741824),0)) free_gb from dba_free_space group by tablespace_name) c,
       (select tablespace_name, max(block_id) block_id from dba_extents group by tablespace_name) e
       where a.tablespace_name = b.tablespace_name and a.tablespace_name = c.tablespace_name(+) and a.tablespace_name = e.tablespace_name(+)
)
order by "Reduce GB" desc;