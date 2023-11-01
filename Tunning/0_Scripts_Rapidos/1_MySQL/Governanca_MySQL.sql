SELECT
   upper(@@hostname) AS DES_HOSTNAME,
   upper(col.table_schema) AS DES_SCHEMA_OWNER,
   'TABLE' AS DES_OBJECT_TYPE,   
   upper(col.table_name) AS DES_TABLE_NAME,
   upper(col.column_name) AS DES_COLUMN_NAME,
   upper(col.data_type) AS DES_COLUMN_DATA_TYPE,
    case when col.character_maximum_length is not null then
          col.character_maximum_length
         when col.numeric_precision is not null then
          col.numeric_precision
    else 
          col.datetime_precision
    end as DAT_LENGTH,
   upper(col.column_comment) AS DES_ORIGIN_TAB_COMMENTS,
    'N' AS FLG_PROCESSED
FROM
   information_schema.columns col
       INNER JOIN
   information_schema.tables tab ON col.table_schema = tab.table_schema
       AND col.table_name = tab.table_name;