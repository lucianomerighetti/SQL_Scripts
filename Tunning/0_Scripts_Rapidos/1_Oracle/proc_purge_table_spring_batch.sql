set echo on
set timing on
set serveroutput on
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
​
declare 
  p_ini date := '2020-07-07';
  p_fin date := '2020-07-10';

  v_job_instance_id contractmanager_adm.batch_job_instance.job_instance_id%TYPE := NULL; 
​
  cursor c_purge_dates is
    select distinct trunc(create_time) as date_purge
    from contractmanager_adm.batch_job_execution
    where trunc(create_time) between p_ini and p_fin
    order by trunc(create_time);
   
  cursor c_batch_step_execution_context (p_date_purge date) is
    select step_execution_id
    from contractmanager_adm.batch_step_execution_context
    where step_execution_id in (select step_execution_id 
                                from contractmanager_adm.batch_step_execution
                                where job_execution_id in (select job_execution_id 
                                                           from contractmanager_adm.batch_job_execution
                                                           where date_trunc('day',create_time) = v_date_purge));
                                                          
  cursor c_purge_date_ids (p_date_purge date) is
    select job_execution_id
    from contractmanager_adm.batch_job_execution
    where trunc(create_time) = p_date_purge;                                              
             
begin
			 
  for rdt in c_purge_dates loop
  
    FOR rsec IN c_batch_step_execution_context LOOP
    
      delete 
      from contractmanager_adm.batch_step_execution_context
      where step_execution_id = rsec.step_execution_id;    

      COMMIT;
     
    END LOOP;
     
    FOR rbje IN c_purge_date_ids LOOP
  
      v_job_instance_id := null;
          
      select job_instance_id
      into v_job_instance_id
      from contractmanager_adm.batch_job_instance
      where job_instance_id = (select job_instance_id
                               from contractmanager_adm.batch_job_execution
                               where job_execution_id = rbje.job_execution_id);
      
      delete
      from contractmanager_adm.batch_step_execution
      where job_execution_id = rbje.job_execution_id;
        
      delete 
      from contractmanager_adm.batch_job_execution_params
      where job_execution_id = rbje.job_execution_id;
         
      delete 
      from contractmanager_adm.batch_job_execution_context
      where job_execution_id = rbje.job_execution_id;                
        
  	  delete 
      from contractmanager_adm.batch_job_execution
      where job_execution_id = rbje.job_execution_id;    

      delete
	  from contractmanager_adm.batch_job_instance
      where job_instance_id = v_job_instance_id;
  
      COMMIT;
   
    END LOOP;
   
  end loop;  
​
  COMMIT;

exception
when OTHERS then
rollback;
end;
/