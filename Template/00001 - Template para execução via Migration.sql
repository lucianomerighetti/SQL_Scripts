alter session enable parallel ddl;
alter session enable parallel dml;
alter session enable parallel query;
alter session set ddl_lock_timeout=30;

declare
    resource_busy exception;
    pragma exception_init (resource_busy, -00054);
    naoexecutou  boolean        default true;
    v_count      number         default 0;
    v_schema     varchar(100)   default 'AD';--'RECEIVABLES_ADM'; --'AD';
    v_table      varchar(100)   default 'RECEIVABLE_EXTERNAL';
    v_unique     varchar(100)   default 'RECEIVABLE_EXTERNAL_UK02';
    v_field      varchar(100)   default 'IDT_PAYMENT, DAT_SETTLE';
    v_sql_create varchar2(2000) default 'ALTER TABLE' || v_schema || '.' || v_table || ' ADD CONSTRAINT ' || v_unique || 'UNIQUE (' || v_field || ') NOVALIDATE';
    v_sql_drop   varchar2(2000) default 'ALTER TABLE' || v_schema || '.' || v_table || ' DROP CONSTRAINT ' || v_unique;
begin
    select count(1)
      into v_count
      from sys.dba_indexes
     where owner      = v_schema
       and table_name = v_table
       and index_name = v_unique;

    if v_count = 0 then
        while naoexecutou loop
            begin
                execute immediate v_sql_create;
                naoexecutou := false;
            exception
                when resource_busy then
                    dbms_session.sleep(0.25);
                when others then
                    raise;
                    dbms_output.put_line('[ERRO RAISE]: ' || to_char(sqlerrm) || ' - ' || to_char(dbms_utility.format_error_backtrace));
            end;
        end loop;
        dbms_output.put_line('Chave unica criada com sucesso !');
    else
        dbms_output.put_line(upper(v_schema || '.' || v_unique || '.(' || v_field || ')'));
        dbms_output.put_line('Chave unica existe com sucesso !');
    end if;
exception
    when others then
        dbms_output.put_line('[ERRO]: ' || to_char(sqlerrm) || ' - ' || to_char(dbms_utility.format_error_backtrace));
end;