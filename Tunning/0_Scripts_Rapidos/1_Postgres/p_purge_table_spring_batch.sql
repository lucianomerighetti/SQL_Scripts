do $$ 
declare

  p_ini date := '2020-08-23 00:00:00';
  p_fin date := '2020-12-31 00:00:00';
  v_date_purge date := null;
  v_step_execution_id integer := null;
  v_job_execution_id integer := null;
  v_job_instance_id integer := null;
 
 
begin 

  for v_date_purge in
    SELECT date_trunc('day', dd):: date
     FROM generate_series
        ( p_ini::timestamp 
        , p_fin::timestamp
        , '1 day'::interval) dd
        
	   
	loop
  
      raise notice 'Date Purge: %',v_date_purge;
	 
      for v_step_execution_id in
        select step_execution_id
        from fidc_adm.batch_step_execution_context
        where step_execution_id in (select step_execution_id 
                                    from fidc_adm.batch_step_execution
                                    where job_execution_id in (select job_execution_id 
                                                               from fidc_adm.batch_job_execution
                                                               where date_trunc('day',create_time) = v_date_purge))
	      loop
	     
	        delete 
	        from fidc_adm.batch_step_execution_context
	        where step_execution_id = v_step_execution_id;	     
	     
	      end loop;
            
	    
	  for v_job_execution_id in 
	    select job_execution_id 
        from fidc_adm.batch_job_execution
        where date_trunc('day',create_time) = v_date_purge
                                  
        loop 
           
          v_job_instance_id := null;
          
          select job_instance_id
          into v_job_instance_id
          from fidc_adm.batch_job_instance
          where job_instance_id = (select job_instance_id
                                   from fidc_adm.batch_job_execution
                                   where job_execution_id = v_job_execution_id);
        
          delete
          from fidc_adm.batch_step_execution
          where job_execution_id = v_job_execution_id;
         
          delete 
          from fidc_adm.batch_job_execution_params
          where job_execution_id = v_job_execution_id;
         
          delete 
          from fidc_adm.batch_job_execution_context
          where job_execution_id = v_job_execution_id;                
        
  	      delete 
          from fidc_adm.batch_job_execution
          where job_execution_id = v_job_execution_id;    

          delete
	      from fidc_adm.batch_job_instance
          where job_instance_id = v_job_instance_id;
         
        end loop;
       
        commit; 
        
      end loop;
     
END $$;	


-- Solução do problema de duplicidade

-- rodar e guardar os valores para jogar no ultimo delete                                   
select job_instance_id
from fidc_adm.batch_job_execution
group by job_instance_id
having count(*) >1

delete
from fidc_adm.batch_step_execution_context
where step_execution_id in (select step_execution_id 
                            from fidc_adm.batch_step_execution
                            where job_execution_id in (select job_execution_id
                                                       from fidc_adm.batch_job_execution
                                                       where job_instance_id in (select job_instance_id
                                                                                 from fidc_adm.batch_job_execution
                                                                                 group by job_instance_id
                                                                                 having count(*) >1)));


delete
from fidc_adm.batch_step_execution
where job_execution_id in (select job_execution_id
                           from fidc_adm.batch_job_execution
                           where job_instance_id in (select job_instance_id
                                                     from fidc_adm.batch_job_execution
                                                     group by job_instance_id
                                                     having count(*) >1));
         
delete 
from fidc_adm.batch_job_execution_params
where job_execution_id in (select job_execution_id
                           from fidc_adm.batch_job_execution
                           where job_instance_id in (select job_instance_id
                                                     from fidc_adm.batch_job_execution
                                                     group by job_instance_id
                                                     having count(*) >1));
         
delete 
from fidc_adm.batch_job_execution_context
where job_execution_id in (select job_execution_id
                           from fidc_adm.batch_job_execution
                           where job_instance_id in (select job_instance_id
                                                     from fidc_adm.batch_job_execution
                                                     group by job_instance_id
                                                     having count(*) >1));        
delete 
from fidc_adm.batch_job_execution
where job_execution_id in (select job_execution_id
                           from fidc_adm.batch_job_execution
                           where job_instance_id in (select job_instance_id
                                                     from fidc_adm.batch_job_execution
                                                     group by job_instance_id
                                                     having count(*) >1));
                         
delete 
from fidc_adm.batch_job_instance
where job_instance_id in ();                