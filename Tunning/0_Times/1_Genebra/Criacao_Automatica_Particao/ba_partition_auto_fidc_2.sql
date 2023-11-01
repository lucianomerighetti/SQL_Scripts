do $$ 
<<first_block>>
declare

-- OBS: A função só funcionará se as tabelas particionadas já tenha alguma partição criada!

  r_data_table record;
  v_initial_interval varchar(30) := null;
  v_final_interval varchar(30) := null;
  v_diff_interval integer := 0;
  v_diff_interval_range integer := 0;
  v_nam_function varchar(100) := null;
  v_dat_ini_interval_day date := null;
  v_dat_end_interval_day date := null;
  v_flg_execute boolean := false;
  
 
-- verifica quais tabelas são particionadas

  c_part_table cursor for  
  
     select par.relnamespace::regnamespace::text as schema 
           ,trim(par.relname) as table_name 
     	   ,trim(pt.partition_strategy) as partition_strategy
           ,trim(col.column_name) as column_name
	       ,substring(trim(col.data_type),1,10) as data_type
     from (select partrelid
     	        ,unnest(partattrs) as column_index
                ,case partstrat 
                   when 'l' then 'list' 
                   when 'r' then 'range' end as partition_strategy
           from pg_partitioned_table) pt 
     join pg_class par 
     on par.oid = pt.partrelid
     join information_schema.columns col
     on col.table_schema = par.relnamespace::regnamespace::text
     and col.table_name = par.relname
     and ordinal_position = pt.column_index
     where par.relkind = 'p'
	 order by par.relname;
 
begin 

   open c_part_table;
   
     loop
   
       fetch from c_part_table into r_data_table;
	 
-- busca os dados da ultima particao
         raise notice 'Table name: %',r_data_table.table_name;
	     
         select substring(x.partition_expression from initial_part_ini for (initial_part_end - initial_part_ini)) as initial_interval
               ,substring(x.partition_expression from final_part_ini for (final_part_end - final_part_ini)) as final_interval
         
         into  v_initial_interval
              ,v_final_interval  	   
         from (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression
                     ,max(position('FROM (' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 7 as initial_part_ini
         	         ,max(position(') TO' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) - 1 as initial_part_end
                     ,max(position('TO (' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 5 as final_part_ini
                     ,max(length(pg_get_expr(pt.relpartbound, pt.oid, true))) - 1 as final_part_end
               from pg_class base_tb 
               join pg_inherits i on i.inhparent = base_tb.oid 
               join pg_class pt on pt.oid = i.inhrelid
               where base_tb.oid = r_data_table.table_name::regclass) x;
         
	     if r_data_table.data_type in ('date','timestamp') then
         
           raise notice 'data_type: %',r_data_table.data_type;
	     
	     -- verifica o intervalo da particao (podendo ser dia ou mes)	   
           if v_final_interval is null or v_initial_interval is null then
		   
		     v_initial_interval = cast(now() as date);
		     v_final_interval = cast(now() as date);		   		   
		   
		   end if;
	       
  	       v_diff_interval = v_final_interval::date - v_initial_interval::date;
		   
           raise notice 'v_final_interval: %',v_final_interval;
           raise notice 'v_initial_interval: %',v_initial_interval;	
  	       raise notice 'v_diff_interval: %',v_diff_interval;		 
		   
-- verifica o intervalo de particoes existentes com a data de hoje	
	     
 	       v_diff_interval_range = v_final_interval::date - cast(now() as date);
		   		   
           raise notice 'v_diff_interval_range: %',v_diff_interval_range;				 
		   
-- v_di  ff_interval = 1 : tabela particionada por dia	
-- v_di  ff_interval_range < 7 : tem menos de 7 particoes livres	 
         
		   if v_diff_interval = 1 and v_diff_interval_range < 7 then
		   
	         v_dat_ini_interval_day := v_final_interval::date + interval '1 day'; 
         
		     v_dat_end_interval_day := v_dat_ini_interval_day::date + interval '6 month'; 
		     
		     v_flg_execute := true;
		   
-- v_di  ff_interval > 1 : tabela particionada por mes
-- (v_d  iff_interval_range / 30) < 6 : a diferença de dias dividido por 30 vai dar um valor próximos de meses
-- veri  ficando se tem menos de 6 partições
         
		   elsif v_diff_interval > 1 and (v_diff_interval_range / 30) < 6 then
		   
		   	 v_dat_ini_interval_day := v_final_interval::date + interval '1 month'; 
         
		     v_dat_end_interval_day := v_dat_ini_interval_day::date + interval '12 month'; 
         
		     v_flg_execute := true;
		     
		   end if;
		   
	     end if; 
         
         if v_flg_execute is true then
         
 	       select proname
 	       into v_nam_function
		   from pg_proc
		   where proname like '%'||r_data_table.table_name;
		     
           raise notice 'v_dat_ini_interval_day: %',v_dat_ini_interval_day;	
           raise notice 'v_dat_end_interval_day: %',v_dat_end_interval_day;	
           raise notice 'v_nam_function: %',v_nam_function;		   
		   execute 'select '||v_nam_function||'('''||v_dat_ini_interval_day::date||''', '''||v_dat_end_interval_day::date||''');';
         
	     end if;

     end loop;	 
	 
   close c_part_table;	   
	   
END first_block $$; 