use financial_turnover_adm;

drop procedure if exists p_purge_table_spring_batch;

delimiter $$

create procedure p_purge_table_spring_batch (in p_ini date, in p_fin date) 
bloco1:
begin
  declare v_purge_date date;
  declare done_purge_date boolean default false;

  declare c_purge_dates
    cursor for 
      select * from 
      (select adddate('1970-01-01',t4*10000 + t3*1000 + t2*100 + t1*10 + t0) gen_date from
      (select 0 t0 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,
      (select 0 t1 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,
      (select 0 t2 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,
      (select 0 t3 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,
      (select 0 t4 union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v
       where gen_date between p_ini and p_fin;
            
    declare continue handler for not found set done_purge_date = true;          
       
    open c_purge_dates;

      read_loop_purge_date: loop
      fetch c_purge_dates into v_purge_date;
        if done_purge_date then              
          leave read_loop_purge_date;
        end if;
       
      bloco2:
      begin 
        declare v_step_execution_id integer;          
        declare done_bsec boolean default false;   
             
        declare c_step_execution_id
          cursor for 
            select step_execution_id
            from financial_turnover_adm.batch_step_execution_context
            where step_execution_id in (select step_execution_id 
                                        from financial_turnover_adm.batch_step_execution
                                        where job_execution_id in (select job_execution_id 
                                                                   from financial_turnover_adm.batch_job_execution
                                                                   where date(create_time) = v_purge_date));
          
        declare continue handler for not found set done_bsec = true;
                 
          open c_step_execution_id;
            read_loop_step_execution_id: loop
            fetch c_step_execution_id into v_step_execution_id;
            if done_bsec then              
              leave read_loop_step_execution_id;
            end if;
             
            delete 
            from financial_turnover_adm.batch_step_execution_context
            where step_execution_id = v_step_execution_id;
            
            commit;
           
          end loop read_loop_step_execution_id;
          
          close c_step_execution_id; 
 
      end bloco2; 
     
      bloco3:
      begin
        declare v_job_execution_id integer;
        declare v_job_instance_id integer;
        declare done_je boolean default false;       
       
        declare c_job_execution_id
          cursor for
          	select job_execution_id 
            from financial_turnover_adm.batch_job_execution
            where date(create_time) = v_purge_date;
          
        declare continue handler for not found set done_je = true;
       
          open c_job_execution_id;
            read_loop_job_execution_id: loop
            fetch c_job_execution_id into v_job_execution_id;
            if done_je then              
              leave read_loop_job_execution_id;
            end if;

            set v_job_instance_id = null;
          
            select job_instance_id
            into v_job_instance_id
            from financial_turnover_adm.batch_job_instance
            where job_instance_id = (select job_instance_id
                                     from financial_turnover_adm.batch_job_execution
                                     where job_execution_id = v_job_execution_id);
        
            delete
            from financial_turnover_adm.batch_step_execution
            where job_execution_id = v_job_execution_id;
         
            delete 
            from financial_turnover_adm.batch_job_execution_params
            where job_execution_id = v_job_execution_id;
         
            delete 
            from financial_turnover_adm.batch_job_execution_context
            where job_execution_id = v_job_execution_id;                
        
  	        delete 
            from financial_turnover_adm.batch_job_execution
            where job_execution_id = v_job_execution_id;    

            delete
	        from financial_turnover_adm.batch_job_instance
            where job_instance_id = v_job_instance_id;     
         
           commit; 
         
         end loop read_loop_job_execution_id; 
      
      end bloco3;
     
    end loop read_loop_purge_date;

    commit;
   
    close c_purge_dates;
 
end bloco1;
$$      
delimiter ;


-- chamada da procedure
call p_purge_table_spring_batch ('2018-05-28','2018-05-29');

-- Solução do problema de duplicidade

-- rodar e guardar os valores para jogar no ultimo delete                                   
select job_instance_id
from financial_turnover_adm.batch_job_execution
group by job_instance_id
having count(*) >1

delete
from financial_turnover_adm.batch_step_execution_context
where step_execution_id in (select step_execution_id 
                            from financial_turnover_adm.batch_step_execution
                            where job_execution_id in (select job_execution_id
                                                       from financial_turnover_adm.batch_job_execution
                                                       where job_instance_id in (select job_instance_id
                                                                                 from financial_turnover_adm.batch_job_execution
                                                                                 group by job_instance_id
                                                                                 having count(*) >1)));


delete
from financial_turnover_adm.batch_step_execution
where job_execution_id in (select job_execution_id
                           from financial_turnover_adm.batch_job_execution
                           where job_instance_id in (select job_instance_id
                                                     from financial_turnover_adm.batch_job_execution
                                                     group by job_instance_id
                                                     having count(*) >1));
         
delete 
from financial_turnover_adm.batch_job_execution_params
where job_execution_id in (select job_execution_id
                           from financial_turnover_adm.batch_job_execution
                           where job_instance_id in (select job_instance_id
                                                     from financial_turnover_adm.batch_job_execution
                                                     group by job_instance_id
                                                     having count(*) >1));
         
delete 
from financial_turnover_adm.batch_job_execution_context
where job_execution_id in (select job_execution_id
                           from financial_turnover_adm.batch_job_execution
                           where job_instance_id in (select job_instance_id
                                                     from financial_turnover_adm.batch_job_execution
                                                     group by job_instance_id
                                                     having count(*) >1));        
delete 
from financial_turnover_adm.batch_job_execution
where job_execution_id in (select job_execution_id
                           from financial_turnover_adm.batch_job_execution
                           where job_instance_id in (select job_instance_id
                                                     from financial_turnover_adm.batch_job_execution
                                                     group by job_instance_id
                                                     having count(*) >1));
                         
delete 
from financial_turnover_adm.batch_job_instance
where job_instance_id in ();                