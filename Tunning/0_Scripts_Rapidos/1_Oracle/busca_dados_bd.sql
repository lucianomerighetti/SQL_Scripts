-- detalhado

SELECT dt.connection_string_app
,db.database_identifier
,di.hostname
,dt.server_pool
,db.isactive isactivedb
,dt.isactive isactivedt
,dc.database_software
,h.environment
,h.datacenter_provider_region
,h.vlanepg
,t.dmlexec_scripts_repository
,t.topdomains
,t.domains
,t.subdomains
,t.topchannels
,t.channels
,t.company_name
,t.business_unit
,t.reliability_engineer
,t.owner_team
,t.email_notification
,t.incident_queue
,t.slack_channel
,t.escalation_list
,t.product
,t.application_name
,t.service_level_criticity
,t.ispci
,t.ispii
,t.issox
,t.isbanking_secrecy
,t.isstrategic_operational
,t.isstrategic_financial
,t.isnot_security_apply
,t.islgpd
,t.isgdpr
,t.isbacen
,t.isanbima
--,dt.hash_gaudi
FROM dbaascloudcontrol_adm.databases db
LEFT JOIN dbaascloudcontrol_adm.database_tenants dt
on db.database_endpoint = dt.gslb
INNER JOIN dbaascloudcontrol_adm.database_containers dc
on db.database_container_identifier = dc.database_container_identifier
INNER JOIN dbaascloudcontrol_adm.database_instances di
on db.database_container_identifier = di.database_container_identifier
INNER JOIN dbaascloudcontrol_adm.cmdb_hosts h
on di.hostname = h.hostname
INNER JOIN  dbaascloudcontrol_adm.database_tags t
on t.database_identifier = db.database_identifier
WHERE upper(db.database_endpoint) like '%LIQUIDATOR%';

-- por ambiente
SELECT 
h.environment
,count(DISTINCT db.database_endpoint) qty
FROM dbaascloudcontrol_adm.databases db
INNER JOIN dbaascloudcontrol_adm.database_instances di
on db.database_container_identifier = di.database_container_identifier
INNER JOIN dbaascloudcontrol_adm.cmdb_hosts h
on di.hostname = h.hostname
INNER JOIN  dbaascloudcontrol_adm.database_tags t
on t.database_identifier = db.database_identifier
WHERE 1=1
and ((h.datacenter_provider_region = 'glete') or ((h.datacenter_provider_region like 'us-east-1%') or (h.datacenter_provider_region like 'sa-east-1%')))
and t.reliability_engineer in ('basileia','madripoor','wessex','eternia')
and db.database_identifier not like 'arn:%'
and db.isactive = 1
group by h.environment
order by 2 desc
;

-- por SGBD
SELECT 
dc.database_software
,count(DISTINCT db.database_endpoint) qty
FROM dbaascloudcontrol_adm.databases db
INNER JOIN dbaascloudcontrol_adm.database_containers dc
on db.database_container_identifier = dc.database_container_identifier
INNER JOIN dbaascloudcontrol_adm.database_instances di
on db.database_container_identifier = di.database_container_identifier
INNER JOIN dbaascloudcontrol_adm.cmdb_hosts h
on di.hostname = h.hostname
INNER JOIN  dbaascloudcontrol_adm.database_tags t
on t.database_identifier = db.database_identifier
WHERE 1=1
and ((h.datacenter_provider_region = 'glete') or ((h.datacenter_provider_region like 'us-east-1%') or (h.datacenter_provider_region like 'sa-east-1%')))
and t.reliability_engineer in ('basileia','madripoor','wessex','eternia')
and db.database_identifier not like 'arn:%'
and db.isactive = 1
group by dc.database_software
order by 2 desc
;

-- por datacenter
SELECT  
h.datacenter_provider
,count(DISTINCT db.database_endpoint) qty
FROM dbaascloudcontrol_adm.databases db
INNER JOIN dbaascloudcontrol_adm.database_containers dc
on db.database_container_identifier = dc.database_container_identifier
INNER JOIN dbaascloudcontrol_adm.database_instances di
on db.database_container_identifier = di.database_container_identifier
INNER JOIN dbaascloudcontrol_adm.cmdb_hosts h
on di.hostname = h.hostname
INNER JOIN  dbaascloudcontrol_adm.database_tags t
on t.database_identifier = db.database_identifier
WHERE 1=1
and ((h.datacenter_provider_region = 'glete') or ((h.datacenter_provider_region like 'us-east-1%') or (h.datacenter_provider_region like 'sa-east-1%')))
and t.reliability_engineer in ('basileia','madripoor','wessex','eternia')
and db.database_identifier not like 'arn:%'
and db.isactive = 1
group by h.datacenter_provider
order by 2 desc
;

-- outros levantamentos
SELECT 
DISTINCT db.database_endpoint
--COUNT(DISTINCT db.database_endpoint) qty
FROM dbaascloudcontrol_adm.databases db
INNER JOIN dbaascloudcontrol_adm.database_instances di
on db.database_container_identifier = di.database_container_identifier
INNER JOIN dbaascloudcontrol_adm.cmdb_hosts h
on di.hostname = h.hostname
INNER JOIN  dbaascloudcontrol_adm.database_tags t
on t.database_identifier = db.database_identifier
WHERE 1=1
and ((h.datacenter_provider_region = 'glete') or ((h.datacenter_provider_region like 'us-east-1%') 
     or (h.datacenter_provider_region like 'sa-east-1%')))
and t.reliability_engineer in ('basileia','madripoor','wessex','eternia')
and db.database_identifier not like 'arn:%'
and db.isactive = 1
--and (t.ispii = 1 or t.issox = 1)
--and h.environment = 'PROD';