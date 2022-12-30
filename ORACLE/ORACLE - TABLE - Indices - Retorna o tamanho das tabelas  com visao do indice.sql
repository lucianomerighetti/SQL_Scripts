-- tamanho das tabelas  com visao do indice 
with
size_table as (
  select sum(bytes/1024.0/1024.0/1024.0) num_size_gb,
         s.segment_name table_name
    from dba_segments s
  group by s.segment_name
),
size_indexes as (
  select sum(bytes/1024.0/1024.0/1024.0) num_size_gb,
         i.table_name
    from dba_indexes i
      join dba_segments s on (i.index_name = s.segment_name)
    group by i.table_name
)
select t.table_name,
       pt.partitioning_type,
       pt.interval,
       pkc.column_name partition_key, 
       nvl(st.num_size_gb,0) num_table_size_gb,
       nvl(si.num_size_gb,0) num_indexes_size_gb,
       st.num_size_gb+si.num_size_gb as num_total_size
  from dba_tables t
       left join dba_part_tables pt on (pt.table_name = t.table_name and pt.owner = t.owner)
       left join dba_part_key_columns pkc on (pkc.name = t.table_name and pkc.owner = t.owner)
       left join size_table st on (st.table_name = t.table_name)
       left join size_indexes si on (si.table_name = t.table_name)
 where 1=1 
   and t.owner = 'RECEIVABLES_ADM'
 order by num_table_size_gb desc;
​
​
​
-- tamanho de um indice 
select sum(bytes/1024.0/1024.0/1024.0) num_size_gb,
     i.table_name,
     i.index_name,
     max(t.des_columns) des_columns
from dba_indexes i
inner join dba_segments s on i.index_name = s.segment_name
inner join (
    select  table_name, index_name, listagg(column_name, ', ')  WITHIN GROUP (ORDER BY column_position)  as des_columns
    from all_ind_columns a
    where 1=1 
    group by table_name, index_name
) t on t.table_name = i.table_name
    and t.index_name = i.index_name 
where 1=1 
and i.table_name = 'REG_CONTRACTUAL_EFFECT'
group by i.table_name, i.index_name
order by num_size_gb desc 
​
​
-- tamanho das particoes de uma tabela 
 SELECT 
    PARTITION_NAME,  (bytes/1024.0/1024.0/1024.0) num_size_gb,
    ROW_NUMBER() OVER (ORDER BY bytes ASC ) num_row
FROM dba_segments
WHERE segment_type IN ('TABLE', 'TABLE PARTITION', 'TABLE SUBPARTITION')
and segment_name = 'REG_CONTRACTUAL_EFFECT'
ORDER BY num_size_gb DESC 
​
​
​
​
SELECT count(1), COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT FROM SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT partition (REG_CONTRACTUAL_EFFECT_PART_20220701)
WHERE 1=1 --and  ROWNUM < 100
group by COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT
​
SELECT TABLE_NAME, PARTITION_NAME, HIGH_VALUE
 FROM USER_TAB_PARTITIONS
 
WHERE TABLE_NAME = 'CUSTOMER_HISTORY'
​
​
SELECT * FROM dba_part_tables