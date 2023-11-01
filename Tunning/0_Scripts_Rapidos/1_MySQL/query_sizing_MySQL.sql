SELECT table_schema "database name",
round((sum( data_length + index_length ) / 1024 / 1024 / 1024),2) "database size in GB",
round((sum( data_free )/ 1024 / 1024 / 1024),2) "free reclaimable space in GB"
FROM information_schema.TABLES
GROUP BY table_schema; 

SELECT 
     table_schema as 'Database', 
     table_name AS 'Table', 
     round(((data_length + index_length) / 1024 / 1024 / 1024), 2) 'Size in GB' 
FROM information_schema.TABLES 
WHERE table_schema = 'business_condition'
ORDER BY (data_length + index_length) DESC;


SELECT 
    CONCAT(FORMAT(DAT/POWER(1024,pw1),2),' ',SUBSTR(units,pw1*2+1,2)) DATSIZE,
    CONCAT(FORMAT(NDX/POWER(1024,pw2),2),' ',SUBSTR(units,pw2*2+1,2)) NDXSIZE,
    CONCAT(FORMAT(TBL/POWER(1024,pw3),2),' ',SUBSTR(units,pw3*2+1,2)) TBLSIZE
FROM
(
    SELECT DAT,NDX,TBL,IF(px>4,4,px) pw1,IF(py>4,4,py) pw2,IF(pz>4,4,pz) pw3
    FROM 
    (
        SELECT data_length DAT,index_length NDX,data_length+index_length TBL,
        FLOOR(LOG(IF(data_length=0,1,data_length))/LOG(1024)) px,
        FLOOR(LOG(IF(index_length=0,1,index_length))/LOG(1024)) py,
        FLOOR(LOG(data_length+index_length)/LOG(1024)) pz
        FROM information_schema.tables
        WHERE table_schema='business_condition'
        AND table_name='plan_client'
    ) AA
) A,(SELECT 'B KBMBGBTB' units) B;