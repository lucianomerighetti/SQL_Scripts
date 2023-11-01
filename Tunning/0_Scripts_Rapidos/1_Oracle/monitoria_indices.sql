-- Monitorar todos os indices que sejam de negócio (Não é necessário monitorar PK, UK e índice de FK pois eles não poderão ser excluídos)
---- query para pegar os índices do critério
SELECT IU.OWNER
,IU.NAME
,IU.TOTAL_ACCESS_COUNT
,IU.TOTAL_EXEC_COUNT
,IU.TOTAL_ROWS_RETURNED
,IU.LAST_USED
FROM DBA_INDEX_USAGE IU
WHERE IU.NAME IN ( 
SELECT DISTINCT I.INDEX_NAME
FROM DBA_INDEXES I
INNER JOIN (SELECT C.TABLE_NAME,C.INDEX_NAME,LISTAGG(C.COLUMN_NAME, ',')
          WITHIN GROUP (ORDER BY C.COLUMN_POSITION) INDEX_COLUMNS
          FROM   DBA_IND_COLUMNS C 
          WHERE  C.INDEX_OWNER = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
          GROUP  BY TABLE_NAME, 
                    INDEX_NAME) IC
ON  I.TABLE_NAME = IC.TABLE_NAME                    
AND I.INDEX_NAME = IC.INDEX_NAME
LEFT JOIN (SELECT A.OWNER, 
                 A.TABLE_NAME, 
                 A.CONSTRAINT_NAME, 
                 LISTAGG(A.COLUMN_NAME, ',') 
                   WITHIN GROUP (ORDER BY A.POSITION) FK_COLUMNS 
          FROM   DBA_CONS_COLUMNS A, 
                 DBA_CONSTRAINTS B 
          WHERE  A.CONSTRAINT_NAME = B.CONSTRAINT_NAME 
                 AND B.CONSTRAINT_TYPE = 'R'
                 AND A.OWNER = B.OWNER 
                 AND A.OWNER = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'	   
          GROUP  BY A.OWNER, 
                    A.TABLE_NAME, 
                    A.CONSTRAINT_NAME) FKC
ON  I.TABLE_NAME = FKC.TABLE_NAME                    
AND IC.INDEX_COLUMNS = FKC.FK_COLUMNS                    
WHERE I.OWNER = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
AND I.UNIQUENESS = 'NONUNIQUE' -- RETIRA PK E UK
AND FKC.FK_COLUMNS IS NULL -- RETIRA INDICE DE FK
)
ORDER BY IU.LAST_USED;

-- Com a listagem acima, valide índice a índice onde ele é usado


-- validar onde foi utilizado o index
select a.sql_id, operation, object_owner, options, object_name, object_alias, sql_text 
from dba_hist_sql_plan A
left join dba_hist_sqltext b
    on a.sql_id = b.sql_id
where OBJECT_NAME = 'ACCOUNTING_RECORD_LEGACY_IDX01';


-- Inclui monitoria em indice
ALTER INDEX SETTLEMENTCONTRACT_ADM.AUTO_WITHDRAW_IDX01 MONITORING USAGE;


-- verifica o uso do índice
select ( select u.username from dba_users u where u.user_id=io.owner# ) OWNER,
       t.name TABLE_NAME, io.name INDEX_NAME, 
       decode(bitand(i.flags, 65536), 0, 'NO', 'YES') MONITORING	,
       decode(bitand(ou.flags, 1), 0, 'NO', 'YES') USED,
       ou.start_monitoring START_MONITORING,
       ou.end_monitoring END_MONITORING
from sys.obj$ io, sys.obj$ t, sys.ind$ i, sys.object_usage ou
where io.owner# = (select user_id from dba_users where username=SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM')
  and i.obj# = ou.obj#
  and io.obj# = ou.obj#
  and t.obj# = i.bo#
order by ou.start_monitoring desc, 5  ;
  
  
-- Exclui monitoria em indice
ALTER INDEX RECEIVABLES_ADM.PAYMENT_SUSPENSION_IDX01 NOMONITORING USAGE;

