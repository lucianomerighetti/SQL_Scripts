# Tabelas
select a.owner, a.table_name, a.last_analyzed analyzed,
	   round(a.blocks*b.block_size/1024/1024) "Size (mb)" , 
	   round(a.num_rows*a.avg_row_len/1024/1024) "Used (mb)",
	   (round(a.blocks*b.block_size/1024/1024)-round(a.num_rows*a.avg_row_len/1024/1024)) "Wasted (mb)",
	   decode(nvl(a.blocks,0),0,0,trunc(((round(a.blocks*b.block_size)-round(a.num_rows*a.avg_row_len))/round(a.blocks*b.block_size))*100,2)) "Wasted (%)"
from dba_tables a, dba_tablespaces b
where a.owner='XXXX' and a.last_analyzed is not null
and a.tablespace_name=b.tablespace_name
order by 7 desc;

# Partições
select a.table_owner, a.table_name, a.partition_name, a.high_value, a.last_analyzed analyzed,
	   round(a.blocks*b.block_size/1024/1024) "Size (mb)" , 
	   round(a.num_rows*a.avg_row_len/1024/1024) "Used (mb)",
	   (round(a.blocks*b.block_size/1024/1024)-round(a.num_rows*a.avg_row_len/1024/1024)) "Wasted (mb)",
	   decode(nvl(a.blocks,0),0,0,trunc(((round(a.blocks*b.block_size)-round(a.num_rows*a.avg_row_len))/round(a.blocks*b.block_size))*100,2)) "Wasted (%)"
from dba_tab_partitions a, dba_tablespaces b
where a.table_owner='XXXX' and a.last_analyzed is not null
and a.tablespace_name=b.tablespace_name
order by 9 desc,2;