alter session enable parallel ddl;
alter session enable parallel dml;
alter session enable parallel query;
alter session set ddl_lock_timeout=30;

declare
    resource_busy exception;
    pragma exception_init (resource_busy, -00054);
    naoexecutou boolean default true;
    v_count      number default 0;

    v_schema     varchar(100)   default 'RECEIVABLES_ADM'; --'AD';
    v_table      varchar(100)   default 'RECEIVABLE_EXTERNAL';
    v_index      varchar(100)   default 'RECEIVABLE_EXTERNAL_IDX05';
    v_unique     varchar(100)   default 'RECEIVABLE_EXTERNAL_UK02';
    v_field      varchar(100)   default 'DAT_SETTLE, IDT_PAYMENT';
    v_tablespace varchar(100)   default 'TSIRECEIVABLES09';
    
    v_pctfree    number         default 8;
    v_initrans   number         default 22;
    v_parallel   number         default 64;

    v_sql_drop_index    varchar2(4000) default 'DROP INDEX ' || v_schema || '.' || v_index;
    v_sql_alter_index   varchar2(4000) default 'ALTER INDEX ' || v_schema || '.' || v_index || ' NOPARALLEL';
    v_sql_create_index  varchar2(4000) default 'CREATE INDEX ' || v_schema || '.' || v_index || ' ON ' || v_schema || '.' || v_table || ' (' || v_field || ') ' ||
                                               'LOCAL '      ||
                                               'ONLINE '     ||
                                               'PCTFREE '    || v_pctfree    || ' ' ||
                                               'INITRANS '   || v_initrans   || ' ' ||
                                               'TABLESPACE ' || v_tablespace || ' ' ||
                                               'PARALLEL '   || v_parallel;
    v_sql_drop_unique   varchar2(4000) default 'ALTER TABLE ' || v_schema || '.' || v_table || ' DROP CONSTRAINT ' || v_unique;
    v_sql_create_unique varchar2(4000) default 'ALTER TABLE ' || v_schema || '.' || v_table || ' ADD CONSTRAINT ' || v_unique || ' UNIQUE ('|| v_field ||') USING INDEX ' || v_schema || '.' || v_index || ' ENABLE NOVALIDATE';

begin
    select count(1)
      into v_count
      from sys.dba_indexes
     where owner      = v_schema
       and table_name = v_table
       and index_name = v_index;

    if v_count = 0 then    
        naoexecutou := true;
        while naoexecutou loop
            begin
                execute immediate v_sql_create_index;
                --dbms_output.put_line(v_sql_create_index);
                naoexecutou := false;
            exception
                when resource_busy then
                    dbms_session.sleep(0.25);
                when others then
                    raise;
                    dbms_output.put_line('[ERRO RAISE]: ' || to_char(sqlerrm) || ' - ' || to_char(dbms_utility.format_error_backtrace));
            end;
        end loop;
        dbms_output.put_line(upper(v_schema || '.' || v_index) || ' - Indice criado com sucesso');
        naoexecutou := true;
        while naoexecutou loop
            begin
                execute immediate v_sql_alter_index;
                --dbms_output.put_line(v_sql_alter_index);
                naoexecutou := false;
            exception
                when resource_busy then dbms_session.sleep(0.25);
                when others then raise;
            end;
        end loop;
        dbms_output.put_line(upper(v_schema || '.' || v_index) || ' - Paralelismo removido com sucesso');
    else
        dbms_output.put_line(upper(v_schema || '.' || v_index || '.(' || v_field || ')'));
        dbms_output.put_line('Indice já existe!');
    end if;
    
    select count(1)
      into v_count
      from sys.dba_constraints
     where owner           = v_schema
       and table_name      = v_table
       and constraint_name = v_unique;

    if v_count = 0 then
        naoexecutou := true;
        while naoexecutou loop
            begin
                execute immediate v_sql_create_unique;
                --dbms_output.put_line(v_sql_create_unique);
                naoexecutou := false;
            exception
                when resource_busy then
                    dbms_session.sleep(0.25);
                when others then
                    raise;
                    dbms_output.put_line('[ERRO RAISE]: ' || to_char(sqlerrm) || ' - ' || to_char(dbms_utility.format_error_backtrace));
            end;
        end loop;
        dbms_output.put_line(upper(v_schema || '.' || v_unique) || ' - Chave unica criada com sucesso');
    else
        dbms_output.put_line(upper(v_schema || '.' || v_unique || '.(' || v_field || ')'));
        dbms_output.put_line('Chave unica já existe!');
    end if;
end;
/
