SELECT 
    pg_terminate_backend(pid) 
FROM 
    pg_stat_activity 
WHERE 
     pid <> pg_backend_pid()
AND datname = 'anticipation_data_service'
AND usename = 'manut_anticipation_data_service'
AND backend_start < current_date - interval '1 day';
