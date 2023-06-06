select
    profile,
    resource_name,
    limit
from
    dba_profiles
where
    profile = 'PR_RECEIVABLES_ADM'
    and resource_name = 'SESSIONS_PER_USER';
--    profile like 'PR%'
--    profile in ('PR_AD', 'PR_BI', 'PR_BIGDATA', 'PR_DBA', 'PR_DEV', 'PR_DS', 'PR_GOV', 'PR_MANUT_RECEIVABLES', 'PR_REDASH', 'PR_SEC')
--    and resource_name = 'IDLE_TIME';
    
--Reduzir o numero de sessões 
-- De 10 para 5
ALTER PROFILE PR_THANATOS_ADM    LIMIT SESSIONS_PER_USER 5; 
ALTER PROFILE PR_TURKANAUBR      LIMIT SESSIONS_PER_USER 5; 
ALTER PROFILE PR_SUMMARIZEJOBUBR LIMIT SESSIONS_PER_USER 5; 
ALTER PROFILE PR_RECEIVABLES_ADM LIMIT SESSIONS_PER_USER 5; 

--Aumentar o numero de sessões
-- De 80 para 100
ALTER PROFILE PR_RECEIVABLESUBR LIMIT SESSIONS_PER_USER 100; 
