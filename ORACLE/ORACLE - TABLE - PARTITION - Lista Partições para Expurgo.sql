with
    vw_atp as (
        select table_owner,
               table_name,
               partition_name,
               num_rows,
               to_date(substr(extractvalue(dbms_xmlgen.getxmltype('select high_value ' ||
                                                                    'from all_tab_partitions ' ||
                                                                   'where partition_name = ''' || dtp.partition_name || ''' ' ||
                                                                     'and table_owner = '''    || dtp.table_owner || ''' ' ||
                                                                     'and table_name = '''     || dtp.table_name || ''''), '//text()') , 12, 10), 'yyyy-mm-dd') as high_value_date,
            partition_position
        from all_tab_partitions dtp
        where table_owner = 'RECEIVABLES_ADM'
          and table_name  = 'PAYMENT_INTENT'
          and num_rows    > 0
        order by partition_position
    )
select table_owner,
       table_name,
       partition_name,
       num_rows,
       partition_position,
       high_value_date,
	   case
          when partition_name <> 'P_1' then to_number(substr(partition_name, 6, length(partition_name)))
          else 1
       end high_value_number,
       'ALTER TABLE ' || table_owner || '.' || table_name || ' DROP PARTITION ' || partition_name || ' UPDATE INDEXES PARALLEL 32;' script
  from vw_atp
-- where high_value_date <=trunc(sysdate) --to_date('15/11/2022', 'dd/mm/yyyy')
 order by partition_position;