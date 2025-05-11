declare
    v_owner    varchar2(30)  default 'SYSDBPROUNIINSCRICAO';
    v_nome_job varchar2(30)  default 'JOB_TEST';
    v_job      varchar2(30)  default v_owner || '.' || v_nome_job;
    v_desc_job varchar2(100) default 'Descrição do JOB';
    v_numb_job number(10)    default 0;
begin
    begin 
        dbms_scheduler.disable(v_nome_job);

        dbms_scheduler.drop_job(job_name => v_job, defer => false, force => false);
    exception
        when others then null;
    end;
    dbms_scheduler.create_job (
            job_name            => v_job,
            job_type            => 'PLSQL_BLOCK',
            job_action          => '
begin

    delete from tmp_local_oferta_657783;

    commit;
end;
',
            number_of_arguments => 0,
            start_date          => to_timestamp_tz('2024-08-09 00:00:00.000000000 AMERICA/SAO_PAULO','YYYY-MM-DD HH24:MI:SS.FF TZR'),
            repeat_interval     => 'FREQ=DAILY;
                                    BYTIME=084000,184000;
                                    BYDAY=MON,TUE,WED,THU,FRI,SAT,SUN',
            end_date            => to_timestamp_tz('2024-08-14 23:59:59.000000000 AMERICA/SAO_PAULO','YYYY-MM-DD HH24:MI:SS.FF TZR'),
            enabled             => false,
            auto_drop           => false,
            comments            => v_desc_job
    );
    dbms_scheduler.set_attribute(name => v_job, attribute => 'store_output',     value => TRUE);
    dbms_scheduler.set_attribute(name => v_job, attribute => 'logging_level',    value => DBMS_SCHEDULER.LOGGING_FULL);
    dbms_scheduler.set_attribute(name => v_job, attribute => 'raise_events',     value => '1');
    --dbms_scheduler.set_attribute(name => v_job, attribute => 'max_failures',     value => 1);
    --dbms_scheduler.set_attribute(name => v_job, attribute => 'max_runs',         value => 1);
    dbms_scheduler.set_attribute(name => v_job, attribute => 'max_run_duration', value => to_dsinterval('+00 01:00:00.000000'));
    dbms_scheduler.set_attribute(name => v_job, attribute => 'schedule_limit',   value => to_dsinterval('+00 01:00:00.000000'));
    dbms_scheduler.enable(name => v_job);
    
    dbms_scheduler.run_job(job_name => v_job, use_current_session => false);
end;
/