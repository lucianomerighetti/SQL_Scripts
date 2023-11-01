-- Tamanho em ranges de bytes
SELECT e.owner
, e.segment_name
, ROUND(sum(e.bytes)/1024/1024,2) "SIZE (MB)" 
, ROUND(sum(e.bytes)/1024/1024/1024,2) "SIZE (GB)" 
, ROUND(sum(e.bytes)/1024/1024/1024/1024,2) "SIZE (TB)" 
FROM dba_extents e 
where e.owner = 'SAFEPAY_ADM' 
and E.SEGMENT_NAME = 'TRANSACTION_PAYMENT_ATTEMPT' 
GROUP BY e.owner
, e.segment_name 
;

-- medias de DMLs por tabela
select a.owner,a.table_name,a.num_rows,
a.last_analyzed period_start_analyze,
sysdate         period_end_analyze,
ROUND(b.INSERTS / TRUNC(sysdate - (a.last_analyzed - 1)),2) AVG_INSERT_DAY,
ROUND(b.UPDATES / TRUNC(sysdate - (a.last_analyzed - 1)),2) AVG_UPDATE_DAY,
ROUND(b.DELETES / TRUNC(sysdate - (a.last_analyzed - 1)),2) AVG_DELETE_DAY
from all_tables a
join dba_tab_modifications b  on a.owner = b.table_owner and a.table_name = b.table_name
where a.owner = 'SAFEPAY_ADM' and
a.table_name = 'TRANSACTION_PAYMENT_ATTEMPT' ;


-- tamanho do banco por período (retenção do AWR)
select trunc(snap.end_interval_time) data, 
	   round(SUM(tablespace_size*t.block_size)/1024/1024/1024/1024,2) size_tb,
	   round(SUM(tablespace_usedsize*t.block_size)/1024/1024/1024/1024,2) usedsize_tb
from DBA_HIST_TBSPC_SPACE_USAGE s, DBA_HIST_SNAPSHOT snap, DBA_HIST_TABLESPACE th, DBA_TABLESPACES t
where s.snap_id=snap.snap_id 
  and s.tablespace_id=th.ts#
  and th.tsname=t.tablespace_name
  and snap.snap_id in (select min(snap_id) from DBA_HIST_SNAPSHOT group by trunc(end_interval_time))
  and snap.instance_number=1
group by trunc(snap.end_interval_time)
order by 1;


-- Size por tabela
SELECT OWNER, TABLE_NAME, COMP COMPRESSION, PART, DECODE(PARTITIONED,'/','NO',PARTITIONED) PARTITIONED, COLUMN_PARTITION, 
      DATA_TB, QTD_IDX QDADE_INDEX, INDX_TB, LOB_TB, TOTAL_TB, AVG_INSERT_DAY, AVG_ROW_LEN
    FROM (  SELECT  DATA.TABLE_NAME, (SELECT COMPR.COMPRESSION FROM DBA_TABLES COMPR WHERE COMPR.OWNER=DATA.OWNER 
	        AND COMPR.TABLE_NAME=DATA.TABLE_NAME)COMP, 
                  (SELECT PART.PARTITIONED FROM DBA_TABLES PART WHERE PART.OWNER=DATA.OWNER AND PART.TABLE_NAME=DATA.TABLE_NAME)PART,
                  (SELECT COUNT(1) FROM DBA_INDEXES IDX WHERE IDX.OWNER=DATA.OWNER AND IDX.TABLE_NAME=DATA.TABLE_NAME)QTD_IDX,
                  DATA.OWNER, PARTITIONING_TYPE || DECODE (SUBPARTITIONING_TYPE, 'none', NULL, '/' || SUBPARTITIONING_TYPE)
                  PARTITIONED,  NVL(DATA_TB,0) DATA_TB, NVL(INDX_TB,0) INDX_TB, NVL(LOB_TB,0) LOB_TB,
                  NVL(DATA_TB,0) + NVL(INDX_TB,0) + NVL(LOB_TB,0) TOTAL_TB,                    
                  MODIF.AVG_INSERT_DAY, DATA.AVG_ROW_LEN, DATA.COLUMN_PARTITION
          FROM  ( SELECT OWNER, TABLE_NAME, AVG_ROW_LEN, COLUMN_PARTITION, ROUND(SUM(DATA_TB),2) DATA_TB
                  FROM (  SELECT OWNER, TABLE_NAME, AVG_ROW_LEN, COLUMN_PARTITION, DATA_TB
                          FROM (  SELECT T.OWNER, T.TABLE_NAME, T.AVG_ROW_LEN, PKC.COLUMN_NAME AS COLUMN_PARTITION, S.BYTES/1024/1024/1024/1024 AS DATA_TB
                                  FROM DBA_TABLES T
                                  INNER JOIN DBA_SEGMENTS S
                                  ON T.OWNER=S.OWNER
                                  LEFT JOIN DBA_PART_KEY_COLUMNS PKC
                                  ON T.OWNER = PKC.OWNER
                                  AND T.TABLE_NAME = PKC.NAME
                                  WHERE T.TABLE_NAME = S.SEGMENT_NAME                                  
                                  AND T.OWNER=SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
                                  AND S.SEGMENT_TYPE IN ('TABLE','TABLE PARTITION','TABLE SUBPARTITION')
                                  ))                                
                  GROUP BY OWNER, TABLE_NAME, AVG_ROW_LEN, COLUMN_PARTITION) DATA,
                ( SELECT A.TABLE_NAME, ROUND(SUM(B.BYTES/1024/1024/1024/1024),2) AS INDX_TB
                  FROM DBA_INDEXES A, DBA_SEGMENTS B
                  WHERE A.INDEX_NAME = B.SEGMENT_NAME(+) AND A.OWNER=B.OWNER(+) AND A.OWNER=SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
                  GROUP BY A.TABLE_NAME) INDX,
                ( SELECT A.TABLE_NAME, ROUND(SUM(B.BYTES/1024/1024/1024/1024),2) AS LOB_TB
                  FROM DBA_LOBS A, DBA_SEGMENTS B
                  WHERE A.SEGMENT_NAME = B.SEGMENT_NAME(+) AND A.OWNER=B.OWNER(+) AND A.OWNER=SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM' 
                  GROUP BY A.TABLE_NAME) LOB,
                ( SELECT DT.OWNER,DT.TABLE_NAME,
                         ROUND(SUM(DTM.INSERTS) / TRUNC(SYSDATE -(DT.LAST_ANALYZED - 1)), 2) AVG_INSERT_DAY
                  FROM DBA_TABLES  DT
                  INNER JOIN DBA_TAB_MODIFICATIONS DTM 
				  ON DT.OWNER = DTM.TABLE_OWNER
                  AND DT.TABLE_NAME = DTM.TABLE_NAME
                  WHERE DT.OWNER = SUBSTR(SYS_CONTEXT('USERENV','DB_NAME'),4,50)||'_ADM'
                  GROUP BY DT.OWNER, DT.TABLE_NAME, DT.LAST_ANALYZED) MODIF                  
                  , DBA_PART_TABLES PART				  
          WHERE DATA.TABLE_NAME = INDX.TABLE_NAME(+) AND
                DATA.TABLE_NAME = LOB.TABLE_NAME(+)  AND
                DATA.TABLE_NAME = MODIF.TABLE_NAME(+)  AND                
                DATA.TABLE_NAME = PART.TABLE_NAME(+) AND             
                DATA.OWNER = PART.OWNER(+)
  ORDER BY TOTAL_TB DESC);
  

-- Espaço servidor
select group_number, name group_name, state, type, trunc(total_mb/1024/1024) total_tb, trunc(free_mb/1024/1024) free_tb, trunc(usable_file_mb/1024/1024) usable_file_tb,
decode(total_mb,0,0,trunc(free_mb/total_mb*100,2)) free_pct
from v$asm_diskgroup
order by group_number;  


