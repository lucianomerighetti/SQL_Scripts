-- USUARIOS LIBERADOS DE FORMA INDEVIDA 
-- (ANTES DE PEDIR O BLOQUEIO, VALIDE SE O USUÁRIO REALMENTE É NOMINAL (PESQUISE O USUÁRIO NO TEAMS OU OUTLOOK))

select rp.grantee,granted_role
from dba_role_privs rp
where grantee in (select username
from dba_users
where 1=1
and account_status = 'OPEN'
--and created = trunc(sysdate) - 7
and profile not in ('PR_AD','PR_REDASH','C##PR_DBAASAGENTUBR','C##PR_DATAGOVERNANCE',
                    'C##PR_DMLEXECUBR','PR_DMLEXECUBR','C##PR_OGGUBR','C##PR_GSLBHEALTHCHECKUBR',
                    'PR_CASHIN_DEBTUBR','PR_CASHIN_DEBT_ADM')) 
and rp.granted_role not in ('RL_COMPLIANCE_SO','RL_COMPLIANCE_PII','RL_COMPLIANCE_PCI'
              ,'RL_COMPLIANCE_BS','RL_COMPLIANCE_SF','RL_COMPLIANCE_CRISIS')
and grantee not in ('SYS','SYSTEM','ADMINISTRADOR','DBSNMP','OGGUBR')
order by 1,2;    


-- USUÁRIOS LIBERADOS E QUE NAO ESTAO NOS PROFILES COMPLIANCE
select *
from dba_users
where 1=1
and account_status = 'OPEN'
--and created = trunc(sysdate) - 7
and profile not in ('PR_AD','PR_REDASH','C##PR_DBAASAGENTUBR','C##PR_DATAGOVERNANCE',
                    'C##PR_DMLEXECUBR','PR_DMLEXECUBR','C##PR_OGGUBR','C##PR_GSLBHEALTHCHECKUBR',
                    'PR_CASHIN_DEBTUBR','PR_CASHIN_DEBT_ADM')
order by created desc;


-- ROLES COMPLIANCE
select *
from dba_roles
where role IN ('RL_COMPLIANCE_SO','RL_COMPLIANCE_PII','RL_COMPLIANCE_PCI'
              ,'RL_COMPLIANCE_BS','RL_COMPLIANCE_SF','RL_COMPLIANCE_CRISIS');
              

-- CORRECAO DE USUARIO E BLOQUEIO

/*
Tablespaces para os usuários nominais, alterem para o ambiente correto

- DEFAULT_TABLESPACE = USERS
- TEMPORARY_TABLESPACE = TEMP para PagCloud e TSTEMP01 para Exadata 
- LOCAL_TEMP_TABLESPACE = TEMP para PagCloud e TSTEMP01 para Exadata 
*/

set pagesize 0
select distinct 'ALTER USER '||grantee||' PROFILE PR_DEV DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TSTEMP01 LOCAL TEMPORARY TABLESPACE TSTEMP01;'||CHR(10)||'ALTER USER '||grantee||' ACCOUNT LOCK;' script
from dba_role_privs rp
where grantee in (select username
from dba_users
where 1=1
and account_status = 'OPEN'
--and created = trunc(sysdate) - 7
and profile not in ('PR_AD','PR_REDASH','C##PR_DBAASAGENTUBR','C##PR_DATAGOVERNANCE',
                    'C##PR_DMLEXECUBR','PR_DMLEXECUBR','C##PR_OGGUBR','C##PR_GSLBHEALTHCHECKUBR',
                    'PR_CASHIN_DEBTUBR','PR_CASHIN_DEBT_ADM')) 
and rp.granted_role not in ('RL_COMPLIANCE_SO','RL_COMPLIANCE_PII','RL_COMPLIANCE_PCI'
              ,'RL_COMPLIANCE_BS','RL_COMPLIANCE_SF','RL_COMPLIANCE_CRISIS')
and grantee not in ('SYS','SYSTEM','ADMINISTRADOR','DBSNMP','OGGUBR');   