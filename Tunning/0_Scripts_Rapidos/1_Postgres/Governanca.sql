select
    upper(current_database()) AS DES_HOSTNAME,
    upper(sch.schema_name) AS DES_SCHEMA_OWNER,
	'TABLE' AS DES_OBJECT_TYPE,
    upper(tab.table_name) AS DES_TABLE_NAME,
    upper(col.column_name) AS DES_COLUMN_NAME,
    upper(col.udt_name) AS DES_COLUMN_DATA_TYPE,
    case when col.character_maximum_length is not null then
          col.character_maximum_length
         when col.numeric_precision is not null then
          col.numeric_precision
    else 
          col.datetime_precision
    end as DAT_LENGTH,
    upper(pg_catalog.col_description(c.oid,col.ordinal_position)) AS DES_ORIGIN_TAB_COMMENTS,
    'N' AS FLG_PROCESSED
from information_schema.schemata sch
inner join information_schema.tables tab on tab.table_schema = sch.schema_name
inner join pg_catalog.pg_class c on (tab.table_name = c.relname)
inner join pg_catalog.pg_user u on (c.relowner = u.usesysid)
inner join information_schema.columns col on col.table_name = tab.table_name 
and tab.table_schema = col.table_schema
where
UPPER(sch.schema_name) like '%ADM'
and tab.table_type = 'BASE TABLE' --Não utiliza VIEW
and c.relispartition is false