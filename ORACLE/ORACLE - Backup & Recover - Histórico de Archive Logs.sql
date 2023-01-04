select 'Periodo historico de switch/archivelog (dias)' archive_stat,
       round(max(first_time) - min(first_time)) archive_value
  from v$log_history
union all
select 'Changes no periodo' archive_stat,
       round(max(next_change#) - min(first_change#))  archive_value
  from v$log_history
union all
select 'Changes por dia' archive_stat,
       round((max(first_change#) - min(first_change#)) / (max(first_time)    - min(first_time))) archive_value
  from v$log_history
union all
select 'Switches no periodo' archive_stat,
       (max(sequence#) - min(sequence#) + 1) archive_value
  from v$log_history
union all
select 'Switches por dia'archive_stat,
       round((max(sequence#) - min(sequence#) + 1) / (max(first_time) - min(first_time))) archive_value
  from v$log_history
union all
select 'Volume de Archivelog (MBytes) no periodo'  block_size,
       round(sum(blocks * block_size) / 1024 / 1024) archive_value
  from (select max(blocks)blocks,
               max(block_size)block_size,
               max(first_time)first_time
         from v$archived_log where ARCHIVED = 'YES' group by SEQUENCE#)
union all
select 'Volume de Archivelog (MBytes) por dia' block_size,
        round(sum(blocks * block_size) / 1024 / 1024 / (max(first_time) - min(first_time))) archive_value
  from (select max(blocks)blocks,
               max(block_size) block_size,
               max(first_time)first_time
          from v$archived_log
         where archived = 'YES'
         group by SEQUENCE#)
union all
select 'Switches nas ultimas 24 horas' block_size,
       (max(sequence#) - min(sequence#) + 1) archive_value
  from v$log_history
 where (sysdate-first_time) < 1
union all
select 'Volume de Archivelog (MBytes) nas ultimas 24 horas' block_size,
       round(sum(blocks * block_size) / 1024 / 1024 / (max(first_time) - min(first_time))) archive_value
  from (select max(blocks)     blocks,
               max(block_size) block_size,
               max(first_time)first_time
          from v$archived_log
         where archived = 'YES'
           and (sysdate-first_time) < 1
         group by SEQUENCE#);
/ 
