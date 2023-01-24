select b.segment_name,
       a.last_analyzed,
       b.segment_type,
       user,
       sum(b.bytes) size_bytes,
       a.initial_extent,
       a.next_extent,
       sum (a.initial_extent) initial_extent,
       sum (a.next_extent) next_extent,
       a.last_analyzed
  from sys.dba_tables              a
       inner join sys.dba_segments b on (a.table_name = b.segment_name)
 where a.owner = 'RECEIVABLES_ADM'--upper(user)
--   and b.segment_type in ('TABLE', 'INDEX')
--   and b.segment_name not like 'BIN%'
--   and b.segment_name not like 'DBG%'
--   and b.segment_name not like 'PLSQL%'
--   and b.segment_name not like 'TESTE%'
--   and b.segment_name not like 'PLAN%'
--   and b.segment_name = nvl(upper('&NOME_DO_SEGMENTO'), a.table_name)
/*
   and b.segment_name in ('CONTA_DIGITAL_TXT_BLOB',
                          'TB_BILL_IMAGE_XLS_1',
                          'TB_BILL_IMAGE_XLS_2',
                          'TB_BILL_IMAGE_XLS_3',
                          'TB_BILL_IMAGE_XLS_4',
                          'TB_BILL_IMAGE_XLS_5',
                          'TB_BILL_IMAGE_XLS_6',
                          'TB_FATS_NAO_PROC',
                          'TB_PROC_CARGA_XLS')
*/
 group by b.segment_name,
          a.last_analyzed,
          b.segment_type,
          user,
          a.initial_extent,
          a.next_extent,
          a.last_analyzed
 order by 1, 5 desc;
