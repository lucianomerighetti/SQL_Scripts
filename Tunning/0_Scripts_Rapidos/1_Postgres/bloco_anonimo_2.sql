do $$
begin

  update cip_liquidator_adm.recovery_financial_movement 
  set ind_status = 'success', 
      dat_update = now()
  where cod_recovery_financial_movement = r.cod_recovery_financial_movement;
	
  exception when others then 

    raise notice '[ERRO]';

    raise notice '% %', SQLERRM, SQLSTATE;
end
$$;    