select t.tablespace_name,
       t.status,
       t.contents
  from sys.dba_tablespaces t
order by 1, 2, 3;
  
select t.tablespace_name,
       t.status,
       t.contents,
       f.file_name,
       f.file_id,
       f.bytes,
       f.user_bytes,
       s.owner,
       s.segment_type,
       s.segment_name,
       sum(s.bytes) bytes_do_segmento
  from sys.dba_tablespaces            t
       inner join sys.dba_data_files  f on (t.tablespace_name = f.tablespace_name)
       inner join sys.dba_extents     s on (f.tablespace_name = s.tablespace_name and
                                            f.file_id         = s.file_id)
 where 1 = 1
   and t.tablespace_name = 'TSIRECEIVABLES06'
group by t.tablespace_name,
         t.status,
         t.contents,
         f.file_name,
         f.file_id,
         f.bytes,
         f.user_bytes,
         s.owner,
         s.segment_type,
         s.segment_name
order by 1, 5, 8, 9, 10;

select f.file_id,
       t.tablespace_name,
       t.status,
       t.contents,
       f.file_name,
       --f.bytes,
       --f.user_bytes,
       count(distinct s.owner ||'.' || s.segment_type ||'.' || s.segment_name) total_objetos,
       sum(s.bytes) tamanho_segmento_bytes
  from sys.dba_tablespaces            t
       inner join sys.dba_data_files  f on (t.tablespace_name = f.tablespace_name)
       inner join sys.dba_extents     s on (f.tablespace_name = s.tablespace_name and
                                            f.file_id         = s.file_id)
 where 1 = 1
   and t.tablespace_name like 'TS_REC%'
group by f.file_id,
         t.tablespace_name,
         t.status,
         t.contents,
         f.file_name
         --f.bytes,
         --f.user_bytes
order by 1, 2;