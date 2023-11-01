-- INTERNO

select ':: EXECUCAO DE SCRIPTS - NOVEMBRO/2022 ::' from dual;
SELECT    
    j.userid AD,
    count(1) QTDE_EXECUCOES_SCRIPTS
FROM
    dbaascloudcontrol_adm.dmlexec_job_status    j
WHERE date_executed between to_date('2022-11-01','yyyy-MM-dd hh24:mi:ss') and to_date('2022-11-30','yyyy-MM-dd hh24:mi:ss')    
AND upper(j.userid) IN ('SMOREIRA','IVE_TTERRA','FSILVA2','IDD_UAVELAR','GLTHOMAZ','KPS_LMARWELL','THCASTANHEIR','LUCGUERREIRO','MIR_LUINUNES')
and j.result = 'SUCCESS'
GROUP BY j.userid
ORDER BY 2 DESC;
SELECT    
    count(1) TOTAL
FROM
    dbaascloudcontrol_adm.dmlexec_job_status    j
WHERE date_executed between to_date('2022-11-01','yyyy-MM-dd hh24:mi:ss') and to_date('2022-11-30','yyyy-MM-dd hh24:mi:ss')    
AND upper(j.userid) IN ('SMOREIRA','IVE_TTERRA','FSILVA2','IDD_UAVELAR','GLTHOMAZ','KPS_LMARWELL','THCASTANHEIR','LUCGUERREIRO','MIR_LUINUNES')
and j.result = 'SUCCESS';


-- GERENCIA THIAGAO

select ':: EXECUCAO DE SCRIPTS - FEVEREIRO / 2023 ::' from dual;
SELECT    
    CASE WHEN UPPER(j.userid) = 'SMOREIRA' THEN 'ESPEC'
         WHEN UPPER(j.userid) = 'IVE_TTERRA' THEN 'RECEBIVEIS\CESSAO'
         WHEN UPPER(j.userid) IN ('FSILVA2','THCASTANHEIR') THEN 'BC\SLC'         
         WHEN UPPER(j.userid) = 'IDD_UAVELAR' THEN 'CASHOUT'
         WHEN UPPER(j.userid) IN ('GLTHOMAZ','MIR_LUINUNES') THEN 'RECEBIVEIS\LIBERACAO-LIQUIDACAO'         
         WHEN UPPER(j.userid) = 'KPS_LMARWELL' THEN 'RECEBIVEIS\AGENDA'
         WHEN UPPER(j.userid) = 'LUCGUERREIRO' THEN 'RECEBIVEIS\COMPLIANCE'    
         ELSE 'NULO' 
    END Domain,
    count(1) QTDE_EXECUCOES_SCRIPTS
FROM
    dbaascloudcontrol_adm.dmlexec_job_status    j
WHERE date_executed between to_date('2023-02-01','yyyy-MM-dd hh24:mi:ss') and to_date('2023-02-28','yyyy-MM-dd hh24:mi:ss')    
AND upper(j.userid) IN ('SMOREIRA','IVE_TTERRA','FSILVA2','IDD_UAVELAR','GLTHOMAZ','KPS_LMARWELL','THCASTANHEIR','LUCGUERREIRO','MIR_LUINUNES')
and j.result = 'SUCCESS'
GROUP BY     CASE WHEN UPPER(j.userid) = 'SMOREIRA' THEN 'ESPEC'
         WHEN UPPER(j.userid) = 'IVE_TTERRA' THEN 'RECEBIVEIS\CESSAO'
         WHEN UPPER(j.userid) IN ('FSILVA2','THCASTANHEIR') THEN 'BC\SLC'         
         WHEN UPPER(j.userid) = 'IDD_UAVELAR' THEN 'CASHOUT'
         WHEN UPPER(j.userid) IN ('GLTHOMAZ','MIR_LUINUNES') THEN 'RECEBIVEIS\LIBERACAO-LIQUIDACAO'         
         WHEN UPPER(j.userid) = 'KPS_LMARWELL' THEN 'RECEBIVEIS\AGENDA'
         WHEN UPPER(j.userid) = 'LUCGUERREIRO' THEN 'RECEBIVEIS\COMPLIANCE'    
         ELSE 'NULO' 
    END
ORDER BY 2 DESC;
SELECT    
    count(1) TOTAL
FROM
    dbaascloudcontrol_adm.dmlexec_job_status    j
WHERE date_executed between to_date('2023-02-01','yyyy-MM-dd hh24:mi:ss') and to_date('2023-02-28','yyyy-MM-dd hh24:mi:ss')    
AND upper(j.userid) IN ('SMOREIRA','IVE_TTERRA','FSILVA2','IDD_UAVELAR','GLTHOMAZ','KPS_LMARWELL','THCASTANHEIR','LUCGUERREIRO','MIR_LUINUNES')
and j.result = 'SUCCESS';

-- DIRETORIA

select ':: EXECUCAO DE SCRIPTS - NOVEMBRO/2022 ::' from dual;
SELECT    
    j.userid AD,
    count(1) QTDE_EXECUCOES_SCRIPTS
FROM
    dbaascloudcontrol_adm.dmlexec_job_status    j
WHERE date_executed between to_date('2022-11-01','yyyy-MM-dd hh24:mi:ss') and to_date('2022-11-30','yyyy-MM-dd hh24:mi:ss')    
AND upper(j.userid) IN ('ACOQUETO','JRAMIA','SMOREIRA','GARODRIGUES','FSILVA2','GLTHOMAZ','MADUTRA','IDD_UAVELAR','KPS_LMARWELL','KPS_DOLIVEIRA','IVE_TTERRA','PVE_WRODRIGUES','THCASTANHEIR','LUCGUERREIRO','VBERGAMIN','LVILLAR','PEO_DICUNHA','MIR_LUINUNES','ECD_ANDMAIA')
and j.result = 'SUCCESS'
GROUP BY j.userid
ORDER BY 2 DESC;
SELECT    
    count(1) TOTAL
FROM
    dbaascloudcontrol_adm.dmlexec_job_status    j
WHERE date_executed between to_date('2022-11-01','yyyy-MM-dd hh24:mi:ss') and to_date('2022-11-30','yyyy-MM-dd hh24:mi:ss')    
AND upper(j.userid) IN ('ACOQUETO','JRAMIA','SMOREIRA','GARODRIGUES','FSILVA2','GLTHOMAZ','MADUTRA','IDD_UAVELAR','KPS_LMARWELL','KPS_DOLIVEIRA','IVE_TTERRA','PVE_WRODRIGUES','THCASTANHEIR','LUCGUERREIRO','VBERGAMIN','LVILLAR','PEO_DICUNHA','MIR_LUINUNES','ECD_ANDMAIA')
and j.result = 'SUCCESS';


