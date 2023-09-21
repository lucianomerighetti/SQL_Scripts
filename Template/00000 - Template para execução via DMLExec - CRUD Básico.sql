--+--------------------------------------------------------------------------+--
-- MOTIVO:       REC-18742: Adição de script de update para resolução de alarme receivable_internal_not_completed
-- CALL:         
-- SOLICITANTE:  BKO ADs / Receivables Agenda
-- AD:           Luciano Marwell
-- DATA:         29/06/2023
--+--------------------------------------------------------------------------+--
set echo on
set timing on
set serveroutput on
alter session set nls_numeric_characters='.,';
alter session set nls_date_format='yyyy-mm-dd hh24:mi:ss';

select systimestamp "Inicio",
       'REC-18742 - Adição de script de update para resolução de alarme receivable_internal_not_completed' "Atividade",
       sys_context('USERENV', 'SESSION_USER')  || '@' ||
       sys_context('USERENV', 'INSTANCE_NAME') || '/' ||
       sys_context('USERENV', 'SERVICE_NAME')  || '(' ||
       sys_context('USERENV', 'SERVER_HOST') || ')' "Ambiente"
  from dual;

declare
    v_cod_cashout varchar(36);
begin
    
    update receivables_adm.receivable_unit_internal
    set
        flg_committed = 1,
        num_version = num_version + 1,
        dat_update = sysdate
    where
        idt_receivable_unit = 2231288842;
    
    update receivables_adm.receivable_unit_external
    set
        flg_committed = 1,
        num_version = num_version + 1,
        dat_update = sysdate
    where
        idt_receivable_unit = 2530463097;

    commit;
    
exception
    when others then
        rollback;
        dbms_output.put_line('--------------------------------');
        dbms_output.put_line('[ERRO]: ' || to_char(sqlerrm) || ' - ' || to_char(dbms_utility.format_error_backtrace));
        dbms_output.put_line('--------------------------------');
end;
/

select systimestamp "Termino",
       'REC-18742 - Adição de script de update para resolução de alarme receivable_internal_not_completed' "Atividade",
       sys_context('USERENV', 'SESSION_USER')  || '@' ||
       sys_context('USERENV', 'INSTANCE_NAME') || '/' ||
       sys_context('USERENV', 'SERVICE_NAME')  || '(' ||
       sys_context('USERENV', 'SERVER_HOST') || ')' "Ambiente"
  from dual;
