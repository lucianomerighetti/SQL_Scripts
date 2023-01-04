clear screen;

Rem ================================================================================
Rem    NAME
Rem     tbsfile.sql - Script para mostrar as Tablespaces com seus Datafiles 
Rem
Rem    NOTE - Usuarios conectados
Rem
Rem ================================================================================

prompt
prompt ================================================================================
prompt Nome da Instance, Host e Versao
prompt ================================================================================

set lines 200
col versao form a12
col data_atual for a20
col dias_ativos for 999
col startup_time for a20
col host_name for a15
col instance_name for a15

select  upper(instance_name) as instance_name, host_name, '['||version||']' VERSAO,
        to_char(sysdate,'DD/MM/YYYY HH24:MI') DATA_ATUAL,
        to_char(STARTUP_TIME,'DD/MM/YYYY HH24:MI') STARTUP_TIME,
        ROUND(sysdate-startup_time,1) DIAS_ATIVOS
from v$instance
/
prompt
prompt ================================================================================
prompt Relacao de Tablespaces 
prompt ================================================================================

set pagesize 100
set lines 200
column  pct_used format 999.9
column  pct_used heading "%|Used"
column  name    format a36      heading "Tablespace Name"
column  bytes   format 999,999,999,999,999    heading "Total Bytes"
column  maxbytes   format 999,999,999,999,999    heading "Max Bytes"
column  used    format 999,999,999,999,999   heading "Used"
column  free    format 999,999,999,999,999  heading "Free"
column  name    justify left
column  bytes   justify right
column  used    justify right
column  free    justify right
column  pct_used justify right
column dummy noprint
break on report
compute sum label 'Total Bytes' of bytes on report
compute sum of free on report
compute sum of used on report
compute sum of maxbytes on report

select a.tablespace_name name,
       b.tablespace_name dummy,
       (sum(b.bytes) / count(distinct a.file_id || '.' || a.block_id) / 1024 / 1024) as bytes,
       ((sum(b.bytes) / count(distinct a.file_id || '.' || a.block_id) / 1024 / 1024) - (sum(a.bytes) / count(distinct b.file_id) / 1024 / 1024)) used,
       (sum(b.maxbytes) / count(distinct a.file_id || '.' || a.block_id) / 1024 / 1024) maxbytes,
       (sum(a.bytes) / count(distinct b.file_id) / 1024 / 1024) free,
       (100 * ((sum(b.bytes) / count(distinct a.file_id || '.' || a.block_id)) - 
               (sum(a.bytes) / count(distinct b.file_id))) /
               (sum(b.bytes) / count(distinct a.file_id || '.' || a.block_id))) pct_used
  from sys.dba_free_space a
       inner join sys.dba_data_files b on (a.tablespace_name = b.tablespace_name)
 group by a.tablespace_name,
          b.tablespace_name
 order by 7 desc, 1, 2;
 /

set lines 	500
set pages       400
set trimout     on
set trimspool   on
set feed        on
set term        on
set verify      off

col tablespace_name for a10              heading "Tablespace"
col file_name       for a50              heading "File Name"
col maxbytes        for 9999999999999    heading "Max Bytes"
col bytes           for 999,999,999,999  heading "Total Bytes"
col bytes_free      for 999,999,999,999  heading "Free"
col bytes_used      for 999,999,999,999  heading "Used"
col autoextensible  for a2               heading "AE"

compute sum label 'Total Bytes' of bytes on report
compute sum of bytes_free on report
compute sum of bytes_used on report
break on tablespace_name on report

undef tablespace 

prompt ================================================================================
prompt Verfica quais datafiles estao na Tablespace Desejada:
prompt ================================================================================

prompt
accept tablespace prompt 'Qual Tablespace deseja verificar ? '

select a.tablespace_name,
       a.file_name,
       a.maxbytes,
       a.bytes,
       nvl(a.bytes - sum(b.bytes), a.bytes) as bytes_used,
       nvl(sum(b.bytes), 0)                 as bytes_free
  from dba_data_files           a
       left join dba_free_space b on (a.file_id = b.file_id)
 where a.tablespace_name like nvl(upper('&tablespace'), '%')
 group by a.tablespace_name,
          a.file_name,
          a.bytes,
          a.maxbytes
 order by a.file_name asc;
/