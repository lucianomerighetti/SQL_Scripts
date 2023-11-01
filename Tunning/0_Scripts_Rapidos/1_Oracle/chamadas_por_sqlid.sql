select ss.snap_id,
       ss.instance_number node,
       begin_interval_time, end_interval_time,
       sql_id,
       plan_hash_value,
       nvl(executions_delta, 0) execs,
       (elapsed_time_delta /
       decode(nvl(executions_delta, 0), 0, 1, executions_delta)) / 1000000 avg_etime,
       ROUND(OSHIST.VALUE,2) avg_load,
       (buffer_gets_delta / decode(nvl(buffer_gets_delta, 0), 0, 1, executions_delta)) avg_lio,
       (PHYSICAL_READ_BYTES_DELTA / decode(nvl(PHYSICAL_READ_BYTES_DELTA, 0), 0, 1, executions_delta)) avg_phyreads,
       (DISK_READS_DELTA / decode(nvl(DISK_READS_DELTA, 0), 0, 1, executions_delta)) avg_diskreads
  from DBA_HIST_SQLSTAT S, DBA_HIST_SNAPSHOT SS, dba_hist_osstat oshist
 where sql_id in ('0jd86xdm139k0')
   and ss.snap_id = oshist.snap_id
   and ss.instance_number = S.instance_number
   and ss.snap_id = S.snap_id   
   and ss.instance_number = oshist.INSTANCE_NUMBER (+)
   and oshist.STAT_NAME = 'LOAD'
   and executions_delta > 0
   and begin_interval_time > sysdate - 1
 order by 1, 2, 3