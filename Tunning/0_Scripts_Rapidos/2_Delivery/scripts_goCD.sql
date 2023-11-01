select * from SAFEPAY_ADM."schema_version" 
where "version" like '7.132%'
order by substr("version",1,4),  substr("version",6,1),  lpad(substr("version",8,2),2,0);