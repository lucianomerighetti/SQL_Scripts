-- query que busca na partição
select * from nome_tabela partition(nome_particao);

-- busca identity
SELECT OWNER, TABLE_NAME, SEQUENCE_NAME, IDENTITY_OPTIONS
FROM dba_TAB_IDENTITY_COLS
 WHERE table_name IN ('CONTRACTUAL_EFFECTS_EVENT','CONTRACTUAL_EFFECTS_EVENT_JSON');

-- busca tabelas particionada
 SELECT  table_name, 
        partitioning_type, 
        partition_count, 
        interval 
  FROM  DBA_PART_TABLES
 WHERE  table_name IN ('CONTRACTUAL_EFFECTS_EVENT','CONTRACTUAL_EFFECTS_EVENT_JSON');

-- busca particoes
 select table_name,
       partition_name,
       num_rows,
       high_value,
       tablespace_name 
  from dba_tab_partitions
 where table_name IN ('CONTRACTUAL_EFFECTS_EVENT','CONTRACTUAL_EFFECTS_EVENT_JSON');
 
-- busca indices particionados 
 select index_name,
  partition_name,
  num_rows,
  high_value,
  tablespace_name
  from dba_ind_partitions
  where index_name ='DAT_PART_IDX01';

-- busca lobs particionados 
 select *
  from dba_lob_partitions;
  
-- busca chave de partição das tabelas
select *
from dba_part_key_columns
where name =  'CONTRACTUAL_EFFECTS_EVENT'; 