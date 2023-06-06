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