alter session enable parallel ddl;
alter session enable parallel dml;
alter session enable parallel query;
alter session set ddl_lock_timeout=30;

declare
    resource_busy exception;
    pragma exception_init (resource_busy, -00054);
    naoexecutou    boolean        default true;
    v_count        number         default 0;
    v_schema       varchar(100)   default 'RECEIVABLES_ADM'; --'AD';
    v_table        varchar(100)   default 'RECEIVABLE_UNIT_EXTERNAL_OUTBOX';
    v_field        varchar(100)   default 'JSN_METADATA';
    v_sql_alter    varchar2(2000) default 'ALTER TABLE ' || v_schema || '.' || v_table || ' DROP COLUMN ' || v_field ;

begin
    dbms_output.put_line('Alteração da tabela: ' || v_schema || '.' || v_table);
    select count(1)
        into v_count
        from all_tab_columns
     where owner        = v_schema
        and table_name  = v_table
        and column_name = v_field;

    if v_count = 1 then
        while naoexecutou loop
            begin
                execute immediate v_sql_alter;
                naoexecutou := false;
            exception
                when resource_busy then
                    dbms_session.sleep(0.25);
                when others then
                    raise;
                    dbms_output.put_line('[ERRO RAISE]: ' || to_char(sqlerrm) || ' - ' || to_char(dbms_utility.format_error_backtrace));
            end;
        end loop;
        dbms_output.put_line(upper(v_schema || '.' || v_table || '.' || v_field) || ' - Coluna deletada com sucesso !');
    else
        dbms_output.put_line(upper(v_schema || '.' || v_table || '.' || v_field));
        dbms_output.put_line('Coluna já esta deletada com sucesso !');
    end if;
exception
    when others then
        dbms_output.put_line('[ERRO]: ' || to_char(sqlerrm) || ' - ' || to_char(dbms_utility.format_error_backtrace));
end;
/
