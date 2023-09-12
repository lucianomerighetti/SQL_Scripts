alter session enable parallel ddl;
alter session enable parallel dml;
alter session enable parallel query;
alter session set ddl_lock_timeout=30;

declare
    resource_busy exception;
    pragma exception_init (resource_busy, -00054);
    
    f_naoexecutou  boolean        default true;
    v_count        number         default 0;
    v_nullable     varchar(1)     default null;

    v_schema       varchar(100)   default 'RECEIVABLES_ADM';
    v_table        varchar(100)   default 'CCE_REASSOCIATE_RECEIVABLE';
    v_index        varchar(100)   default 'CCE_REASSOCIATE_RECEIVABLE_IDX01';
    v_field        varchar(100)   default 'IDT_RECEIVABLE_INTERNAL';
    v_tspace       varchar(100)   default 'TSIRECEIVABLES04';
    
    v_pctfree      number         default 20;
    v_initrans     number         default 36;
    v_parallel     number         default 64;

    v_sql_drop   varchar2(4000) default 'DROP INDEX  '  || v_schema || '.' || v_index;
    v_sql_alter  varchar2(4000) default 'ALTER INDEX  ' || v_schema || '.' || v_index || ' NOPARALLEL';
    v_sql_create varchar2(4000) default 'CREATE INDEX ' || v_schema || '.' || v_index || ' ON ' || v_schema || '.' || v_table || ' (' || v_field || ') ' ||
                                        'LOCAL '      ||
                                        'ONLINE '     ||
                                        'PCTFREE '    || v_pctfree  || ' ' ||
                                        'INITRANS '   || v_initrans || ' ' ||
                                        'TABLESPACE ' || v_tspace   || ' ' ||
                                        'PARALLEL '   || v_parallel;
begin
    dbms_output.put_line('Alteração da tabela - Criação de indice: ' || v_schema || '.' || v_index);

    select count(1)
      into v_count
      from sys.all_indexes
     where owner      = v_schema
       and table_name = v_table
       and index_name = v_index;

    --Remover indice
    if v_count = 1 then
        f_naoexecutou := true;
        while f_naoexecutou loop
            begin
                execute immediate v_sql_drop;
                --dbms_output.put_line(v_sql_drop);
                f_naoexecutou := false;
                dbms_output.put_line('Indice ' || v_schema || '.' || v_index || ' removido');
            exception
                when resource_busy then dbms_session.sleep(0.25);
                when others then raise;
            end;
        end loop;
    end if;

    --Criar indice
    if v_count = 1 then
        --Criação do indice
        f_naoexecutou := true;
        while f_naoexecutou loop
            begin
                execute immediate v_sql_create;
                --dbms_output.put_line(v_sql_create);
                f_naoexecutou := false;
                dbms_output.put_line('Indice ' || v_schema || '.' || v_index || ' criado');
            exception
                when resource_busy then dbms_session.sleep(0.25);
                when others then raise;
            end;
        end loop;
        
        -- Remover paralelismo
        f_naoexecutou := true;
        while f_naoexecutou loop
            begin
                execute immediate v_sql_alter;
                --dbms_output.put_line(v_sql_alter);
                f_naoexecutou := false;
                dbms_output.put_line('Indice ' || v_schema || '.' || v_index || ' sem paralelismo');
            exception
                when resource_busy then dbms_session.sleep(0.25);
                when others then raise;
            end;
        end loop;

        dbms_output.put_line('Indice ' || v_schema || '.' || v_index || ' criado com sucesso');
    else
        dbms_output.put_line('Indice ' || v_schema || '.' || v_index || ' já existe');
    end if;
end;
/