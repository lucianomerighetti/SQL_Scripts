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
   and tp.table_owner     = 'AD'
   and tp.table_name      = 'CCE_REASSOCIATE_CONTROL'
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
       'ALTER TABLE ' || tp.table_owner || '.' || tp.table_name || ' MOVE PARTITION '    || tp.partition_name || ' TABLESPACE TSDRECEIVABLES04 PARALLEL 48 ONLINE;'  script_move_tablespace,
       'ALTER TABLE ' || tp.table_owner || '.' || tp.table_name || ' MOVE PARTITION '    || tp.partition_name || ' PARALLEL 48 ONLINE;'  script
  from sys.dba_tab_partitions tp
 where 1 = 1
--   and tp.tablespace_name = 'TSDRECEIVABLES06'
   and tp.table_owner     = 'AD'
   and tp.table_name      = 'CCE_REASSOCIATE_CONTROL'
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
       'ALTER INDEX ' || ip.index_owner || '.' || ip.index_name || ' REBUILD PARTITION ' || ip.partition_name || ' TABLESPACE TSIRECEIVABLES04 PARALLEL 48 ONLINE;'  script_move_tablespace,
       'ALTER INDEX ' || ip.index_owner || '.' || ip.index_name || ' REBUILD PARTITION ' || ip.partition_name || ' PARALLEL 48 ONLINE;'  script
  from sys.dba_ind_partitions ip
 where 1 = 1
--   and ip.tablespace_name = 'TSIRECEIVABLES06'
   and ip.index_owner     = 'AD'
   and ip.index_name in (select i.index_name
                            from sys.dba_indexes i
                           where i.partitioned = 'YES'
                             and i.owner       = 'AD'
                             and i.table_name  = 'CCE_REASSOCIATE_CONTROL')
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
   and i.owner       = 'AD'
   and i.table_name  = 'CCE_REASSOCIATE_CONTROL'
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
   and lp.table_owner     = 'AD'
   and lp.table_name      = 'CCE_REASSOCIATE_CONTROL'
 order by 1, 2, 3, 4 ,5;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------