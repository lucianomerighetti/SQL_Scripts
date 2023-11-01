-- gb_data_file = tamanho que se quer redimensionar a tablespace, se for 20TB, então = 20480, ou 20000 se quiser arredondar mais fácil

select distinct owner, segment_type, segment_name, partition_name
from dba_extents
where file_id IN (select file_id
                 from   dba_data_files
                 where  tablespace_name='&&tablespace_name') AND
     block_id*(select block_size/1024 from dba_tablespaces where tablespace_name='&&tablespace_name')+(bytes/1024) > (&gb_data_file*1024*1024)
order by 1,2,3,4;



select owner, segment_name, segment_type, tablespace_name from (
	select distinct owner, segment_name, segment_type, tablespace_name from dba_segments
	union
	select distinct owner, table_name, 'TABLE', tablespace_name from dba_all_tables
	union
	select distinct table_owner owner, table_name, 'TABLE PARTITION', tablespace_name from dba_tab_partitions
	union
	select distinct table_owner owner, table_name, 'TABLE SUBPARTITION', tablespace_name from dba_tab_subpartitions
	union
	select distinct owner, index_name, 'INDEX', tablespace_name from dba_indexes
	union
	select distinct index_owner owner, index_name, 'INDEX PARTITION', tablespace_name from dba_ind_partitions
	union
	select distinct index_owner owner, index_name, 'INDEX SUBPARTITION', tablespace_name from dba_ind_subpartitions
	union
	select distinct owner, segment_name, 'LOB', tablespace_name from dba_lobs
	union
	select distinct table_owner owner, lob_name, 'LOB PARTITION', tablespace_name from dba_lob_partitions
	union
	select distinct table_owner owner, lob_name, 'LOB SUBPARTITION', tablespace_name from dba_lob_subpartitions
	union
	select distinct owner, cluster_name, 'CLUSTER', tablespace_name from dba_clusters)
where tablespace_name='TSDSETTLEMENTCONTRACT04'
order by 1,3,2;