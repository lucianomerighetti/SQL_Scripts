set serveroutput on size 30000;

declare
    cursor c1 is
    select high_value,
           partition_name
      from dba_tab_partitions
     where table_name = 'CASHOUT';

    partition_date varchar2(100);
    partition_name varchar2(1000);
    date_val       date;
    name_val       varchar2(100);
begin
    for c1rec in c1 loop
        partition_date := 'SELECT ' || c1rec.high_value || ' FROM DUAL';
        partition_name := 'SELECT ' || c1rec.partition_name || ' FROM DUAL';
        
        execute immediate partition_date into date_val;
        --execute immediate partition_name into date_val;

        dbms_output.put_line(date_val);
        dbms_output.put_line(c1rec.partition_name);
    end loop;
end;