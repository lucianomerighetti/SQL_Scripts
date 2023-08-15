--------------------------------------------------------------------------------
-- Horários da Coleta Diária
--------------------------------------------------------------------------------
select client_name,
       window_name,
       window_start_time,
       window_duration,
       job_status,
       job_start_time,
       job_duration,
       job_error,
       job_info
  from dba_autotask_job_history
 where window_start_time >= trunc(sysdate) - 1
 order by 6, 5;
 
select window_name,
       repeat_interval,
       duration,
       next_start_date,
       last_start_date,
       enabled
  from dba_scheduler_windows;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- O padrão do fuso horário da coleta é o Oceano Pacífico (PST8PDT, -5 horas que o BR), logo a primeira ação é alterar o fuso horário para o de São Paulo.
--------------------------------------------------------------------------------
execute dbms_scheduler.set_scheduler_attribute('DEFAULT_TIMEZONE', 'America/Sao_Paulo');
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Valida STATUS das coletas de tabelas/partições
--------------------------------------------------------------------------------
select x.owner,
       x.table_name,
       --------------------
       --x.object_type,
       --x.partition_name,
       --x.partition_position,
       --------------------
       nvl(x.qtd_linhas, 0)             qtd_linhas,
       nvl(x.qtd_ins_pos_coleta, 0)     qtd_ins_pos_coleta,
       nvl(x.qtd_upd_pos_coleta, 0)     qtd_upd_pos_coleta,
       nvl(x.qtd_del_pos_coleta, 0)     qtd_del_pos_coleta,
       nvl(x.qtd_segmentos_apagados, 0) qtd_segmentos_apagados,
       nvl(x.qtd_total_dml, 0)          qtd_total_dml,
       nvl(x.stale_percent_real, 0)     stale_percent_real,
       x.stale_percent_target,
       x.coleta_desatualizada,
       x.ultima_coleta
  from ( select s.owner,
                s.table_name,
                --------------------
                --s.object_type,
                --s.partition_name,
                --s.partition_position,
                --------------------
                s.num_rows                                        qtd_linhas,
                nvl(tm.qtd_ins_pos_coleta, 0)                     qtd_ins_pos_coleta,
                nvl(tm.qtd_upd_pos_coleta, 0)                     qtd_upd_pos_coleta,
                nvl(tm.qtd_del_pos_coleta, 0)                     qtd_del_pos_coleta,
                nvl(tm.qtd_segmentos_apagados, 0)                 qtd_segmentos_apagados,
                nvl(tm.total_dml, 0)                              qtd_total_dml,
                round((((tm.total_dml * 100) / nvl(decode(s.num_rows, 0, 1, s.num_rows),1))), 2) stale_percent_real,
                nvl(sp.preference_value, dbms_stats.get_prefs('STALE_PERCENT',s.owner, '"' || s.table_name || '"')) stale_percent_target,
                s.stale_stats                                     coleta_desatualizada,
                to_char(s.last_analyzed, 'YYYY-MM-DD HH24:MI:SS') ultima_coleta
           from dba_tab_statistics s
                left join (select m.table_owner,
                                  m.table_name,
                                  sum(nvl(m.inserts, 0))                         qtd_ins_pos_coleta,
                                  sum(nvl(m.updates, 0))                         qtd_upd_pos_coleta,
                                  sum(nvl(m.deletes, 0))                         qtd_del_pos_coleta,
                                  sum(nvl(m.drop_segments, 0))                   qtd_segmentos_apagados,
                                  sum(nvl(m.inserts + m.updates + m.deletes, 0)) total_dml
                             from dba_tab_modifications m
                            where m.table_owner = substr(sys_context('USERENV', 'DB_NAME'),4, 50) || '_ADM'
                            group by m.table_owner,
                                     m.table_name) tm on (s.owner      = tm.table_owner and
                                                          s.table_name = tm.table_name)
                left join dba_tab_stat_prefs sp on (sp.owner           = s.owner and
                                                    sp.table_name      = s.table_name and
                                                    sp.preference_name = 'STALE_PERCENT')
          where s.owner = substr(sys_context('USERENV', 'DB_NAME'), 4, 50) || '_ADM'
            and s.object_type = 'TABLE'
            and s.global_stats = 'YES'
            --------------------
            --and s.last_analyzed is not null
            --------------------
       ) x
 order by 9 desc,
          x.ultima_coleta desc,
          x.coleta_desatualizada desc;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Valida STATUS das coletas de indices/partições
--------------------------------------------------------------------------------
select --------------------
       --s.owner              "SCHEMA",
       --s.table_name         "TABELA",
       --------------------
       s.index_name         "INDICE",
       --------------------
       --s.object_type        "TIPO DO OBJETO",
       --s.partition_name     "NOME DA PARTIÇÃO",
       --s.partition_position "POSIÇÃO DA PARTIÇÃO",
       --------------------
       s.num_rows           "QTD. DE LINHAS",
       s.stale_stats        "COLETA DESATUALIZADA",
       to_char(s.last_analyzed, 'YYYY-MM-DD HH24:MI:SS') "ULTIMA COLETA"
  from sys.dba_ind_statistics s
 where s.owner = substr(sys_context('USERENV', 'DB_NAME'), 4, 50) || '_ADM'
   and s.object_type = 'INDEX'
   --------------------
   -- and s.last_analyzed is not null
   --------------------
 order by s.last_analyzed desc; 
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Coleta de Colunas
--------------------------------------------------------------------------------
select s.owner       "SCHEMA",
       s.table_name  "TABELA",
       s.column_name "COLUNA",
       to_char(s.last_analyzed, 'YYYY-MM-DD HH24:MI:SS') "ULTIMA COLETA",
       s.histogram
  from sys.dba_tab_col_statistics s
 where s.owner = substr(sys_context('USERENV', 'DB_NAME'), 4, 50) || '_ADM';
--   and s.table_name = 'REG_CONTRACTUAL_EFFECT';
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Verifica Histogramas Pendentes
--------------------------------------------------------------------------------
select * from dba_tab_histgrm_pending_stats;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Verifica Parametros da Coleta de Estatística
--------------------------------------------------------------------------------
select s.owner,
       s.table_name,
       dbms_stats.get_prefs('CASCADE',s.owner, '"' || s.table_name ||'"')                        cascade,
       dbms_stats.get_prefs('CONCURRENT',s.owner, '"' || s.table_name ||'"')                     concurrent,
       dbms_stats.get_prefs('DEGREE',s.owner, '"' || s.table_name ||'"')                         degree,
       dbms_stats.get_prefs('ESTIMATE_PERCENT',s.owner, '"' || s.table_name ||'"')               estimate_percent,
       dbms_stats.get_prefs('INCREMENTAL',s.owner, '"' || s.table_name ||'"')                    incremental,
       dbms_stats.get_prefs('INCREMENTAL_STALENESS',s.owner, '"' || s.table_name ||'"')          incremental_staleness,
       dbms_stats.get_prefs('INCREMENTAL_LEVEL',s.owner, '"' || s.table_name ||'"')              incremental_level,
       dbms_stats.get_prefs('NO_INVALIDATE',s.owner, '"' || s.table_name ||'"')                  no_invalidate,
       dbms_stats.get_prefs('OPTIONS',s.owner, '"' || s.table_name ||'"')                        options,
       dbms_stats.get_prefs('STALE_PERCENT',s.owner, '"' || s.table_name ||'"')                  stale_percent,
       dbms_stats.get_prefs('STAT_CATEGORY',s.owner, '"' || s.table_name ||'"')                  stat_category,
       dbms_stats.get_prefs('TABLE_CACHED_BLOCKS',s.owner, '"' || s.table_name ||'"')            table_cached_blocks,
       dbms_stats.get_prefs('WAIT_TIME_TO_UPDATE_STATS',s.owner, '"' || s.table_name ||'"')      wait_time_to_update_stats,
       dbms_stats.get_prefs('APPROXIMATE_NDV_ALGORITHM',s.owner, '"' || s.table_name ||'"')      approximate_ndv_algorithm,
       dbms_stats.get_prefs('AUTO_STAT_EXTENSIONS',s.owner, '"' || s.table_name ||'"')           auto_stat_extensions,
       dbms_stats.get_prefs('AUTO_TASK_STATUS',s.owner, '"' || s.table_name ||'"')               auto_task_status,
       dbms_stats.get_prefs('AUTO_TASK_MAX_RUN_TIME',s.owner, '"' || s.table_name ||'"')         auto_task_max_run_time,
       dbms_stats.get_prefs('AUTO_TASK_INTERVAL',s.owner, '"' || s.table_name ||'"')             auto_task_interval,
       dbms_stats.get_prefs('GLOBAL_TEMP_TABLE_STATS',s.owner, '"' || s.table_name ||'"')        global_temp_table_stats,
       dbms_stats.get_prefs('GRANULARITY',s.owner, '"' || s.table_name ||'"')                    granularity,
       dbms_stats.get_prefs('METHOD_OPT',s.owner, '"' || s.table_name ||'"')                     method_opt,
       dbms_stats.get_prefs('PREFERENCE_OVERRIDES_PARAMETER',s.owner, '"' || s.table_name ||'"') preference_overrides_parameter,
       dbms_stats.get_prefs('PUBLISH',s.owner, '"' || s.table_name ||'"')                        publish
  from dba_tab_statistics s
 where s.owner = substr(sys_context('USERENV', 'DB_NAME'), 4, 50) || '_ADM';
--------------------------------------------------------------------------------