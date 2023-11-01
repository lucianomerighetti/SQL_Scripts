ALTER SESSION SET nls_numeric_characters = '.,';
set heading on;
set colsep ','
set pagesize 0 embedded on;
set linesize 10000;
set echo off;
set verify off;
spool P:\smoreira\consolidado_agenda_cliente_20201014.txt
<query>;
spool off;


