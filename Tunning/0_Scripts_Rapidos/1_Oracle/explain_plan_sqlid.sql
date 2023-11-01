SELECT * FROM table(DBMS_XPLAN.DISPLAY_CURSOR('cc0t5ukzdbhgq',0));

select * from TABLE(dbms_xplan.display_awr('fqbygkcpkw9dk'));


select 'SELECT * FROM table(DBMS_XPLAN.DISPLAY_CURSOR('''||sql_id||''','||child_number||'));'
from   gv$sql 
where sql_id='fqbygkcpkw9dk' and rownum=1;