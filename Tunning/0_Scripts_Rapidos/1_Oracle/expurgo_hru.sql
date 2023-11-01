alter session set nls_date_format = 'YYYY-MM-DD';
set serveroutput on
set echo on
set timing on

-- executar para pegar a menor data de expurgo
--select min(dat_snapshot) from hru_adm.receivable_unit_reg_output -- 2022-02-21

declare

  limit_in pls_integer := 10000;
  qty_del number;

-- Primeiro Cursor - gera as datas de expurgo
  cursor c_dates is
    select date '2022-02-21' + level - 1 date_purge
    from   dual
   connect by level <= (
     date '2022-02-28' - date  '2022-02-21' + 1);

-- Segundo Cursor - buscar os dados 
  cursor c_purge(p_date_purge date) is
    select ro.idt_receivable_unit_reg_output
          ,rbi.idt_receivable_unit_reg_batch_item
          ,rbi.idt_receivable_unit_reg_batch
          ,ro.idt_receivable_unit_reg
    from hru_adm.receivable_unit_reg_output ro
    inner join hru_adm.receivable_unit_reg_batch_item rbi
    on ro.idt_receivable_unit_reg_output = rbi.idt_receivable_unit_reg_output
    where dat_snapshot = p_date_purge;  
  
   --declarando a variavel que receberá os registros da tabela 
   type ty_purge  
   is 
   table of c_purge%rowtype index by pls_integer;
   mc_purge ty_purge;

   --abre o primeiro cursor
   begin
        
     for r_dates in c_dates loop  		
		
       open c_purge(r_dates.date_purge);
         loop
           fetch c_purge bulk collect into mc_purge limit limit_in;
             exit when mc_purge.count = 0;
                  
               -- Primeira a ser expurgada: receivable_unit_reg_output
               forall indx_1 in 1 .. mc_purge.count
	  			    
                 delete
                 from hru_adm.receivable_unit_reg_output
                 where idt_receivable_unit_reg_output = mc_purge(indx_1).idt_receivable_unit_reg_output;
          
		         qty_del := qty_del + sql%rowcount;
		  
                 if (mod(qty_del,10000) = 0) then
			      commit;
		    	 end if;
                
                 dbms_output.put_line('Linhas afetadas - receivable_unit_reg_output: ' || qty_del);
                 qty_del := 0;
				
               -- Segunda a ser expurgada: receivable_unit_reg_batch_item
               forall indx_2 in 1 .. mc_purge.count
	  			    
                 delete
                 from hru_adm.receivable_unit_reg_batch_item
                 where idt_receivable_unit_reg_batch_item = mc_purge(indx_2).idt_receivable_unit_reg_batch_item;
          
		         qty_del := qty_del + sql%rowcount;
		  
                 if (mod(qty_del,10000) = 0) then
			      commit;
		    	 end if;
                
                 dbms_output.put_line('Linhas afetadas - receivable_unit_reg_batch_item: ' || qty_del);
	  		     qty_del := 0;
			 
               -- Terceira a ser expurgada: receivable_unit_reg_batch
               forall indx_3 in 1 .. mc_purge.count
	  			    
                 delete
                 from hru_adm.receivable_unit_reg_batch
                 where idt_receivable_unit_reg_batch = mc_purge(indx_3).idt_receivable_unit_reg_batch;
          
		         qty_del := qty_del + sql%rowcount;
		  
                 if (mod(qty_del,10000) = 0) then
			      commit;
		    	 end if;
                
                 dbms_output.put_line('Linhas afetadas - receivable_unit_reg_batch: ' || qty_del);
	  		     qty_del := 0;				 
	   
               -- Quarta a ser expurgada: receivable_unit_reg
               forall indx_4 in 1 .. mc_purge.count
	  			    
                 delete
                 from hru_adm.receivable_unit_reg
                 where idt_receivable_unit_reg_batch = mc_purge(indx_4).receivable_unit_reg;
          
		         qty_del := qty_del + sql%rowcount;
		  
                 if (mod(qty_del,10000) = 0) then
			      commit;
		    	 end if;
                
                 dbms_output.put_line('Linhas afetadas - receivable_unit_reg: ' || qty_del);
	   
	   
         end loop;
       end loop;
       close c_purge;
	   commit;
	   
       	exception
	      when OTHERS then
	        rollback;
	        dbms_output.put_line('[ERRO]: ' || to_char(SQLERRM) || CHR(10) || to_char(dbms_utility.format_error_backtrace));
	        dbms_output.put_line('--------------------------------');
    end; 
/