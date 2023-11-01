ALTER SESSION SET ddl_lock_timeout = 30;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET nls_numeric_characters = '.,';
alter session set current_schema = XPTO_ADM;
alter session set optimizer_use_invisible_indexes = true;
alter system set fast_start_parallel_rollback = high;
ALTER SESSION ENABLE PARALLEL DDL;
ALTER SESSION ENABLE PARALLEL DML;
ALTER SESSION ENABLE PARALLEL QUERY;