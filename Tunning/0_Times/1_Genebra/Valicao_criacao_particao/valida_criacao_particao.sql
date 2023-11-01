-- GENEBRA  
  select 
     date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') date_partition  
    ,date_trunc('day',now() at time zone 'America/Sao_Paulo') as actual_date
    ,extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
                       date_trunc('day',now() at time zone 'America/Sao_Paulo'))) as countdown
    ,case when extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
    date_trunc('day',now() at time zone 'America/Sao_Paulo'))) >= 7 then 'OK' else 'NOK' end call_function_create_partition
  from 
   (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression,
	       max(position('TO' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 5 as position_date					
    from pg_class base_tb 
    join pg_inherits i on i.inhparent = base_tb.oid 
    join pg_class pt on pt.oid = i.inhrelid
    where base_tb.oid = 'cnab_content'::regclass) x;

  select 
     date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd HH24:MI:SS') at time zone 'America/Sao_Paulo') date_partition  
    ,date_trunc('day',now() at time zone 'America/Sao_Paulo') as actual_date
    ,extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd HH24:MI:SS') at time zone 'America/Sao_Paulo') -
                       date_trunc('day',now() at time zone 'America/Sao_Paulo'))) as countdown
    ,case when extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd HH24:MI:SS') at time zone 'America/Sao_Paulo') -
    date_trunc('day',now() at time zone 'America/Sao_Paulo'))) >= 7 then 'OK' else 'NOK' end call_function_create_partition
  from 
   (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression,
	       max(position('TO' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 5 as position_date					
    from pg_class base_tb 
    join pg_inherits i on i.inhparent = base_tb.oid 
    join pg_class pt on pt.oid = i.inhrelid
    where base_tb.oid = 'payment_release_event'::regclass) x;
    
  select 
     date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') date_partition  
    ,date_trunc('day',now() at time zone 'America/Sao_Paulo') as actual_date
    ,extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
                       date_trunc('day',now() at time zone 'America/Sao_Paulo'))) as countdown
    ,case when extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
    date_trunc('day',now() at time zone 'America/Sao_Paulo'))) >= 30 then 'OK' else 'NOK' end call_function_create_partition
  from 
   (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression,
	       max(position('TO' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 5 as position_date					
    from pg_class base_tb 
    join pg_inherits i on i.inhparent = base_tb.oid 
    join pg_class pt on pt.oid = i.inhrelid
    where base_tb.oid = 'prepayment_installment'::regclass) x;
	
  select 
     date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') date_partition  
    ,date_trunc('day',now() at time zone 'America/Sao_Paulo') as actual_date
    ,extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
                       date_trunc('day',now() at time zone 'America/Sao_Paulo'))) as countdown
    ,case when extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
    date_trunc('day',now() at time zone 'America/Sao_Paulo'))) >= 30 then 'OK' else 'NOK' end call_function_create_partition
  from 
   (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression,
	       max(position('TO' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 5 as position_date					
    from pg_class base_tb 
    join pg_inherits i on i.inhparent = base_tb.oid 
    join pg_class pt on pt.oid = i.inhrelid
    where base_tb.oid = 'settlement_installment'::regclass) x;	
	
  select 
     to_number(substring (x.partition_expression from x.init_position_number for (x.last_position_number - x.init_position_number)),'9999999999999999') as max_partition  
    ,(select max(idt_transaction) from transaction) as max_value_used 
    ,to_number(substring (x.partition_expression from x.init_position_number for (x.last_position_number - x.init_position_number)),'9999999999999999') -  
     (select max(idt_transaction) from transaction) as countdown     
    ,case when ((to_number(substring (x.partition_expression from x.init_position_number for (x.last_position_number - x.init_position_number)),'9999999999999999'))  -
     (select max(idt_transaction) from transaction)) / 10000000 >= 7 then 'OK' else 'NOK' end call_function_create_partition
  from 
   (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression,
           max(position('TO' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 3 as init_position_number,
           length(max(pg_get_expr(pt.relpartbound, pt.oid, true))) - 1 as last_position_number
           
    from pg_class base_tb 
    join pg_inherits i on i.inhparent = base_tb.oid 
    join pg_class pt on pt.oid = i.inhrelid
    where base_tb.oid = 'transaction'::regclass) x; 
	
  select 
     date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd HH24:MI:SS') at time zone 'America/Sao_Paulo') date_partition  
    ,date_trunc('day',now() at time zone 'America/Sao_Paulo') as actual_date
    ,extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd HH24:MI:SS') at time zone 'America/Sao_Paulo') -
                       date_trunc('day',now() at time zone 'America/Sao_Paulo'))) as countdown
    ,case when extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd HH24:MI:SS') at time zone 'America/Sao_Paulo') -
    date_trunc('day',now() at time zone 'America/Sao_Paulo'))) >= 30 then 'OK' else 'NOK' end call_function_create_partition
  from 
   (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression,
	       max(position('TO' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 5 as position_date					
    from pg_class base_tb 
    join pg_inherits i on i.inhparent = base_tb.oid 
    join pg_class pt on pt.oid = i.inhrelid
    where base_tb.oid = 'transaction_history'::regclass) x;	
	
  select 
     date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') date_partition  
    ,date_trunc('day',now() at time zone 'America/Sao_Paulo') as actual_date
    ,extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
                       date_trunc('day',now() at time zone 'America/Sao_Paulo'))) as countdown
    ,case when extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
    date_trunc('day',now() at time zone 'America/Sao_Paulo'))) >= 30 then 'OK' else 'NOK' end call_function_create_partition
  from 
   (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression,
	       max(position('TO' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 5 as position_date					
    from pg_class base_tb 
    join pg_inherits i on i.inhparent = base_tb.oid 
    join pg_class pt on pt.oid = i.inhrelid
    where base_tb.oid = 'transaction_installment'::regclass) x;		
	
  select 
     date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd HH24:MI:SS') at time zone 'America/Sao_Paulo') date_partition  
    ,date_trunc('day',now() at time zone 'America/Sao_Paulo') as actual_date
    ,extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd HH24:MI:SS') at time zone 'America/Sao_Paulo') -
                       date_trunc('day',now() at time zone 'America/Sao_Paulo'))) as countdown
    ,case when extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd HH24:MI:SS') at time zone 'America/Sao_Paulo') -
    date_trunc('day',now() at time zone 'America/Sao_Paulo'))) >= 7 then 'OK' else 'NOK' end call_function_create_partition
  from 
   (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression,
	       max(position('TO' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 5 as position_date					
    from pg_class base_tb 
    join pg_inherits i on i.inhparent = base_tb.oid 
    join pg_class pt on pt.oid = i.inhrelid
    where base_tb.oid = 'transaction_installment_history'::regclass) x;		
	
-- MIAMI	
	
  select 
     date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') date_partition  
    ,date_trunc('day',now() at time zone 'America/Sao_Paulo') as actual_date
    ,extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
                       date_trunc('day',now() at time zone 'America/Sao_Paulo'))) as countdown
    ,case when extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
    date_trunc('day',now() at time zone 'America/Sao_Paulo'))) >= 8 then 'OK' else 'NOK' end call_function_create_partition
  from 
   (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression,
	       max(position('TO' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 5 as position_date					
    from pg_class base_tb 
    join pg_inherits i on i.inhparent = base_tb.oid 
    join pg_class pt on pt.oid = i.inhrelid
    where base_tb.oid = 'payment_release_antecipation_date'::regclass) x;			
		
  select 
     date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') date_partition  
    ,date_trunc('day',now() at time zone 'America/Sao_Paulo') as actual_date
    ,extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
                       date_trunc('day',now() at time zone 'America/Sao_Paulo'))) as countdown
    ,case when extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
    date_trunc('day',now() at time zone 'America/Sao_Paulo'))) >= 8 then 'OK' else 'NOK' end call_function_create_partition
  from 
   (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression,
	       max(position('TO' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 5 as position_date					
    from pg_class base_tb 
    join pg_inherits i on i.inhparent = base_tb.oid 
    join pg_class pt on pt.oid = i.inhrelid
    where base_tb.oid = 'payment_release_by_blocked_date'::regclass) x;		
	
 select 
     date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') date_partition  
    ,date_trunc('day',now() at time zone 'America/Sao_Paulo') as actual_date
    ,extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
                       date_trunc('day',now() at time zone 'America/Sao_Paulo'))) as countdown
    ,case when extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
    date_trunc('day',now() at time zone 'America/Sao_Paulo'))) >= 8 then 'OK' else 'NOK' end call_function_create_partition
  from 
   (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression,
	       max(position('IN' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 5 as position_date					
    from pg_class base_tb 
    join pg_inherits i on i.inhparent = base_tb.oid 
    join pg_class pt on pt.oid = i.inhrelid
    where base_tb.oid = 'payment_release_by_history_date'::regclass) x;			
	
  select 
     date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') date_partition  
    ,date_trunc('day',now() at time zone 'America/Sao_Paulo') as actual_date
    ,extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
                       date_trunc('day',now() at time zone 'America/Sao_Paulo'))) as countdown
    ,case when extract(day from (date_trunc('day',to_date(substring (x.partition_expression from x.position_date for 19),'yyyy-MM-dd') at time zone 'America/Sao_Paulo') -
    date_trunc('day',now() at time zone 'America/Sao_Paulo'))) >= 8 then 'OK' else 'NOK' end call_function_create_partition
  from 
   (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression,
	       max(position('TO' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 5 as position_date					
    from pg_class base_tb 
    join pg_inherits i on i.inhparent = base_tb.oid 
    join pg_class pt on pt.oid = i.inhrelid
    where base_tb.oid = 'payment_release_by_release_date'::regclass) x;		

  select 
     to_number(substring (x.partition_expression from x.init_position_number for (x.last_position_number - x.init_position_number)),'9999999999999999') as max_partition  
    ,(select max(idt_payment_release) from payment_release_history) as max_value_used 
    ,to_number(substring (x.partition_expression from x.init_position_number for (x.last_position_number - x.init_position_number)),'9999999999999999') -  
     (select max(idt_payment_release) from payment_release_history) as countdown     
    ,case when ((to_number(substring (x.partition_expression from x.init_position_number for (x.last_position_number - x.init_position_number)),'9999999999999999'))  -
     (select max(idt_payment_release) from payment_release_history)) / 125000000 >= 7 then 'OK' else 'NOK' end call_function_create_partition
  from 
   (select max(pg_get_expr(pt.relpartbound, pt.oid, true)) as partition_expression,
           max(position('TO' in (pg_get_expr(pt.relpartbound, pt.oid, true)))) + 5 as init_position_number,
           length(max(pg_get_expr(pt.relpartbound, pt.oid, true))) - 1 as last_position_number
           
    from pg_class base_tb 
    join pg_inherits i on i.inhparent = base_tb.oid 
    join pg_class pt on pt.oid = i.inhrelid
    where base_tb.oid = 'payment_release_history'::regclass) x; 	