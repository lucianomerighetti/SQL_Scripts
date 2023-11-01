select 
    z.schema,
	z.table_name,
    z.partitioning_type,
    z.column_partition,
	z.data_type,
	z.partition_name,       
	z.partition_range,       
	trim(substring(z.partition_range from 0 for z.position_range)) as partition_range_inicial,
	trim(substring(z.partition_range from z.position_range for 2000)) as partition_range_final
from
(select 
       y.schema,
	   y.table_name,
       y.partitioning_type,
       y.column_partition,
	   y.data_type,
	   y.partition_name,       
	   y.partition_range,
       position('  ' in y.partition_range) as position_range
from (select x.schema,
	   x.table_name,
       x.partitioning_type,
       x.column_partition,
	   x.data_type,
	   x.partition_name,       
       regexp_replace(regexp_replace(x.partition_expression, '\D', ' ', 'g'),'^\s+', '') partition_range
from (
select sch.schema_name as schema,
	   tab.table_name,
       t.partitioning_type,
       col.column_name as column_partition,
	   col.data_type,
	   pt.relname as partition_name,
       pg_get_expr(pt.relpartbound, pt.oid, true) as partition_expression	   
from information_schema.schemata sch
inner join information_schema.tables tab on tab.table_schema = sch.schema_name
inner join pg_catalog.pg_class c on tab.table_name = c.relname
inner join pg_catalog.pg_inherits i on i.inhparent = c.oid 
inner join pg_catalog.pg_class pt on pt.oid = i.inhrelid
inner join (select 	partrelid,
         			partnatts,
         			case partstrat 
              		  when 'l' then 'list' 
              		  when 'r' then 'range'
			  		  when 'h' then 'list' end as partitioning_type,
         			unnest(partattrs) column_index
     		from pg_catalog.pg_partitioned_table) t on c.oid = t.partrelid
inner join information_schema.columns col on col.table_schema = c.relnamespace::regnamespace::text
 and col.table_name = c.relname
and ordinal_position = t.column_index
where c.oid = 'transaction'::regclass) x) y) z