select owner,
       object_name,
       object_type,
       status
  from all_objects
 where owner = 'DBPROUNI_INSCRICAO_SNAP'
   and object_type = 'TRIGGER';

select owner,
       trigger_name,
       trigger_type,
       status
  from all_triggers
 where owner = 'DBPROUNI_INSCRICAO_SNAP';
 
declare
  dt_inicio timestamp;
  dt_fim    timestamp;
  i_count   number         default 1;
  tx_sql    varchar2(4000) default null;
  cursor cr_metadados is
    select owner,
           object_name,
           object_type,
           status,
           'alter trigger ' || owner || '.' || object_name || ' disable' trigger_disable
      from sys.all_objects 
    where owner = 'DBPROUNI_INSCRICAO_SNAP'
    and object_type = 'TRIGGER'
    and object_name not like 'BIN$%'
    order by 1;
  rc_metadados cr_metadados%rowtype;
begin
  dbms_output.disable;
  dbms_output.enable(1000000000000);    
  dbms_output.enable;
  dt_inicio := systimestamp;
  dbms_output.put_line('Inicio do processamento......: ' || to_char(dt_inicio,'dd/mm/yyyy hh24:mi:ss.ff'));
  open cr_metadados;
  loop
    fetch cr_metadados into rc_metadados;
    exit when cr_metadados%notfound;
    tx_sql := rc_metadados.trigger_disable;
    dbms_output.put_line(tx_sql);
    execute immediate tx_sql;
    i_count := i_count + 1;
  end loop;
  close cr_metadados;
  dbms_output.put_line('Total de registros afetados..: ' || i_count);
  dt_fim := systimestamp;
  dbms_output.put_line('Fim do processamento.........: ' || to_char(dt_fim,'dd/mm/yyyy hh24:mi:ss.ff'));
  dbms_output.put_line('Tempo processamento..........: ' || to_char(dt_fim - dt_inicio,'dd/mm/yyyy hh24:mi:ss.ff'));
end;
/
 