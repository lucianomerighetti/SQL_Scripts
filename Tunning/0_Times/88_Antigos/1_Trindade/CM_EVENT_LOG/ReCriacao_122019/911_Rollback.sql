--+---------------------------------------------------------+--
--  CM_EVENT_LOG - OLD x NEW
--+---------------------------------------------------------+--

-- *** Chaveamento para Galápagos e PHO em modo restrito ***

set echo on
set timing on
set serveroutput on

-- Log de execução - início:
begin
    dbms_output.put_line('Início: ' || to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss')
                      || ' - ' || sys_context('userenv','instance_name')
                      || ' @ ' || sys_context('userenv','server_host'));
end;
/

--+---------------------------------------------------------+--
-- 1. Renomear a tabela CM_EVENT_LOG para CM_EVENT_LOG_NEW
--+---------------------------------------------------------+--

alter table SAFEPAY_ADM.CM_EVENT_LOG     rename to CM_EVENT_LOG_NEW;

alter table SAFEPAY_ADM.CM_EVENT_LOG_OLD rename to CM_EVENT_LOG;


--+---------------------------------------------------------+--
-- 2. Grants da nova tabela CM_EVENT_LOG (antiga "OLD")
--+---------------------------------------------------------+--

grant select on SAFEPAY_ADM.CM_EVENT_LOG to KAFKAEXCHEQUER;
grant select on SAFEPAY_ADM.CM_EVENT_LOG to MANUT_CASCAIS_DR;
grant select on SAFEPAY_ADM.CM_EVENT_LOG to MANUT_BI_PAGSEGURO;
grant select on SAFEPAY_ADM.CM_EVENT_LOG to MANUT_SAFEPAY;
grant select on SAFEPAY_ADM.CM_EVENT_LOG to RL_MANUT_SAFEPAY;
grant select on SAFEPAY_ADM.CM_EVENT_LOG to SAFEPAY_ADMINUBR;
grant select on SAFEPAY_ADM.CM_EVENT_LOG to SAFEPAY_BODIUBR;
grant select on SAFEPAY_ADM.CM_EVENT_LOG to SAFEPAY_QUERYUBR;

grant select, insert, update         on SAFEPAY_ADM.CM_EVENT_LOG to CAYMAN_BALANCE_BLOCKERUBR;
grant select, insert, update, delete on SAFEPAY_ADM.CM_EVENT_LOG to CAYMANUBR;
grant select, insert, update, delete on SAFEPAY_ADM.CM_EVENT_LOG to SAFEPAYUBR;


--+---------------------------------------------------------+--
-- 3. Ajustar nome das constraints e índices das versões OLD e NEW.
--+---------------------------------------------------------+--

-- Constraints da tabela antiga (antiga "OLD")
alter table SAFEPAY_ADM.CM_EVENT_LOG rename constraint CMEVENLOGOLD_PK             to CMEVENLOG_PK;
alter table SAFEPAY_ADM.CM_EVENT_LOG rename constraint CMEVENLOGOLD_UK01           to CMEVENLOG_UK01;
alter table SAFEPAY_ADM.CM_EVENT_LOG rename constraint CMEVENLOGOLD_INDEVENTYPE_CK to CMEVENLOG_INDEVENTYPE_CK;

-- Índices da tabela antiga (agora "OLD")
alter index SAFEPAY_ADM.CMEVENLOGOLD_PK    rename to CMEVENLOG_PK;
alter index SAFEPAY_ADM.CMEVENLOGOLD_UK01  rename to CMEVENLOG_UK01;
alter index SAFEPAY_ADM.CMEVENLOGOLD_IDX01 rename to CMEVENLOG_IDX01;
alter index SAFEPAY_ADM.CMEVENLOGOLD_IDX02 rename to CMEVENLOG_IDX02;

-- Constraints da tabela nova (agora "NEW")
alter table SAFEPAY_ADM.CM_EVENT_LOG_NEW rename constraint CMEVENLOG_PK             to CMEVENLOGNEW_PK;
alter table SAFEPAY_ADM.CM_EVENT_LOG_NEW rename constraint CMEVENLOG_UK01           to CMEVENLOGNEW_UK01;
alter table SAFEPAY_ADM.CM_EVENT_LOG_NEW rename constraint CMEVENLOG_INDEVENTYPE_CK to CMEVENLOGNEW_INDEVENTYPE_CK;

-- Índices da tabela nova (agora "NEW")
alter index SAFEPAY_ADM.CMEVENLOG_PK    rename to CMEVENLOGNEW_PK;
alter index SAFEPAY_ADM.CMEVENLOG_UK01  rename to CMEVENLOGNEW_UK01;
alter index SAFEPAY_ADM.CMEVENLOG_IDX01 rename to CMEVENLOGNEW_IDX01;
alter index SAFEPAY_ADM.CMEVENLOG_IDX02 rename to CMEVENLOGNEW_IDX02;

-- Recria sinônimo público (apenas para revalidar)
create or replace public synonym CM_EVENT_LOG for SAFEPAY_ADM.CM_EVENT_LOG;


--+---------------------------------------------------------+--
-- 4. Tombamento dos dados da tabela CM_EVENT_LOG_NEW para a nova CM_EVENT_LOG
-- OBS: Verificar o horário que finalizou o delivery para colocar o horário anterior a esse
--+---------------------------------------------------------+--

alter session set PARALLEL_FORCE_LOCAL = true;

exec dbms_output.put_line('Horário: ' || to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss'));

insert /*+ append */
into SAFEPAY_ADM.CM_EVENT_LOG
(
   COD_EVENT_CORRELATION,
   DAT_CREATION,
   IDT_CM_EVENT_LOG,
   IDT_TRANSACTION,
   IND_EVENT_TYPE,
   JSON_EVENT_PAYLOAD
)
select /*+ parallel(16) */
   o1.COD_EVENT_CORRELATION,
   o1.DAT_CREATION,
   o1.IDT_CM_EVENT_LOG,
   o1.IDT_TRANSACTION,
   o1.IND_EVENT_TYPE,
   o1.JSON_EVENT_PAYLOAD
from
    SAFEPAY_ADM.CM_EVENT_LOG_NEW o1
where o1.DAT_CREATION >= to_date('2019-12-05 00:03:00','yyyy-MM-dd HH24:MI:SS');

commit;


-- Log de execução - final:
begin
    dbms_output.put_line('Final: ' || to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss'));
end;
/


/*
----------------------------------------
-- Verificações:
----------------------------------------

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS.SSSSS';
col count(*) format 999g999g999g999
--
-- Tabela atual (antiga "OLD"):
select count(*), min(DAT_CREATION), max(DAT_CREATION)
from CM_EVENT_LOG;

-- Tabela abortada (agora "NEW")
select count(*), min(DAT_CREATION), max(DAT_CREATION)
from SAFEPAY_ADM.CM_EVENT_LOG_NEW;

select * from dba_synonyms where synonym_name like 'CM_EVENT_LOG%' order by synonym_name;

select owner, object_name, object_type, status, created, last_ddl_time, timestamp
from dba_objects
where (object_name like 'CM_EVENT_LOG%' or object_name like 'CMEVENLOG%')
order by created, object_name, object_type;

select * from dba_tables where table_name like 'CM_EVENT_LOG%' order by table_name;

select * from dba_constraints
where table_name like 'CM_EVENT_LOG%'
order by last_change, constraint_name;

select * from dba_indexes
where table_name like 'CM_EVENT_LOG%'
order by owner, table_name, index_name;

select * from dba_tab_privs
where table_name like 'CM_EVENT_LOG%'
order by owner, table_name, grantee, privilege;

select grantee, owner, privilege, grantable, hierarchy from dba_tab_privs where table_name = 'CM_EVENT_LOG'
minus
select grantee, owner, privilege, grantable, hierarchy from dba_tab_privs where table_name = 'CM_EVENT_LOG_NEW';

select grantee, owner, privilege, grantable, hierarchy from dba_tab_privs where table_name = 'CM_EVENT_LOG_NEW'
minus
select grantee, owner, privilege, grantable, hierarchy from dba_tab_privs where table_name = 'CM_EVENT_LOG';

--
*/