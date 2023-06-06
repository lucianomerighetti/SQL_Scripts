declare
    type         t_cursor is ref cursor;
    type         t_string_array is table of varchar2(32767) index by binary_integer;
    vcursor      t_cursor;
    varraystring t_string_array;
    icount       binary_integer;
begin
    open vcursor for select 'grand select, update, delete, insert ' || x.table_name || ' to recshedule' tx_script
                       from all_tables x
                      where x.owner = user;
    loop
        fetch vcursor bulk collect into varraystring;
        exit when varraystring.count = 0;
        
        for icount in varraystring.first..varraystring.last loop
            -- execute immediate varraystring(icount).tx_script;
            dbms_output.put_line(varraystring(icount));
        end loop;

        exit when vcursor%notfound;
    end loop;
    close vcursor;
end;