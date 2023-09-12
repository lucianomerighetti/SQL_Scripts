--+--------------------------------------------------------------------------+--
-- MOTIVO:        REC-14049 - Levantamento de pagamentos com erro em divisão de taxas nos recebíveis
-- CALL:         
-- SOLICITANTE:  Agenda de Débitos - Agenda
-- AD:           Luciano Marwell    
-- DATA:         24/10/2022
--+--------------------------------------------------------------------------+--
set echo on
set timing on
set serveroutput on
alter session set nls_numeric_characters='.,';
alter session set nls_date_format='yyyy-mm-dd hh24:mi:ss';

select systimestamp "Inicio",
    'REC-14049 - Levantamento de pagamentos com erro em divisão de taxas nos recebíveis' "Atividade",
    sys_context('USERENV', 'SESSION_USER')  || '@' ||
    sys_context('USERENV', 'INSTANCE_NAME') || '/' ||
    sys_context('USERENV', 'SERVICE_NAME')  || '(' ||
    sys_context('USERENV', 'SERVER_HOST') || ')' "Ambiente"
from dual;

declare
    registro number;

    cursor cr_calendario(dt_inicial date, dt_final date) is
        select level id,
               (dt_inicial + rownum - 1) dt_calendario
          from dual
        connect by level <= ((dt_final - dt_inicial) + 1);

    type ty_calendario is table of cr_calendario%rowtype index by pls_integer;
    rc_calendario ty_calendario;
    
    iregistro number(20) default 0;
    
begin
    select count(1)
      into registro
      from receivables_adm.cce_change_event_schedule  
    where
            dat_partition = date '2022-11-28'
        and flg_processed = 1;
    
    dbms_output.put_line('Antes da atualização: ' || registro);
    
    open cr_evento;
    
    loop
        fetch cr_evento bulk collect into rc_evento limit 10000;
        
        exit when rc_evento.count = 0;
        
        for iregistro in 1..rc_evento.count loop
            begin
                update receivables_adm.cce_change_event_schedule
                set
                    flg_processed = 0,
                    dat_update = systimestamp
                where
                        idt_cce_change_event_schedule = rc_evento(iregistro).idt_cce_change_event_schedule;
            
                commit;
            exception
                when others then null;
            end;
        end loop;
        
    end loop;
    
    close cr_evento;
    
    select count(1)
      into registro
      from receivables_adm.cce_change_event_schedule  
    where
            dat_partition = date '2022-11-28'
        and flg_processed = 1;

    dbms_output.put_line('Apos da atualização: ' || registro);

exception
    when others then
        rollback;
        dbms_output.put_line('[ERRO]: ' || to_char(sqlerrm) || chr(10) || to_char(dbms_utility.format_error_backtrace));
        dbms_output.put_line('--------------------------------');
end;
/

select systimestamp "Termino",
    'REC-14049 - Levantamento de pagamentos com erro em divisão de taxas nos recebíveis' "Atividade",
    sys_context('USERENV', 'SESSION_USER')  || '@' ||
    sys_context('USERENV', 'INSTANCE_NAME') || '/' ||
    sys_context('USERENV', 'SERVICE_NAME')  || '(' ||
    sys_context('USERENV', 'SERVER_HOST') || ')' "Ambiente"
from dual;
