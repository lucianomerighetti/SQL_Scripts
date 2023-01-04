clear breaks
clear computes
clear columns

set pagesize 50
set linesize 120
set heading on

column tablespace_name heading 'Tablespace' justify left  format a20 truncated
column tbsize          heading 'Size|(Mb) ' justify left  format 9,999,999.99
column tbused          heading 'Used|(Mb) ' justify right format 9,999,999.99
column tbfree          heading 'Free|(Mb) ' justify right format 9,999,999.99
column tbusedpct       heading 'Used % '    justify left  format a8
column tbfreepct       heading 'Free % '    justify left  format a8

break on report

compute sum label 'Totais:' of tbsize tbused tbfree on report

select t.tablespace_name,
        round(a.bytes, 2)         tbsize,
        nvl(round(c.bytes, 2), 0) tbfree,
        nvl(round(b.bytes, 2), 0) tbused,
        nvl(round(100 *(nvl(b.bytes, 0) / nvl(a.bytes, 1)), 2), 0) tbusedpct, --|| '%' tbusedpct,
        nvl(round(100 *(nvl(c.bytes, 0) / nvl(a.bytes, 1)), 2), 0) tbfreepct  --|| '%' tbfreepct
   from dba_tablespaces t
        left join (select tablespace_name,
                          round(sum(bytes) / 1024 / 1024, 2) bytes
                     from dba_data_files
                    group by tablespace_name
                   union
                   select tablespace_name,
                          round(sum(bytes) / 1024 / 1024, 2) bytes
                     from dba_temp_files
                    group by tablespace_name
                  ) a on (t.tablespace_name = a.tablespace_name)
        left join (select e.tablespace_name,
                          round(sum(e.bytes) / 1024 / 1024, 2) bytes
                     from dba_segments e
                    group by e.tablespace_name
                   union
                   select tablespace_name,
                          sum(max_size) bytes
                     from v$sort_segment
                    group by tablespace_name
                  ) b on (t.tablespace_name = b.tablespace_name)
        left join (select f.tablespace_name,
                          round(sum(f.bytes) / 1024 / 1024, 2) bytes
                     from dba_free_space f
                    group by f.tablespace_name
                   union
                   select tmp.tablespace_name,
                          (sum(bytes / 1024 / 1024) - sum(max_size)) bytes
                     from dba_temp_files            tmp
                          inner join v$sort_segment sort on (tmp.tablespace_name = sort.tablespace_name)
                    group by tmp.tablespace_name
                  )c on (t.tablespace_name = c.tablespace_name)
  order by t.tablespace_name;