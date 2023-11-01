do $$
declare r record;
begin
    for r in 
	  select cod_recovery_financial_movement
	  from cip_liquidator_adm.recovery_financial_movement
      where cod_recovery_financial_movement in (
          'abee2348-a4a6-4f63-a2cf-142304a21430'
          )
    loop
	  begin
        update cip_liquidator_adm.recovery_financial_movement 
	    set ind_status = 'success', 
		    dat_update = now()
	    where cod_recovery_financial_movement = r.cod_recovery_financial_movement;
	
        exception when others then 

          raise notice '[ERRO]';

          raise notice '% %', SQLERRM, SQLSTATE;
      end;		  
    end loop;
end$$;    