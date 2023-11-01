col "00" for 999
col "01" for 999
col "02" for 999
col "03" for 999
col "04" for 999
col "05" for 999
col "06" for 999
col "07" for 999
col "08" for 999
col "09" for 999
col "10" for 999
col "11" for 999
col "12" for 999
col "13" for 999
col "14" for 999
col "15" for 999
col "16" for 999
col "17" for 999
col "18" for 999
col "19" for 999
col "20" for 999
col "21" for 999
col "22" for 999
col "23" for 999
col total for 9999
col gb for 9999
select trunc(first_time) dia,


sum(decode(to_char(first_time,'HH24'),'00',1,0)) "00",
sum(decode(to_char(first_time,'HH24'),'01',1,0)) "01",
sum(decode(to_char(first_time,'HH24'),'02',1,0)) "02",
sum(decode(to_char(first_time,'HH24'),'03',1,0)) "03",
sum(decode(to_char(first_time,'HH24'),'04',1,0)) "04",
sum(decode(to_char(first_time,'HH24'),'05',1,0)) "05",
sum(decode(to_char(first_time,'HH24'),'06',1,0)) "06",
sum(decode(to_char(first_time,'HH24'),'07',1,0)) "07",
sum(decode(to_char(first_time,'HH24'),'08',1,0)) "08",
sum(decode(to_char(first_time,'HH24'),'09',1,0)) "09",
sum(decode(to_char(first_time,'HH24'),'10',1,0)) "10",
sum(decode(to_char(first_time,'HH24'),'11',1,0)) "11",
sum(decode(to_char(first_time,'HH24'),'12',1,0)) "12",
sum(decode(to_char(first_time,'HH24'),'13',1,0)) "13",
sum(decode(to_char(first_time,'HH24'),'14',1,0)) "14",
sum(decode(to_char(first_time,'HH24'),'15',1,0)) "15",
sum(decode(to_char(first_time,'HH24'),'16',1,0)) "16",
sum(decode(to_char(first_time,'HH24'),'17',1,0)) "17",
sum(decode(to_char(first_time,'HH24'),'18',1,0)) "18",
sum(decode(to_char(first_time,'HH24'),'19',1,0)) "19",
sum(decode(to_char(first_time,'HH24'),'20',1,0)) "20",
sum(decode(to_char(first_time,'HH24'),'21',1,0)) "21",
sum(decode(to_char(first_time,'HH24'),'22',1,0)) "22",
sum(decode(to_char(first_time,'HH24'),'23',1,0)) "23",count(*) TOTAL,
round(sum(blocks*block_size)/1024/1024/1024) GB
from v$archived_log
where TRUNC(FIRST_TIME) >= TRUNC(SYSDATE)-10
and creator not in ('RMAN','SRMN')
group by trunc(first_time)
order by 1;