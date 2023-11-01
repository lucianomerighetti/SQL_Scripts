ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
set serveroutput on size 90000;

declare

data_inicial date := '2019-05-08 18:59:59';
data_final date := '2019-05-31 23:59:59';
intervalo_inicial date := data_inicial;
intervalo_final date := TO_DATE(data_inicial,'YYYY-MM-DD HH24:MI:SS') + (30/60/24);

begin
  
  dbms_output.enable(null);
  
  dbms_output.put_line('delete from TAXACLIENTES_ADM.FAIXA_DATAS where FLG_PROCESSED = ''N'';');
  
  while data_inicial < data_final loop
  
    dbms_output.put_line('Insert into TAXACLIENTES_ADM.FAIXA_DATAS (DAT_INICIO,DAT_FIM,FLG_PROCESSED) values (to_timestamp('''|| intervalo_inicial ||''',''YYYY-MM-DD HH24:MI:SS''),to_timestamp('''|| intervalo_final ||''',''YYYY-MM-DD HH24:MI:SS''),''N'');');  
  
    data_inicial  :=  TO_DATE(intervalo_inicial,'YYYY-MM-DD HH24:MI:SS') +(30/60/24) ;
    intervalo_inicial  :=  TO_DATE(intervalo_inicial,'YYYY-MM-DD HH24:MI:SS') +(30/60/24) ;
    intervalo_final  :=  TO_DATE(intervalo_final,'YYYY-MM-DD HH24:MI:SS') +(30/60/24) ;  
  
  end loop;
  
  dbms_output.put_line('commit;');
  
end; 