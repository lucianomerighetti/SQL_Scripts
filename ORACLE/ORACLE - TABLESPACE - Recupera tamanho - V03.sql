col tablespace_name for a30
col "Size GB" for a12
col "Used GB" for a12
col "Free GB" for a12
col "Free %" for a7
col "Max Size GB" for a12
col "HWM GB" for a12

select vw.tablespace_name,
       vw.bigfile,
       vw.block_size,
       vw.contents,
       to_char(vw.size_gb,'999G999G990','nls_numeric_characters=,.') "Size GB",
       to_char(vw.used_gb,'999G999G990','nls_numeric_characters=,.') "Used GB",
       to_char(vw.free_gb,'999G999G990','nls_numeric_characters=,.') "Free GB",
       to_char(vw.pct_free,'990D00','nls_numeric_characters=,.') "Free %",
       to_char(vw.maxsize_gb,'999G999G990','nls_numeric_characters=,.') "Max Size GB",
       to_char(vw.hwm_gb,'999G999G990','nls_numeric_characters=,.') "HWM GB",
       to_char(vw.size_gb-hwm_gb,'999G999G990','nls_numeric_characters=,.') "Reduce GB"
  from (
         select a.tablespace_name,
                a.bigfile,
                a.block_size,
                a.contents,
                b.size_gb,
                round((b.bytes-nvl(c.free_bytes,0))/1073741824) used_gb,
                c.free_gb,
                  round((nvl(c.free_bytes,0)/nvl(b.bytes,1)*100),2) pct_free,
                b.maxsize_gb,
                round((nvl(e.block_id,0)*a.block_size)/1073741824) hwm_gb
         select *
           from (
                 select tablespace_name,
                        bigfile,
                        contents,
                        block_size
                   from dba_tablespaces
                  where contents <> 'UNDO'
               ) a,
               inner join (
                            select tablespace_name,
                                   sum(bytes) bytes,
                                   round(nvl(sum(bytes/1073741824),0)) size_gb,
                                   round(nvl(sum(decode(autoextensible,'YES',maxbytes,bytes)/1073741824),0)) maxsize_gb
                              from dba_data_files
                             group by tablespace_name
                          ) b on (a.tablespace_name = b.tablespace_name)
               left  join (
                            select tablespace_name,
                                   sum(bytes) free_bytes,
                                   round(nvl(sum(bytes/1073741824),0)) free_gb
                              from dba_free_space
                             group by tablespace_name
                          ) c on (a.tablespace_name = c.tablespace_name)
               left  join (
                            select tablespace_name,
                                   max(block_id) block_id
                              from dba_extents
                             group by tablespace_name
                          ) e on (a.tablespace_name = e.tablespace_name)
       ) vw
order by "Reduce GB" desc;
