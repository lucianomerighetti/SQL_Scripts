\c fidc

do $$
declare 
cc cnab_content;
v_count integer := 0;
cur_cnab_content cursor 
	for select cbct.* 
	from cnab_content cbct
        join cnab c on c.dat_reference = cbct.dat_reference
        where cbct.dat_creation > c.dat_processed
        and cbct.dat_reference = '2020-12-16' ;
begin
   open cur_cnab_content;
loop
	fetch cur_cnab_content into cc;
	exit when not found;

    v_count = v_count + 1;
	
	delete from cnab_content where dat_reference = '2020-12-16' 
    and idt_transaction_installment_history = cc.idt_transaction_installment_history;
	
    insert into fidc_adm.cnab_content(idt_transaction_installment_history, idt_transaction, ind_event, dat_reference, dat_escrow, des_content, dat_creation, dat_update, flg_active)
    values(cc.idt_transaction_installment_history, cc.idt_transaction, cc.ind_event, '2020-12-17', cc.dat_escrow, cc.des_content, cc.dat_creation, now(), true);
	
	if mod(v_count, 1000) = 0 then
	
	  commit; 
	  raise notice 'Contagem de Registros: %',v_count;	
	
	end if;	
	
end loop; 
commit;
end; $$