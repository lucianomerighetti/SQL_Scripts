select distinct
       a.owner,
       a.table_name,
       segment_name,
       segment_type,
--       user,
       b.bytes,
       (case
         when length(a.initial_extent / 1024)        =  3 then ((a.initial_extent / 1024)        || ' KB')
         when length(a.initial_extent / 1024 / 1024) >= 3 then ((a.initial_extent / 1024 / 1024) || ' MB')
       end) initi,
       (case
         when length(a.next_extent / 1024)        =  3 then ((a.next_extent / 1024)        || ' KB')
         when length(a.next_extent / 1024 / 1024) >= 3 then ((a.next_extent / 1024 / 1024) || ' MB')
       end) nexte,
       a.last_analyzed
  from sys.dba_tables              a
       inner join sys.dba_segments b on (a.table_name = b.segment_name)
 where a.owner = 'RECEIVABLES_ADM'
   and b.segment_name not like 'BIN%'
   and b.segment_name not like 'DBG%'
   and b.segment_name not like 'PLSQL%'
   and b.segment_name not like 'TESTE%'
   and b.segment_name not like 'PLAN%'
   and b.segment_name LIKE '%OUTBOX
   %'
--   and b.segment_name = nvl(upper('&NOME_DO_SEGMENTO'), a.table_name)
--   and b.segment_type in ('TABLE', 'INDEX', 'LOB')
--   and a.owner = upper(user)
 order by 1, 2, 3;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

select table_name,
       decode(partitioned,'/','NO',partitioned) partitioned,
       num_rows,
       data_mb,
       indx_mb,
       lob_mb,
       total_mb
  from (select data.
               table_name,
               (partitioning_type || decode (subpartitioning_type, 'none', null, '/' || subpartitioning_type)) partitioned,
               num_rows,
               nvl(data_mb,0) data_mb,
               nvl(indx_mb,0) indx_mb,
               nvl(lob_mb,0) lob_mb,
               (nvl(data_mb,0) + nvl(indx_mb,0) + nvl(lob_mb,0)) total_mb
          from (select table_name,
                       nvl(min(num_rows),0) num_rows,
                       round(sum(data_mb),2) data_mb
                  from (select table_name,
                               num_rows,
                               data_mb
                          from (select a.table_name,
                                       a.num_rows,
                                       (b.bytes / 1024 / 1024) data_mb
                                  from user_tables a,
                                       user_segments b
                                 where a.table_name = b.segment_name))
                 group by table_name) data,
               (select a.table_name,
                       round(sum(b.bytes/1024/1024),2) indx_mb
                  from user_indexes a,
                       user_segments b
                 where a.index_name = b.segment_name
                 group by a.table_name) indx,
               (select a.table_name,
                       round(sum(b.bytes/1024/1024),2) lob_mb
                  from user_lobs a,
                       user_segments b
                 where a.segment_name = b.segment_name 
                 group by a.table_name) lob,  
               user_part_tables part
         where data.table_name = indx.table_name(+)  
           and data.table_name = lob.table_name(+)   
           and data.table_name = part.table_name(+)) 
 where table_name like '%OUTBOX%'
 order by table_name;
