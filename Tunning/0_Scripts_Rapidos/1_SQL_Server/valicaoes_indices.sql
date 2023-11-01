--analise de indices
-- Missing Indexes in current database by Index Advantage 
SELECT user_seeks * avg_total_user_cost * ( avg_user_impact * 0.01 ) 
AS [index_advantage] ,
migs.last_user_seek , 
mid.[statement] AS [Database.Schema.Table] ,
mid.equality_columns , 
mid.inequality_columns , 
mid.included_columns , migs.unique_compiles , 
migs.user_seeks , 
migs.avg_total_user_cost , 
migs.avg_user_impact,
'CREATE NONCLUSTERED INDEX @@IX_NAME ON ' + mid.[statement] + '(' + equality_columns + ')' +
	case
		when included_columns is not null then 'include (' + included_columns + ')'
	else
		''
	end as command		
FROM sys.dm_db_missing_index_group_stats AS migs WITH ( NOLOCK ) 
INNER JOIN sys.dm_db_missing_index_groups AS mig WITH ( NOLOCK ) 
ON migs.group_handle = mig.index_group_handle 
INNER JOIN sys.dm_db_missing_index_details AS mid WITH ( NOLOCK ) 
ON mig.index_handle = mid.index_handle
WHERE mid.database_id = DB_ID()
ORDER BY migs.user_seeks DESC ;
​
​
​
--- Index Read/Write stats (all tables in current DB)
SELECT OBJECT_NAME(s.[object_id]) AS [ObjectName] , 
i.
          name AS [IndexName] , i.index_id , 
user_seeks + user_scans + user_lookups AS [Reads] , 
user_updates AS [Writes] , 
i.type_desc AS [IndexType] , 
i.fill_factor AS [FillFactor]
FROM sys.dm_db_index_usage_stats AS s 
INNER JOIN sys.indexes AS i ON s.[object_id] = i.[object_id]
WHERE OBJECTPROPERTY(s.[object_id], 'IsUserTable') = 1 
AND i.index_id = s.index_id 
AND s.database_id = DB_ID()
AND user_seeks + user_scans + user_lookups = 0
ORDER BY OBJECT_NAME(s.[object_id]) , 
writes DESC ,
reads DESC ;
​
​
​
-- List unused indexes
SELECT OBJECT_NAME(i.[object_id]) AS [Table Name] ,
i.
          name
FROM sys.indexes AS i 
INNER JOIN sys.objects AS o ON i.[object_id] = o.[object_id]
WHERE i.index_id NOT IN ( SELECT s.index_id 
FROM sys.dm_db_index_usage_stats AS s 
WHERE s.[object_id] = i.[object_id] 
AND i.index_id = s.index_id 
AND database_id = DB_ID() ) 
AND o.[type] = 'U'
ORDER BY OBJECT_NAME(i.[object_id]) ASC ;
​
​
​
​
-- Possible Bad NC Indexes (writes > reads)
SELECT OBJECT_NAME(s.[object_id]) AS [Table Name] , 
i.
          name AS [Index Name] , 
i.index_id , 
user_updates AS [Total Writes] , 
user_seeks + user_scans + user_lookups AS [Total Reads] , 
user_updates - ( user_seeks + user_scans + user_lookups ) 
AS [Difference]
FROM sys.dm_db_index_usage_stats AS s WITH ( NOLOCK ) 
INNER JOIN sys.indexes AS i WITH ( NOLOCK ) 
ON s.[object_id] = i.[object_id] 
AND i.index_id = s.index_id
WHERE OBJECTPROPERTY(s.[object_id], 'IsUserTable') = 1 
AND s.database_id = DB_ID() 
AND user_updates > ( user_seeks + user_scans + user_lookups ) 
AND i.index_id > 1
ORDER BY [Difference] DESC , 
[Total Writes] DESC , 
[Total Reads] ASC ;
​
​
-------------------------------------------------------------------------
(@P0 int,@P1 varchar(8000))
select TOP(@P0) fila0_.FilaId as FilaId1_13_, 
fila0_.FilaDataCriacao as FilaData2_13_, 
fila0_.FilaDataModificacao as FilaData3_13_, 
fila0_.FilaDataProcessamento as FilaData4_13_,
 fila0_.FilaStatus as FilaStat5_13_, 
 fila0_.FilaTipoProcessamento as FilaTipo6_13_ 
 from Fila fila0_ where fila0_.FilaStatus=@P1
(@P0 datetime2,@P1 datetime2,@P2 date,@P3 varchar(8000),
@P4 varchar(8000))insert into Fila (FilaDataCriacao, FilaDataModificacao, FilaDataProcessamento, FilaStatus, FilaTipoProcessamento) 
values (@P0, @P1, @P2, @P3, @P4)                                         
select SCOPE_IDENTITY() AS GENERATED_KEYS
---------------------------------------------------------------------------------------------------------------------------------------
--- Index Read/Write stats (all tables in current DB)
SELECT OBJECT_NAME(s.[object_id]) AS [ObjectName] , 
i.name AS [IndexName] , i.index_id , 
user_seeks + user_scans + user_lookups AS [Reads] , 
user_updates AS [Writes] , 
i.type_desc AS [IndexType] , 
i.fill_factor AS [FillFactor],
'ALTER INDEX ['+ i.name +'] ON ['+ OBJECT_NAME(s.[object_id]) +'] DISABLE',
'DROP INDEX ['+ i.name +'] ON ['+ OBJECT_NAME(s.[object_id]) +']'
FROM sys.dm_db_index_usage_stats AS s 
INNER JOIN sys.indexes AS i ON s.[object_id] = i.[object_id]
WHERE OBJECTPROPERTY(s.[object_id], 'IsUserTable') = 1 
AND i.index_id = s.index_id 
AND s.database_id = DB_ID()
--AND user_seeks + user_scans + user_lookups = 0
AND OBJECT_NAME(s.[object_id]) = 'EVENTO'
ORDER BY Reads DESC
------------------------------------------------------------------------------------------------------------------------------------------
;WITH FKsNI (ObjectId, FKId) As (
SELECT DISTINCT
    parent_object_id, constraint_object_id
FROM sys.foreign_key_columns As FC
WHERE NOT EXISTS (
    SELECT * FROM sys.index_columns As IC
    WHERE
        FC.parent_object_id = IC.object_id AND
        FC.constraint_column_id = IC.index_column_id AND
        FC.parent_column_id = IC.column_id))
SELECT
    OBJECT_NAME(FKsNI.ObjectId) As Objeto,
    OBJECT_NAME(FKsNI.FKId) As FK,
    C.Name As Coluna,
    FC.constraint_column_id As Ordem,
    'CREATE NONCLUSTERED INDEX IDX_'+C.Name+' ON ' + OBJECT_NAME(FKsNI.ObjectId) + '('+C.Name+')' as command
FROM FKsNI
INNER JOIN sys.foreign_key_columns As FC ON
    FKsNI.FKId = FC.constraint_object_id AND
    FKsNI.ObjectId = FC.parent_object_id
INNER JOIN sys.columns As C ON
    FC.parent_object_id = C.object_id AND
    FC.parent_column_id = C.column_id
ORDER BY Ordem