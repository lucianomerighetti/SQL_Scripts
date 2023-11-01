create or replace function dbaad.create_partition_auto_fidc()
    returns text
    language 'plpgsql'

    cost 100
    volatile 
as $body$
declare
  v_dat_partition date;
  v_dat_actual date := date_trunc('day',now() at time zone 'America/Sao_Paulo');  
  v_dat_ini_interval_day date;
  v_dat_end_interval_day date;
  v_dat_interval_month date;  
  v_num_interval integer  := 0;
  v_num_countdown integer := 0;
  v_flg_call_function varchar(3) := null;
  a_table_name_part_day text[] := '{"cnab_content","payment_release_event","transaction_installment_history"}';
  a_table_name_part_month text[] := '{"prepayment_installment","settlement_installment","transaction_history","transaction_installment"}';
  a_table_name_part_num text[] := '{"transaction"}';  
  v_qty_partition integer := 7;
  v_msg text := null;
  v_table_name text := null;
  
  
 
begin 

-- tabelas com partições por dia

  for i in 1 .. array_upper(a_table_name_part_day, 1)
  loop

    begin
    
	   v_table_name := a_table_name_part_day[i];
       v_dat_partition := null;
       v_num_countdown := 0;
       v_flg_call_function := null;   
    
      select 
         coalesce(date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo'),date_trunc('day',now() at time zone 'America/Sao_Paulo')) dat_partition  
        ,coalesce(extract(day from (coalesce(date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo'),date_trunc('day',now() at time zone 'America/Sao_Paulo')) -
         date_trunc('day',now() at time zone 'America/Sao_Paulo'))),0) as num_countdown
        ,case when coalesce(extract(day from (coalesce(date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo'),date_trunc('day',now() at time zone 'America/Sao_Paulo')) -
        date_trunc('day',now() at time zone 'America/Sao_Paulo'))),0) >= v_qty_partition then 'OK' else 'NOK' end flg_call_function
	    				   
	    into v_dat_partition
            ,v_num_countdown
            ,v_flg_call_function		
      
      from 
       (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression,
	           max(position('TO' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 5 as position_date					
        from pg_class base_tb 
        join pg_inherits i on i.inhparent = base_tb.oid 
        join pg_class pt on pt.oid = i.inhrelid
        where base_tb.oid = v_table_name::regclass) x;
	    
	    if v_flg_call_function = 'NOK' then
	      if v_dat_partition <> v_dat_actual then
	        v_dat_ini_interval_day :=  v_dat_partition + interval '1 day'; 
	      else
	        v_dat_ini_interval_day :=  v_dat_partition; 
          end if;	  
	      v_dat_end_interval_day := v_dat_ini_interval_day + interval '6 month'; 
        end if;

		if v_flg_call_function = 'NOK' then
		  raise notice 'Partitions NOK: %',v_table_name;
		  case 
		    when v_table_name = 'cnab_content' then
			  perform create_partition_cnab_content(v_dat_ini_interval_day, v_dat_end_interval_day);
			when v_table_name = 'payment_release_event' then
			  perform create_partition_payment_release_event_(v_dat_ini_interval_day, v_dat_end_interval_day);
			when v_table_name = 'transaction_installment_history' then
			  perform create_partition_transaction_installment_history(v_dat_ini_interval_day, v_dat_end_interval_day);
		  end case;
		  raise notice 'Partitions CREATED: %',v_table_name;
  	    end if;
		
    exception
      when no_data_found then
	  	v_msg := 'Tabela não encontrada: %',v_table_name;
          return msg;  
      when raise_exception then
          return v_table_name; 	  
    end;
  end loop;
  
-- tabelas com partições por mês  
  
  for i in 1 .. array_upper(a_table_name_part_month, 1)
  loop

    begin
    
	   raise notice 'v_table_name: %',a_table_name_part_month[i];
	   v_table_name := a_table_name_part_month[i];
       v_dat_partition := null;
       v_num_countdown := 0;
       v_flg_call_function := null;   
    
      select 
         coalesce(date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo'),date_trunc('day',now() at time zone 'America/Sao_Paulo')) dat_partition  
        ,coalesce(extract(day from (coalesce(date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo'),date_trunc('day',now() at time zone 'America/Sao_Paulo')) -
         date_trunc('day',now() at time zone 'America/Sao_Paulo'))),0) as num_countdown
        ,case when coalesce(extract(day from (coalesce(date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo'),date_trunc('day',now() at time zone 'America/Sao_Paulo')) -
        date_trunc('day',now() at time zone 'America/Sao_Paulo'))),0) >= v_qty_partition then 'OK' else 'NOK' end flg_call_function
	    				   
	    into v_dat_partition
            ,v_num_countdown
            ,v_flg_call_function		
      
      from 
       (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression,
	           max(position('TO' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 5 as position_date					
        from pg_class base_tb 
        join pg_inherits i on i.inhparent = base_tb.oid 
        join pg_class pt on pt.oid = i.inhrelid
        where base_tb.oid = v_table_name::regclass) x;

	    if v_flg_call_function = 'NOK' then
	      if v_dat_partition <> v_dat_actual then
	        v_dat_ini_interval_day :=  v_dat_partition + interval '1 day'; 
	      else
	        v_dat_ini_interval_day :=  v_dat_partition; 
          end if;	  
	      v_dat_end_interval_day := v_dat_ini_interval_day + interval '12 month'; 
        end if;

		if v_flg_call_function = 'NOK' then
		  raise notice 'Partitions NOK: %',v_table_name;
		  case 
		    when v_table_name = 'prepayment_installment' then
			  perform create_partition_prepayment_installment(v_dat_ini_interval_day, v_dat_end_interval_day);			  
			when v_table_name = 'settlement_installment' then
			  perform create_partition_settlement_installment(v_dat_ini_interval_day, v_dat_end_interval_day);
			when v_table_name = 'transaction_history' then
			  perform create_partition_transaction_history(v_dat_ini_interval_day, v_dat_end_interval_day);
			when v_table_name = 'transaction_installment' then
			  perform create_partition_transaction_installment(v_dat_ini_interval_day, v_dat_end_interval_day);
 		  end case;
		  raise notice 'Partitions CREATED: %',v_table_name;
		end if;
		
    exception
      when no_data_found then
	  	v_msg := 'Tabela não encontrada: %',v_table_name;
          return msg;  
      when raise_exception then
          return v_table_name; 	  
		
	end;
  end loop;  

-- tabelas com partições por range de números
  
end;
$body$;