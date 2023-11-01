-- valida se existe baselines setados
select *
from dba_sql_plan_baselines
where enabled = 'YES';
-- ENABLED --> ESTÁ HABILITADO PARA USO
-- ACCEPTED --> FOI AVALIADO E ACEITO PARA USO
-- FIXED --> SEU USO ESTÁ PRIORIZADO

-- valida se existe profiles setados
select *
from dba_sql_profiles
where status = 'ENABLED';

-- valida qual plano está sendo executado no momento
select sql_id, plan_hash_value
from v$sql
where sql_id = '2kw741udhdkbc';

-- apagar baseline
var cnt number;
exec :cnt := DBMS_SPM.DROP_SQL_PLAN_BASELINE (sql_handle => 'SQL_40647464f2b923e0', plan_name => 'SQL_PLAN_40t3ncmtbk8z066e78c06');
print cnt


-- setar baseline via hash_value
exec dbms_sqltune.create_sqlset(sqlset_name => 'SQLTUNINGSET_2kw741udhdkbc');

DECLARE
  cur sys_refcursor;
BEGIN
  open cur for
    select value(p) from table(
      dbms_sqltune.select_workload_repository(
        begin_snap => 70434,
        end_snap => 70435,
        basic_filter => 'sql_id = ''2kw741udhdkbc'' AND plan_hash_value = 1367352036')) p;
    dbms_sqltune.load_sqlset('SQLTUNINGSET_2kw741udhdkbc', cur);
  close cur;
END;
/


variable cnt number;
exec :cnt := DBMS_SPM.LOAD_PLANS_FROM_SQLSET(sqlset_name => 'SQLTUNINGSET_2kw741udhdkbc', fixed => 'YES');
print cnt





exec dbms_sqltune.create_sqlset(sqlset_name => 'SQLTUNINGSET_2kw741udhdkbc_bad');

DECLARE
  cur sys_refcursor;
BEGIN
  open cur for
    select value(p) from table(
      dbms_sqltune.select_workload_repository(
        begin_snap => 70434,
        end_snap => 70435,
        basic_filter => 'sql_id = ''2kw741udhdkbc'' AND plan_hash_value = 2922645958')) p;
    dbms_sqltune.load_sqlset('SQLTUNINGSET_2kw741udhdkbc_bad', cur);
  close cur;
END;
/

 

variable cnt number;
exec :cnt := DBMS_SPM.LOAD_PLANS_FROM_SQLSET(sqlset_name => 'SQLTUNINGSET_2kw741udhdkbc_bad', enabled => 'NO');
print cnt