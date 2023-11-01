do $$ 
declare

  p_ini date := '2021-05-01 00:00:00';
  p_fin date := '2021-05-31 00:00:00';
  v_date_purge date := null;
  v_cod_nonexist_recovery_idempotency uuid := null;
 
 
begin 

  for v_date_purge in
    select date_trunc('day', dd):: date
     from generate_series
        ( p_ini::timestamp 
        , p_fin::timestamp
        , '1 day'::interval) dd
        
	   
	loop
	
      raise notice 'date purge: %',v_date_purge;	
	  
        for v_cod_nonexist_recovery_idempotency in
          select cod_nonexist_recovery_idempotency
          from cip_liquidator_adm.nonexist_recovery_idempotency
          where date_trunc('day', dat_creation) = v_date_purge
		
	        loop

	          begin
	     
	            delete 
	            from cip_liquidator_adm.nonexist_recovery_idempotency
	            where cod_nonexist_recovery_idempotency = v_cod_nonexist_recovery_idempotency;	  

                commit;				
				
		        begin
                  exception 
                    when others then
                    begin
                      raise notice '% ', (sqlerrm); 
                      rollback;
			        end;
                end;  			   

			  end;	
	     
	        end loop;

	end loop;
     
end $$;	
