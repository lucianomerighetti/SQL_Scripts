select
    profile,
    resource_name,
    limit
from
    dba_profiles
where
    profile like 'PR%'
    and resource_name = 'SESSIONS_PER_USER';
    
    
ALTER PROFILE PR_RECEIVABLESUBR LIMIT SESSIONS_PER_USER 150; 
