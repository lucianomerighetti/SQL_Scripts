--+---------------------------------------------------------+--
--  CM_EVENT_LOG - OLD x NEW
--+---------------------------------------------------------+--

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
-- 1. Criar a tabela CM_EVENT_LOG_NEW
--+---------------------------------------------------------+--

create table SAFEPAY_ADM.CM_EVENT_LOG_NEW
(
  IDT_CM_EVENT_LOG      number(20) not null constraint CMEVENLOGNEW_PK primary key
                                            using index tablespace TSICMEVENTLOG02_2 pctfree 15 initrans 100,
  IDT_TRANSACTION       number(10) not null,
  COD_EVENT_CORRELATION varchar2(124), 
  IND_EVENT_TYPE        number(1)  not null constraint CMEVENLOGNEW_INDEVENTYPE_CK check (IND_EVENT_TYPE in (1,2,3,4,5,6)),
  DAT_CREATION          timestamp(6) default systimestamp not null,
  JSON_EVENT_PAYLOAD    clob,
  constraint CMEVENLOGNEW_UK01
  unique
  ( COD_EVENT_CORRELATION,
    IND_EVENT_TYPE 
  )
  using index tablespace TSICMEVENTLOG02_2 pctfree 10 initrans 100
)
lob (JSON_EVENT_PAYLOAD) store as basicfile
( tablespace TSDCMEVENTLOG02_2 enable storage in row chunk 8192 retention )
tablespace TSDCMEVENTLOG02_2
pctfree 10
initrans 32;

alter table SAFEPAY_ADM.CM_EVENT_LOG_NEW noparallel;

alter index SAFEPAY_ADM.CMEVENLOGNEW_PK noparallel;

alter index SAFEPAY_ADM.CMEVENLOGNEW_UK01 noparallel;


comment on table SAFEPAY_ADM.CM_EVENT_LOG_NEW
is 'Historico de troca de mensagens CAYMAN x SAFEPAYUBR. Transacoes com saldo liberado atraves do CAYMAN';

comment on column SAFEPAY_ADM.CM_EVENT_LOG_NEW.IDT_CM_EVENT_LOG      is 'Identificador da tabela - SEQUENCE: SQ_CMEVENHIST_IDT';
comment on column SAFEPAY_ADM.CM_EVENT_LOG_NEW.IDT_TRANSACTION       is 'Identificador da transação, sem necessidade de manter a chave de referência com tabela TRANSACTION';
comment on column SAFEPAY_ADM.CM_EVENT_LOG_NEW.COD_EVENT_CORRELATION is 'Identificador do evento pra correlacionar as mensagens';
comment on column SAFEPAY_ADM.CM_EVENT_LOG_NEW.IND_EVENT_TYPE        is '(1) Request Sent
(2) Request Received
(3) Response Sent
(4) Response Received
(5) Confirmation Sent
(6) Confirmation Received';
comment on column SAFEPAY_ADM.CM_EVENT_LOG_NEW.DAT_CREATION          is 'Data de criação do registro';
comment on column SAFEPAY_ADM.CM_EVENT_LOG_NEW.JSON_EVENT_PAYLOAD    is 'Salva mensagens do pagseguro para o cayman.';


--+---------------------------------------------------------+--
-- 2. Renomear a tabela CM_EVENT_LOG_NEW para CM_EVENT_LOG
--+---------------------------------------------------------+--

alter table SAFEPAY_ADM.CM_EVENT_LOG     rename to CM_EVENT_LOG_OLD;

alter table SAFEPAY_ADM.CM_EVENT_LOG_NEW rename to CM_EVENT_LOG;

--+---------------------------------------------------------+--
-- 3. Grants da nova tabela CM_EVENT_LOG ("new" já renomeada)
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
-- 4. Tombamento dos dados da tabela CM_EVENT_LOG_OLD para a nova CM_EVENT_LOG
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
    SAFEPAY_ADM.CM_EVENT_LOG_OLD o1
where o1.DAT_CREATION >= cast((trunc(sysdate-1) + interval '2' hour) as timestamp);

commit;


--+---------------------------------------------------------+--
-- 5. Criar demais índices da tabela nova, após a carga inicial.
--+---------------------------------------------------------+--

exec dbms_output.put_line('Horário: ' || to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss'));

-- Não necessitam de claúsula "online", pois a PHO estará em "modo restrito".

create index SAFEPAY_ADM.CMEVENLOGNEW_IDX01
on SAFEPAY_ADM.CM_EVENT_LOG (IDT_TRANSACTION)
tablespace TSICMEVENTLOG02_2 
pctfree 10 
initrans 100
parallel 16;

alter index SAFEPAY_ADM.CMEVENLOGNEW_IDX01 noparallel;

create index SAFEPAY_ADM.CMEVENLOGNEW_IDX02
on SAFEPAY_ADM.CM_EVENT_LOG (DAT_CREATION, IND_EVENT_TYPE) 
tablespace TSICMEVENTLOG02_2 
pctfree 20 
initrans 100
parallel 16;

alter index SAFEPAY_ADM.CMEVENLOGNEW_IDX02 noparallel;


--+---------------------------------------------------------+--
-- 6. Ajustar nome das constraints e índices das versões OLD e NEW.
--+---------------------------------------------------------+--

-- Constraints da tabela antiga (agora "OLD")
alter table SAFEPAY_ADM.CM_EVENT_LOG_OLD rename constraint CMEVENLOGNEW12_PK             to CMEVENLOGOLD_PK;
alter table SAFEPAY_ADM.CM_EVENT_LOG_OLD rename constraint CMEVENLOGNEW12_UK01           to CMEVENLOGOLD_UK01;
alter table SAFEPAY_ADM.CM_EVENT_LOG_OLD rename constraint CMEVENLOGNEW12_INDEVENTYPE_CK to CMEVENLOGOLD_INDEVENTYPE_CK;

-- Índices da tabela antiga (agora "OLD")
alter index SAFEPAY_ADM.CMEVENLOGNEW12_PK    rename to CMEVENLOGOLD_PK;
alter index SAFEPAY_ADM.CMEVENLOGNEW12_UK01  rename to CMEVENLOGOLD_UK01;
alter index SAFEPAY_ADM.CMEVENLOGNEW12_IDX01 rename to CMEVENLOGOLD_IDX01;
alter index SAFEPAY_ADM.CMEVENLOGNEW12_IDX02 rename to CMEVENLOGOLD_IDX02;

-- Constraints da tabela nova (era "NEW")
alter table SAFEPAY_ADM.CM_EVENT_LOG rename constraint CMEVENLOGNEW_PK             to CMEVENLOG_PK;
alter table SAFEPAY_ADM.CM_EVENT_LOG rename constraint CMEVENLOGNEW_UK01           to CMEVENLOG_UK01;
alter table SAFEPAY_ADM.CM_EVENT_LOG rename constraint CMEVENLOGNEW_INDEVENTYPE_CK to CMEVENLOG_INDEVENTYPE_CK;

-- Índices da tabela nova (era "NEW")
alter index SAFEPAY_ADM.CMEVENLOGNEW_PK    rename to CMEVENLOG_PK;
alter index SAFEPAY_ADM.CMEVENLOGNEW_UK01  rename to CMEVENLOG_UK01;
alter index SAFEPAY_ADM.CMEVENLOGNEW_IDX01 rename to CMEVENLOG_IDX01;
alter index SAFEPAY_ADM.CMEVENLOGNEW_IDX02 rename to CMEVENLOG_IDX02;

-- Recria sinônimo público (apenas para revalidar)
create or replace public synonym CM_EVENT_LOG for SAFEPAY_ADM.CM_EVENT_LOG;


--+---------------------------------------------------------+--
-- 7. Coletar de estatísticas.
--+---------------------------------------------------------+--

exec dbms_output.put_line('Horário: ' || to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss'));

begin
   DBMS_STATS.GATHER_TABLE_STATS
   ( ownname => 'SAFEPAY_ADM',
     tabname => 'CM_EVENT_LOG',
     cascade => true,
     degree  => 16
   );
end;
/

-- Log de execução - final:
begin
    dbms_output.put_line('Final: ' || to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss'));
end;
/


/*
----------------------------------------
-- Verificações:
----------------------------------------

-- Pegar a hora final de execucao do script e colocar como filtro do script de tombamento do rollback

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS.SSSSS';
col count(*) format 999g999g999g999
--
-- Tabela nova:
select count(*), min(DAT_CREATION), max(DAT_CREATION)
from CM_EVENT_LOG;

-- Tabela antiga (agora "OLD")
select count(*), min(DAT_CREATION), max(DAT_CREATION)
from SAFEPAY_ADM.CM_EVENT_LOG_OLD
where DAT_CREATION >= cast((trunc(sysdate-1) + interval '2' hour) as timestamp);

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
select grantee, owner, privilege, grantable, hierarchy from dba_tab_privs where table_name = 'CM_EVENT_LOG_OLD';

select grantee, owner, privilege, grantable, hierarchy from dba_tab_privs where table_name = 'CM_EVENT_LOG_OLD'
minus
select grantee, owner, privilege, grantable, hierarchy from dba_tab_privs where table_name = 'CM_EVENT_LOG';

--
*/