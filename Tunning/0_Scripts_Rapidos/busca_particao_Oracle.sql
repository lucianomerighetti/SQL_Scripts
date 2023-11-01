--ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

create or replace FUNCTION    Partition_High_Value  (owner_in VARCHAR2, table_name_in varchar2, partition_name_in varchar2)  RETURN varchar2 IS
    incoming    varchar2(32767);
    return_hold varchar2(4000);
Begin
    select high_value into incoming from all_tab_partitions
     where table_owner = owner_in
       and partition_name = partition_name_in
       and table_name = table_name_in;
    return_hold := substr(incoming,1,4000);
    return return_hold;
END;
/

select 
 pt.OWNER AS SCHEMA
,pt.TABLE_NAME
,pt.PARTITIONING_TYPE
,pkc.COLUMN_NAME AS COLUM_PARTITION
,tb.DATA_TYPE
,p.PARTITION_NAME
,p.HIGH_VALUE as PARTITION_RANGE
,case 
    when tb.DATA_TYPE = 'TIMESTAMP(6)' then
      trim(substr((PARTITION_HIGH_VALUE(pt.OWNER,pt.TABLE_NAME,p.PARTITION_NAME)), 12, 19))
    when tb.DATA_TYPE = 'DATE' then
      trim(substr((PARTITION_HIGH_VALUE(pt.OWNER,pt.TABLE_NAME,p.PARTITION_NAME)), 11, 10))
    when tb.DATA_TYPE = 'NUMBER' then  
      trim(substr(PARTITION_HIGH_VALUE(pt.OWNER,pt.TABLE_NAME,p.PARTITION_NAME),1,4000))
 end AS PARTITION_RANGE_F
from DBA_PART_TABLES pt
inner join DBA_TAB_PARTITIONS p
on pt.OWNER = p.TABLE_OWNER
and pt.TABLE_NAME = p.TABLE_NAME
inner join DBA_PART_KEY_COLUMNS pkc
on pt.OWNER = pkc.OWNER
and pt.TABLE_NAME = pkc.NAME
inner join DBA_TAB_COLUMNS tb
on tb.owner = pkc.OWNER
and tb.TABLE_NAME = pkc.NAME
and tb.COLUMN_NAME = pkc.COLUMN_NAME
where pt.OWNER = 'RECEIVABLES_ADM'
and pt.TABLE_NAME = 'PAYMENT'
order by p.PARTITION_POSITION;