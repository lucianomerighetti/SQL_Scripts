SELECT 
    c.name 
FROM
    sys.objects o
INNER JOIN
    sys.columns c
ON
    c.object_id = o.object_id;
	
select *
from sys.tables;	
	
	