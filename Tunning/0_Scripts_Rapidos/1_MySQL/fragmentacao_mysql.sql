select  ENGINE, 
TABLE_NAME,
TABLE_ROWS,
Round( DATA_LENGTH/1024/1024) as data_length, 
round(INDEX_LENGTH/1024/1024) as index_length,
round(DATA_FREE/ 1024/1024) as data_free,
round(DATA_FREE*100/DATA_LENGTH) as prc
from information_schema.tables  
where  round(DATA_FREE*100/DATA_LENGTH)
and table_schema = 'business_condition'
order by prc desc;