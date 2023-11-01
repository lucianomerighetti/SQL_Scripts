with sql_change_hash as (
  Select Ss.Snap_Id, Ss.Instance_Number Node, Begin_Interval_Time, Sql_Id, Plan_Hash_Value,
  nvl(executions_delta,0) execs,
  (elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000 avg_etime,
  (Buffer_Gets_Delta/Decode(Nvl(Buffer_Gets_Delta,0),0,1,Executions_Delta)) Avg_Lio
  From Dba_Hist_Sqlstat S, Dba_Hist_Snapshot Ss
  Where
  ss.snap_id = S.snap_id
  and ss.instance_number = S.instance_number
  And Executions_Delta > 0
  and begin_interval_time > sysdate - 1
  Order By 1, 2, 3)
Select s1.sql_id, s1.plan_hash_value hash_menor_tempo, s2.plan_hash_value hash_maior_tempo From (
Select Sql_Id, Plan_Hash_Value, Max(Begin_Interval_Time) Begin_Interval_Time,Max(Avg_Etime)Avg_Etime, Max(Avg_Lio)Avg_Lio
From   Sql_Change_Hash
Group By Sql_Id, Plan_Hash_Value) S1
Left Join (
Select Sql_Id, Plan_Hash_Value, Max(Begin_Interval_Time) Begin_Interval_Time,Max(Avg_Etime)Avg_Etime, Max(Avg_Lio)Avg_Lio
From   Sql_Change_Hash
Group By Sql_Id, Plan_Hash_Value) S2
On (S1.Sql_Id = S2.Sql_Id And S1.Plan_Hash_Value<>S2.Plan_Hash_Value And S2.Avg_Etime>S1.Avg_Etime*100 and (s1.Avg_Etime>=1 or s2.Avg_Etime>1))
where s2.sql_id is not null;




WITH bad AS (
	select SQL_ID, PLAN_HASH_VALUE, SUBSTR(SQL_TEXT,1,30) SQL_TEXT, MAX(LAST_ACTIVE_TIME) EXEC_TIME, SUM(EXECUTIONS) EXECUTIONS, 
		   ROUND(SUM(ELAPSED_TIME)/DECODE(SUM(EXECUTIONS),0,1,SUM(EXECUTIONS))/1e6,4) ELAPSED_TIME
	from gv$sql
	group by SQL_ID, PLAN_HASH_VALUE, SUBSTR(SQL_TEXT,1,30)
	having SUM(EXECUTIONS) >= 10 and ROUND(SUM(ELAPSED_TIME)/DECODE(SUM(EXECUTIONS),0,1,SUM(EXECUTIONS))/1e6,4) > 0.5
	   and MAX(LAST_ACTIVE_TIME) > sysdate-1),
good AS (
	select SQL_ID, PLAN_HASH_VALUE, MAX(EXEC_TIME) EXEC_TIME, SUM(EXECUTIONS) EXECUTIONS, ROUND(SUM(ELAPSED_TIME)/SUM(EXECUTIONS)/1e6,4) ELAPSED_TIME
	from
	(
		select SQL_ID, PLAN_HASH_VALUE, LAST_ACTIVE_TIME EXEC_TIME, EXECUTIONS, ELAPSED_TIME
		from gv$sql
		union all
		select SQL_ID, PLAN_HASH_VALUE, BEGIN_INTERVAL_TIME EXEC_TIME, EXECUTIONS_DELTA EXECUTIONS, ELAPSED_TIME_DELTA ELAPSED_TIME
		from DBA_HIST_SQLSTAT a, DBA_HIST_SNAPSHOT b
		where a.SNAP_ID=b.SNAP_ID and BEGIN_INTERVAL_TIME > sysdate-30 and PLAN_HASH_VALUE <> 0 and EXECUTIONS_DELTA > 0
	)
	group by SQL_ID, PLAN_HASH_VALUE
	having SUM(EXECUTIONS) >= 10
	)
select bad.SQL_ID, bad.PLAN_HASH_VALUE PLAN_BAD,  to_char(bad.EXEC_TIME, 'DD/MM/RR HH24:MI') LAST_EXEC, bad.EXECUTIONS, bad.ELAPSED_TIME TIME_EXEC_BAD, 
                  good.PLAN_HASH_VALUE PLAN_GOOD, to_char(good.EXEC_TIME,'DD/MM/RR HH24:MI') LAST_EXEC, good.EXECUTIONS, good.ELAPSED_TIME TIME_EXEC_GOOD,
				  round((bad.ELAPSED_TIME/good.ELAPSED_TIME-1)*100) pct_pior, SQL_TEXT
from bad, good
where bad.SQL_ID=good.SQL_ID and bad.PLAN_HASH_VALUE<>good.PLAN_HASH_VALUE and bad.ELAPSED_TIME>good.ELAPSED_TIME
  and bad.EXEC_TIME=(select MAX(LAST_ACTIVE_TIME) from gv$sql s where s.SQL_ID=bad.SQL_ID)
order by pct_pior desc
fetch first 30 rows only;