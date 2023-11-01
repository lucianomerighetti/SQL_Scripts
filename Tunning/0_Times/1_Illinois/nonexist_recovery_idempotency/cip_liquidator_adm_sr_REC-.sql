--+---------------------------------------------------------+--
 -- MOTIVO:	REC- Tombamento de dados para a tabela nonexist_recovery_idempotency_new 
 -- Log: 
 -- Solicitante : Semiramis Moreira
 -- TIME: 	Recebiveis-Agenda
 -- AD:		Semiramis Moreira
 --+---------------------------------------------------------+--
  
do $$ 
declare

  v_nam_partition varchar(30) := null;  
  v_dat_partition varchar(30) := null;  
  v_string_execute varchar(300) := null;  
  
begin 

     for v_nam_partition, v_dat_partition in
       select substring(pt.relname from 5 for 15) nam_partition
	         ,replace(substring(pt.relname from 5 for 15),'_','-') dat_partition
       from pg_class base_tb 
       join pg_inherits i on i.inhparent = base_tb.oid 
       join pg_class pt on pt.oid = i.inhrelid
	   join pg_stat_all_tables st on pt.oid = st.relid
       where  base_tb.relname = 'nonexist_recovery_idempotency_new' 	   
       order by pt.relname	 
	   
	 loop
  
	   v_string_execute := 'insert into cip_liquidator_adm.nri_' || v_nam_partition || ' select * from cip_liquidator_adm.nonexist_recovery_idempotency where date_trunc(''day'',dat_creation) = '''||v_dat_partition||'''';
	 
--       raise notice 'Sintaxe: %', v_string_execute;
		 
	   execute v_string_execute;    

     end loop;	 	 
	   
END $$;	